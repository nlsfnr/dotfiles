#!/usr/bin/env python3
import datetime
import json
import re
import sys
import threading
import time
import select
from subprocess import run
from functools import wraps
from typing import Optional, TypeVar, Callable, Any
import logging
import traceback

import psutil

logger = logging.getLogger("status_script")


_prev_batt = 100


CallableT = TypeVar('CallableT', bound=Callable[..., str])


def try_or_error(error: str) -> Callable[[CallableT], CallableT]:
    def wrapper(fn: Callable[..., str]) -> Callable[..., str]:
        @wraps(fn)
        def wrapped(*args: Any, **kwargs: Any) -> Any:
            try:
                return fn(*args, **kwargs)
            except Exception as e:
                return error
        return wrapped
    return wrapper  # type: ignore


@try_or_error("ERR")
def get_battery() -> str:
    global _prev_batt
    cmd = ['upower', '-i', '/org/freedesktop/UPower/devices/battery_BAT0']
    out = str(run(cmd, capture_output=True).stdout)
    lines = re.findall(r'percentage:.*[0-9]+%', out)
    if not lines:
        return "ERR"
    line, *_ = lines
    batt, *_ = re.findall(r'[0-9]+%', line)
    batt_percent = float(batt.strip('%'))
    if batt_percent <= 5 and _prev_batt > 5:
        notify(f"Critical battery: {batt}")
    elif batt_percent <= 10 and _prev_batt > 10:
        notify(f"Critical battery: {batt}")
    elif batt_percent <= 20 and _prev_batt > 20:
        notify(f"Low battery: {batt}")
    _prev_batt = batt_percent
    return batt


@try_or_error("ERR")
def get_gpu_usage() -> str:
    # Get GPU usage
    cmd = ['nvidia-smi', '--query-gpu=utilization.gpu', '--format=csv,noheader']
    usage = run(cmd, capture_output=True).stdout.decode('utf-8').strip()
    without_mib = lambda x: int(x.decode('utf-8').strip().strip('MiB').strip())
    # Get GPU memory usage
    cmd = ['nvidia-smi', '--query-gpu=memory.used', '--format=csv,noheader']
    mem_usage = without_mib(run(cmd, capture_output=True).stdout)
    # Get total GPU memory
    cmd = ['nvidia-smi', '--query-gpu=memory.total', '--format=csv,noheader']
    mem_total = without_mib(run(cmd, capture_output=True).stdout)
    return f"{usage} {mem_usage}/{mem_total} M"


_CPU_EMA = None
_CPU_EMA_ALPHA = 0.5


@try_or_error("ERR")
def get_cpu_usage() -> str:
    global _CPU_EMA
    if _CPU_EMA is None:
        _CPU_EMA = psutil.cpu_percent()
    else:
        _CPU_EMA = (_CPU_EMA * _CPU_EMA_ALPHA
                    + psutil.cpu_percent() * (1 - _CPU_EMA_ALPHA))
    mem = psutil.virtual_memory()
    total = mem.total / 1024 / 1024
    return f"{_CPU_EMA:.1f}% {mem.used / 1024**3:.1f}/{total/1024:.1f} G"


class Loop(threading.Thread):

    def __init__(
        self,
        termination_event: threading.Event,
    ) -> None:
        super().__init__()
        self._exception = None
        self._termination_event = termination_event

    def run(self) -> None:
        try:
            self.loop()
        except Exception as e:
            self._exception = e
            self._termination_event.set()

    def loop(self) -> None:
        raise NotImplementedError()

    def join(self, timeout: Optional[float] = None) -> None:
        super().join(timeout)
        if self._exception is not None:
            self._termination_event.set()
            log_exception(self._exception)
            raise self._exception


class StatusLoop(Loop):

    def loop(self) -> None:
        write("[")
        while True:
            if self._termination_event.is_set():
                logger.info("Terminating status loop")
                return
            status = [
                dict(
                    name="cpu",
                    full_text=f"CPU: {get_cpu_usage()}",
                    color="#FFFFFF",
                    background="#220000",
                ),
                dict(
                    name="gpu",
                    full_text=f"GPU: {get_gpu_usage()}",
                    color="#FFFFFF",
                    background="#000022",
                ),
                dict(
                    name="battery",
                    full_text=f"BAT: {get_battery()}",
                    color="#FFFFFF",
                    background="#002200",
                ),
                dict(
                    name="time",
                    full_text=f"{datetime.datetime.now().strftime('%b %d %H:%M:%S')}",
                    color="#FFFFFF",
                    background="#000000",
                ),
            ]
            write(json.dumps(status) + ",\n")
            time.sleep(0.1)


class EventLoop(Loop):

    def loop(self) -> None:
        while True:
            while True:
                # Check if stdin contains data with a timeout of 0.1 seconds to regularly check
                # if the termination event has been set.
                if select.select([sys.stdin], [], [], 0.1)[0]:
                    break
                elif self._termination_event.is_set():
                    logger.info("Terminating event loop")
                    return
            line = sys.stdin.readline().strip()
            try:
                event = json.loads(line.strip(','))
            except json.JSONDecodeError:
                continue
            notify(f"Event: {event}")


def write(text: str):
    sys.stdout.write(text)
    sys.stdout.flush()


def notify(msg: str, urgency: str = 'normal') -> None:
    assert urgency in ['low', 'normal', 'critical']
    run(['notify-send', '--urgency', urgency, msg], capture_output=True)


def log_exception(e: Exception) -> None:
    trace = ''.join(traceback.format_exception(
        type(e), e, e.__traceback__))
    logger.error(trace)
    notify(f"Event script failed: {trace}")


def main():
    termination_event = threading.Event()
    status_loop = StatusLoop(termination_event)
    event_loop = EventLoop(termination_event)
    write(json.dumps(dict(version=1, click_events=True)))
    status_loop.start()
    event_loop.start()
    status_loop.join()
    event_loop.join()


if __name__ == '__main__':
    logger.handlers = []
    file_handler = logging.FileHandler('/tmp/i3status_script.log')
    file_handler.setFormatter(logging.Formatter('[%(asctime)s|%(levelname)s] %(message)s'))
    logger.addHandler(file_handler)
    logger.setLevel(logging.DEBUG)
    main()
