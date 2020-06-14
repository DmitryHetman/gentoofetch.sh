# gentoofetch.sh
Dash screenshot information tool for Gentoo GNU/Linux.
gentoofetch.sh is now deprecated, use gentoofetch which written in  C, but sh version still available.
![wayland-screenshot](https://cloud.githubusercontent.com/assets/18743742/26276442/3351cdb6-3d67-11e7-83e1-6c20eab89a55.png)
gentoofetch is 103 lines long, 3.5Kb in size 60 times smaller than 
screenfetch 38 times smaller than neofetch. It's written in ASCII 
characrers, so no Unicode required. Memory detection doesn't work in busybox shell.
To run gentoofetch you must install dash, to install it run (from root):
# emerge dash
You can substitute symlink /bin/sh.
# rm /bin/sh
# ln -s /bin/dash /bin/sh 
