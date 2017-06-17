# gentoofetch.sh
Dash screenshot information tool for Gentoo GNU/Linux.
![wayland-screenshot](https://raw.githubusercontent.com/DmitryHetman/gentoofetch/master/gentoofetch.png)
gentoofetch is 103 lines long, 3.5Kb in size 60 times smaller than 
screenfetch 38 times smaller than neofetch. It's written in ASCII 
characrers, so no Unicode required. Memory detection doesn't work in busybox shell.
To run gentoofetch you must install dash, to install it run (from root):
# emerge dash
You can substitute symlink /bin/sh.
# rm /bin/sh
# ln -s /bin/dash /bin/sh 
