# gentoofetch
Not portable information system dash script for Gentoo GNU/Linux.
![wayland-screenshot](https://cloud.githubusercontent.com/assets/18743742/25186948/30bec608-2511-11e7-8e7b-6bb52e10f085.png)
gentoofetch is 143 lines long, 5mb in size 42 times smaller than screenfetch 26 times smaller than neofetch. It's written in ASCII 
characrers, so no 
Unicode required. Memory detection doesn't work in busybox shell.
To run gentoofetch you must install dash, to install it run (from root):
# emerge dash
You can substitute symlink /bin/sh.
# rm /bin/sh
# ln -s /bin/dash /bin/sh 
