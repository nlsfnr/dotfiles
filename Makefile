CONFIG=$(HOME)/.config
TARGETS_CONFIG=nvim i3
TARGETS_HOME=profile xsession Xresources gitconfig bashrc

.PHONY: all
all: $(TARGETS_CONFIG) $(TARGETS_HOME)
	@echo "Done"

.PHONY: $(TARGETS_CONFIG)
$(TARGETS_CONFIG):
	@echo "Building $@"
	@rm -rf $(HOME)/.config/$@
	@ln -s $(abspath $@) $(HOME)/.config/$@

.PHONY: $(TARGETS_HOME)
$(TARGETS_HOME):
	@echo "Building $@"
	@rm -rf $(HOME)/.$@
	@ln -s $(abspath $@) $(HOME)/.$@
