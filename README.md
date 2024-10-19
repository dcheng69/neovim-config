# Neovim Configuration Repo

This is a repo for configuration of neovim, using mostly lua to config, taking https://github.com/LunarVim/Neovim-from-scratch as the main source of reference.

The config and document are based on the Ubuntu distribution.



## Test this config

Rename the old `nvim` directory as `nvim.old`

Then clone the repository to the right place

```
git clone git@github.com:dcheng69/neovim-config.git ~/.config/nvim
```

## Clang Configuration

Use clang as a `LSP`, it relies on the compile commands to effectively search for the source code. To automatically generate such `compile_commands.json` file https://github.com/rizsotto/Bear

```bash
# On ubuntu 20.04
sudo apt install bear
# In a make based project
make clean
bear make -j4 # for some newer version of bear, use '=' to seperate
```

## CPP source code analyze

### Dynamic analysis

Use `kcachegrind` and `valgrind` tools at run-time, we would be able to catch and analyse the run-time call traces easily.

```bash
# On ubuntu 20.4
sudo apt install -y kcachegrind
sudo apt install -y valgrind

# Generate a callgrind.out.<PID> file.
valgrind --tool=callgrind ./main

# Open a GUI tool to visualize callgrind data.
kcachegrind callgrind.out.1234
```

https://valgrind.org/

https://stackoverflow.com/questions/16393985/getting-control-flow-graph-from-ansi-c-code
