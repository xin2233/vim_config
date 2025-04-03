# sh

rm ~/.vim -rf
mkdir -p ~/.vim/autoload
cp vimrc.vim ~/.vimrc
cp ./vim-plug/plug.vim ~/.vim/autoload

# run vim plug install
vim +PlugInstall

