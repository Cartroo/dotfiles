#!/usr/bin/python

# This script migrates the files from a git checkout into the home directory.
# It assumes that it is being run from the git top-level checkout directory.

import os
import sys


if not os.path.exists("./.git"):
    raise Exception("not running in git checkout")

target = os.path.expanduser("~")
os.rename("./.git", os.path.join(target, ".config.git"))
for entry in os.listdir("."):
    if entry == os.path.basename(sys.argv[0]):
        continue
    os.rename(os.path.join(".", entry), os.path.join(target, entry))

