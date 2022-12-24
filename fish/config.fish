set fish_greeting
starship init fish | source
keychain --eval --agents ssh --quiet --noask -Q id_ed25519 | source