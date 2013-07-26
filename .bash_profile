# .bash_profile

# User specific aliases and functions

PROMPT_PREFIX=""

# Check if tmux is installed - if it is, and we're not already in a tmux
# session, and an existing session is found, attach to it.
if [ -n "${TMUX_AUTO_ATTACH}" ]; then
    type -P tmux >/dev/null 2>&1
    if [[ $? -eq 0 && -z $TMUX ]]; then
        tmux has-session >/dev/null 2>&1
        if [[ $? -eq 0 ]]; then
            exec tmux attach
        fi
    fi
fi

# Source .bashrc, if it exists.
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# Initialise keychain, if installed
command -vp keychain >/dev/null 2>&1
if [ "$?" -eq 0 ]; then
    KEYS=$(command ls ~/.ssh | command grep '^id_rsa' | command grep -v '\.pub$')
    # Note: 42840 is 30 days' worth of minutes minus 6 hours - this is so the
    #       timeout happens typically before the time of day the user
    #       typically logs in, so they get prompted for a passphrase at the
    #       start of their day as opposed to halfway through.
    keychain --timeout 42840 $KEYS
    KEYCHAIN_SCRIPT="$HOME/.keychain/$(command uname -n)-sh"
    if [ -e "$KEYCHAIN_SCRIPT" ]; then
        source $KEYCHAIN_SCRIPT
    fi
fi

