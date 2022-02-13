set -gx EDITOR nvim
set -gx HOMEBREW_NO_AUTO_UPDATE 1
set -gx TERMINAL kitty
# TF ENV uses amd64 by default, which might not be default
set -gx TFENV_ARCH (uname -m)

set -gx GPG_TTY (tty)

fish_add_path /opt/homebrew/bin /opt/homebrew/sbin /opt/homebrew/opt/libpq/bin /opt/homebrew/opt/openjdk/bin
fish_add_path /Users/alex/.cargo/bin

set -gx fish_cursor_default block
set -gx fish_cursor_insert line
set -gx fish_cursor_replace underscore
set -gx fish_cursor_replace_one underscore
set -gx fish_cursor_visual block
