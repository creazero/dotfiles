curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

[ ! -d "$HOME/.config" ] && mkdir ~/.config

cp ./.Xresources ~/.Xresources
cp -r ./.Xres ~/.Xres
cp -r ./bspwm ~/.config/bspwm
cp -r ./mpd ~/.config/mpd
cp -r ./polybar ~/.config/polybar
cp -r ./neofetch ~/.config/neofetch
cp -r ./nvim ~/.config/nvim
cp -r ./sxhkd ~/.config/sxhkd
cp ./.zshrc ~/.zshrc
cp ./.emacs ~/.emacs
