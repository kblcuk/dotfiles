# Quick edits
alias ea 'vim ~/.config/fish/conf.d/aliases.fish'

# Exa is the new ls
alias ls='exa -al --color=always --group-directories-first' # my preferred listing
alias la='exa -a --color=always --group-directories-first'  # all files and dirs
alias ll='exa -l --color=always --group-directories-first'  # long format
alias lt='exa -aT --color=always --group-directories-first' # tree listing


# Abbreviations
alias pt 'papertrail'

alias vi 'nvim'
alias vim 'nvim'
alias cfg '/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
