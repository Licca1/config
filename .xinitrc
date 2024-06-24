[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

# init screensaver
{ xscreensaver -no-splash & };

# init compositor

{ xcompmgr -c & }

# add wallpaper
sh ~/.wallpaper;

# set cursor
xsetroot -cursor_name left_ptr

# disable middleclick
xbindkeys

xmonad --recompile;

{ xmodmap ~/.Xmodmap & };

{
  setxkbmap -layout us && setxkbmap -layout us,ua;
  setxkbmap -option caps:none;
  setxkbmap -option grp:caps_toggle;
};

{ piactl connect & };
# run xmonad
exec xmonad
