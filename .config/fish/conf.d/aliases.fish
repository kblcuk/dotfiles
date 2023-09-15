# Quick edits
alias ea 'vim ~/.config/fish/conf.d/aliases.fish'

# eza is the new ls
alias ls='eza -al --color=always --group-directories-first' # my preferred listing
alias la='eza -a --color=always --group-directories-first'  # all files and dirs
alias ll='eza -l --color=always --group-directories-first'  # long format
alias lt='eza -aT --color=always --group-directories-first' # tree listing


# Abbreviations
alias pt 'papertrail'

alias vi 'nvim'
alias vim 'nvim'
alias cfg '/usr/bin/git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
