# ~/.pythonrc

# Enable tab-completion
try:
    import readline
    import rlcompleter
except ImportError:
    pass
else:
    readline.parse_and_bind("tab: complete")

