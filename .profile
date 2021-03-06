#!/bin/sh
# make default editor Neovim
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim

# Most pure GTK3 apps use wayland by default, but some,
# like Firefox, need the backend to be explicitely selected.
export LIBVA_DRIVER_NAME=v4l2_request
export LIBVA_V4L2_REQUEST_VIDEO_PATH=/dev/video1
export MOZ_ENABLE_WAYLAND=1
export MOZ_DBUS_REMOTE=1
export GTK_CSD=0

# qt wayland
export QT_QPA_PLATFORM="wayland"
export QT_QPA_PLATFORMTHEME=qt5ct
export QT_WAYLAND_DISABLE_WINDOWDECORATION="1"

# set default shell and terminal
export SHELL=/usr/bin/fish
export TERM=/usr/bin/kitty
export TERMINAL_COMMAND='/usr/share/sway/scripts/terminal.sh'
