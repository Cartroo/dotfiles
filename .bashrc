# .bashrc

# User specific aliases and functions

PROMPT_PREFIX=""

# Source .localbashrc, if it exists.
if [ -f ~/.localbashrc ]; then
    . ~/.localbashrc
fi

# Include common extra directories in path.
PATH=$HOME/bin:$PATH:/sbin:/usr/sbin:.
export PATH

# Use vi as default editor.
export EDITOR=/usr/bin/vi

# Fix gnome-terminal type so things like vim colours look better.
if [[ "$TERM" == "xterm" && "${COLORTERM:0:5}" == "gnome" ]]; then
    export TERM="xterm-256color"
fi

# Register Python startup script, if it exists.
if [ -f ~/.pythonstartup.py ]; then
    export PYTHONSTARTUP=~/.pythonstartup.py
fi

# Customise directory colours, if configured.
if [ -x /usr/bin/dircolors ] && [ -f ~/.dir_colors ] ; then
  eval "$(/usr/bin/dircolors -b ~/.dir_colors)"
fi

# As an aid to understanding the prompts below:
#   \[...\]             Tells bash that '...' consists of non-printing chars
#   \u \h \w \W         User, host, full PWD, basename of PWD
#   \D{%a %H:%M}        Day of week, hour and minute: "Thu 14:19"
#   \$                  '#' if user is root, '$' otherwise
#   \033]0;...\007      Set the current xterm title to '...'
#   \033[00;33m         Set colour to yellow
#   \033[00;31m         Set colour to red
#   \033[01;37;41m      Set colour to bold white with a red background
#   \033[01;37;44m      Set colour to bold white with a blue background
#   \033[00m            Reset to default colours

# Make sure terminal titles don't get too long.
export PROMPT_DIRTRIM=4

# Set MYHOST to a hostname to have all other hosts add a prompt prefix.
if [ -n "${MYHOST}" ] && [ "$(hostname)" != "${MYHOST}" ]; then
  PROMPT_PREFIX="${PROMPT_PREFIX}"'\[\033[00;37;41m\][\h]\[\033[00m\] '
fi

# Add non-user Perforce clients to the prompt prefix (if P4CLIENT is set).
if [ -n "${P4CLIENT}" ] && [ "${P4CLIENT}" != "${USER}" ]; then
  # Remove "username-" prefix, if any.
  P4CLIENT_ABBREV="${P4CLIENT#${USER}-}"
  # Remove "-client" suffix, if any.
  P4CLIENT_ABBREV="${P4CLIENT_ABBREV%-client}"
  PROMPT_PREFIX="${PROMPT_PREFIX}"'\[\033[00;37;44m\]['"${P4CLIENT_ABBREV}"']\[\033[00m\] '
fi

if [ "${TERM:0:5}" == "xterm" ]; then
  export PS1='\[\033]1;\h: \W\007\033]2;\u@\h: \w\007\]'"${PROMPT_PREFIX}"'\[\033[00;33m\]\u \[\033[00;31m\]\D{%a %H:%M} \[\033[01;37m\]\W \$\[\033[00m\] '
else
  export PS1="${PROMPT_PREFIX}"'\[\033[00;33m\]\u \[\033[00;31m\]\D{%a %H:%M} \[\033[01;37m\]\W \$\[\033[00m\] '
fi

# Source global definitions (if any)
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source bash completion script (if any)
if [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
fi

# SSH wrapper which adds hostname to xterm title, for hosts where the remote
# prompt hasn't been set up to do this.
ssh()
{
    if [ -x /usr/bin/xtermcontrol ]; then
        OLDXTERMTITLE=$(/usr/bin/xtermcontrol --get-title)
        /usr/bin/xtermcontrol --title="$*"
        /usr/bin/ssh $*
        /usr/bin/xtermcontrol --title="${OLDXTERMTITLE}"
    else
        echo -e '\033]0;SSH: '"$*"'\007'
        /usr/bin/ssh $*
        echo -e '\033]0;-\007'
    fi
}

# Perform colour ls by default
alias ls="ls --color=auto"

# Handy alias to avoid having to remember screen options.
alias attach="screen -xRR"

# Alias for config management.
alias dotgit='git --git-dir=${HOME}/.config.git --work-tree=${HOME}'

# Set default grep options:
#   Skip .svn and .git directoryes when recursing.
#   Skip tags files always (can override with --include=tags if required).
#   Enable colour output.
#   Display line numbers against matches.
#   Skip binary files by default.
alias grep="/bin/grep --exclude-dir=.svn --exclude-dir=.git --exclude=tags --color -n -I"

