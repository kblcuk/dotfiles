set -g fish_key_bindings fish_vi_key_bindings
set -U fish_greeting

set -gx EDITOR nvim
set -gx NVIM_APPNAME lazyvim
set -gx HOMEBREW_NO_AUTO_UPDATE 1
# TF ENV uses amd64 by default, which might not be default
set -gx TFENV_ARCH (uname -m)
set -gx DOTNET_ROOT "/opt/homebrew/opt/dotnet@8/libexec"
set -gx ANDROID_HOME "$HOME/Library/Android/sdk"

set -gx GPG_TTY (tty)
# to fix eza and fd color output
set -gx LS_COLORS ''
# colorful man pages
# set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"

set -gx fish_cursor_default block
set -gx fish_cursor_insert line
set -gx fish_cursor_replace underscore
set -gx fish_cursor_replace_one underscore
set -gx fish_cursor_visual block
