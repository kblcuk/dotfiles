set -gx EDITOR nvim
set -gx HOMEBREW_NO_AUTO_UPDATE 1
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

set -gx FZF_DEFAULT_OPTS '--color=light
	--color=fg:#908caa,bg:#191724,hl:#ebbcba
	--color=fg+:#e0def4,bg+:#26233a,hl+:#ebbcba
	--color=border:#403d52,header:#31748f,gutter:#191724
	--color=spinner:#f6c177,info:#9ccfd8,separator:#403d52
	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa
  --color=light'

fish_config theme choose "Rosé Pine Dawn"
