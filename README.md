# My dotfiles

Some dotfiles I manage with GNU `stow`.
I haven't polished this in a way that it would be useful to others, but feel free to copy-paste anything you need.

## Installation

These dotfiles are designed to be used in conjunction with my ansible provisioning scripts [here](https://github.com/casept/ansible-playbooks), which automatically set up users, install prerequisite packages and so on.

If using ansible is not an option, you can install `stow` and use `install.py` to install these dotfiles into your home directory, then install required packages yourself.

**Use `--recursive` when checking out this repo, as vim modules are stored as submodules!**
