set -gx EDITOR nvim
set -gx HOMEBREW_NO_AUTO_UPDATE 1
# TF ENV uses amd64 by default, which might not be default
set -gx TFENV_ARCH (uname -m)

set -gx GPG_TTY (tty)

set -gx fish_cursor_default block
set -gx fish_cursor_insert line
set -gx fish_cursor_replace underscore
set -gx fish_cursor_replace_one underscore
set -gx fish_cursor_visual block

