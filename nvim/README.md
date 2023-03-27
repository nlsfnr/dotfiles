To install Packer, the package manager, run:

```bash
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
 ```

Taken from [here](https://github.com/wbthomason/packer.nvim).

Then, open `./lua/nlsfnr/packer.lua` in vim and run `:so` to install Packer,
followed by `:PackerSync`. Notice that the `packer.lua` file is not loaded on
startup.
