# Pull my configuration (cuz I'm lazy)
cp ~/.config/kitty/kitty.conf kitty/kitty.conf
cp ~/.aliases ~/.zshrc zsh/
cp ~/.config/nvim/*.vim nvim/
cp -r ~/.config/waybar/ .
cp -r ~/.config/hypr/ .
cp -r ~/.config/wlogout/ .
cp -r ~/.config/kanshi/ .
rm -r vifm && cp -r ~/.config/vifm . && rm vifm/vifminfo.json
