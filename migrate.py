#!/usr/bin/python

# This script migrates the files from a git checkout into the home directory.
# It assumes that it is being run from the git top-level checkout directory.

import os
import sys


GITCONFIG_TEMPLATE = """
[user]
	name = {name}
	email = {email}
"""

# Abort if current directory doesn't look like a git repo.
if not os.path.exists("./.git"):
    raise Exception("not running in git checkout")

# Copy files from checkout into home directory.
target = os.path.expanduser("~")
os.rename("./.git", os.path.join(target, ".config.git"))
for entry in os.listdir("."):
    if entry == os.path.basename(sys.argv[0]):
        continue
    os.rename(os.path.join(".", entry), os.path.join(target, entry))

# Since we're presumably commissioning a new system, this is a good point
# to remind the user to configure their git name and email.
if not os.path.exists(os.path.join(target, ".gitconfig")):
    print "No .gitconfig - enter name and email (or ^C to skip)"
    try:
        name = email = ""
        while not name:
            name = raw_input("Name: ")
        while not email:
            email = raw_input("Email: ")
        with open(os.path.join(target, ".gitconfig"), "w") as fd:
            fd.write(GITCONFIG_TEMPLATE.format(name=name, email=email))
    except KeyboardInterrupt:
        print "Creation of .gitconfig skipped"

