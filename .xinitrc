export LANG=en_US.UTF-8
export PATH=$PATH:${HOME}.local/bin
export MUSIC_PATH=${HOME}/Music

xrdb -I$HOME ~/.Xresources

exec i3 > /tmp/i3log

