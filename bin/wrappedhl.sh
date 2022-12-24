#!/bin/sh

export KITTY_ENABLE_WAYLAND=1
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export SDL_VIDEODRIVER=wayland
export XCURSOR_SIZE=24
export XDG_SESSION_TYPE=wayland
export WLR_RENDERER=vulkan
export NO_XWAYLAND=1
export VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/radeon_icd.x86_64.json

exec Hyprland