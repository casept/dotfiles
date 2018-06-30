#!/usr/bin/env python3
"""
This script is a wrapper for GNU stow.
It unstows all directories into $HOME while force-overwriting any files (a feature that stow lacks).
It reports whether any files have changed.
"""
import os
import sys
import shutil
import subprocess
import re


def get_packages(directory):
    """
    Returns the list of all stow packages in *directory*,
    which currently are all directories except for .git.
    An ignore mechanism for ignoring other directories might be added in the future.
    """

    packages = list()
    for entry in os.listdir(directory):
        if os.path.isdir(entry):
            if not entry.endswith(".git"):
                packages.append(entry)
    return packages


def cleanup(directory):
    """
    Removes any files from $HOME that conflict with any stow package in *directory*.
    """
    # Get user's home directory
    homedir = os.path.expanduser("~")
    if homedir is None:
        raise ValueError("Could not determine the user's home directory")

    # Dry-run stow for all packages to find conflicts
    to_be_removed = list()
    packages = get_packages(directory)
    conflict_regex = re.compile(
        r"(?:existing target is neither a link nor a directory:\s{1})(.*)")
    for package in packages:
        # Use older subprocess functions for compat with python3 < 3.5
        try:
            subprocess.check_output(
                ["stow", "-t", homedir, "--simulate", package], stderr=subprocess.STDOUT, universal_newlines=True)
        except subprocess.CalledProcessError as error:
            # Check if the error was caused by conflicts
            if "existing target is neither a link nor a directory" in error.output:
                # Extract the matching paths and add them to list of files to
                # be removed
                conflicting_paths = conflict_regex.findall(error.output)
                for path in conflicting_paths:
                    to_be_removed.append(
                        os.path.abspath(os.path.join(homedir, path)))
            else:
                # Error wasn't caused by a conflict, re-raise the exception
                raise error

    # Perform the actual removal
    for path in to_be_removed:
        if os.path.isfile(path):
            print("Removing conflicting file", path)
            os.remove(path)
        if os.path.isdir(path):
            print("Removing conflicting directory", path)
            shutil.rmtree(path)

    # Return whether any files had to be removed
    return len(to_be_removed) > 0


def unstow(directory):
    """
    Unstows all packages in *directory* to $HOME.
    """
    # Get user's home directory
    homedir = os.path.expanduser("~")
    if homedir is None:
        raise ValueError("Could not determine the user's home directory")
    changed = False
    packages = get_packages(directory)

    for package in packages:
        print("Unstowing package", package)
        output = subprocess.check_output(
            ["stow", "-t", homedir, "-v", "2", package], stderr=subprocess.STDOUT, universal_newlines=True)
        if "LINK:" in output:
            changed = True

    return changed


def check_if_dotfile_directory():
    """
    Checks whether the script is running from the dotfiles directory
    to prevent issues with wrong paths caused by invoking from the wrong directory.
    """
    if not os.path.exists(os.path.join(os.getcwd(), ".dotfiledir")):
        print("Please invoke this script from the dotfiles directory!")
        sys.exit(1)


def main():
    """
    Main function.
    """

    check_if_dotfile_directory()
    # Perform cleanup
    changed_cleanup = cleanup('.')
    changed_unstow = unstow('.')
    if changed_cleanup or changed_unstow:
        print("Files changed")
    else:
        print("No files changed")


if __name__ == "__main__":
    main()
