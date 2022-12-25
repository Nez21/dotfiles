#!/bin/sh
export KITTY_ENABLE_WAYLAND=1
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
export GDK_BACKEND=wayland
export XDG_SESSION_TYPE=wayland
export XCURSOR_SIZE=24
export WLR_RENDERER=vulkan
export WLR_NO_HARDWARE_CURSORS=1

exec Hyprland