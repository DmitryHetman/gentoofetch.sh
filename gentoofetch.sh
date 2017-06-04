#!/bin/dash
DetectGentooRelease(){
. /etc/portage/make.conf
case $ACCEPT_KEYWORDS in
[a-z]*) GentooRelease=stable;;
~*)     GentooRelease=testing;;
'**')   GentooRelease=experimental;;
esac
}
DetectGentooProfile(){
local Profile
Profile=$(file '/etc/portage/make.profile');
Profile=${Profile#*s/}
Profile=${Profile%13.0}
Profile="${Profile%%/*} ${Profile##*/}"
GentooProfile="${Profile}"
}
DetectGCC(){
GCCVersion=$(gcc --version)
GCCVersion=${GCCVersion#*(}
GCCVersion=${GCCVersion%%)*}
}
DetectClib(){
local MACHTYPE=$(gcc -dumpmachine)
case $MACHTYPE in
*-gnu) Clib=glibc
local ClibVer
ClibVer=$(/lib/libc-*)
ClibVer=${ClibVer%%)*}
ClibVer=${ClibVer#*(} ;;
*-*) Clib=${MACHTYPE##*'-'}
if [ $Clib = uclibc ]
then
local uclibcVer
uclibcVer=$(file /lib/libc.*)
uclibcVer=${uclibcVer#*'-'}
uclibcVer=${uclibcVer%.*}
ClibVer=${uclibcVer}
fi;;
esac
Clib="${Clib} ${ClibVer}"
}
DetectIntelGPU(){
GPU=$(awk '{print $2}' /proc/fb)
case $GPU in
*intel*) GPU=intel;;
esac
if [ $GPU = intel ]
then
local CPU=$(uname -p | awk '{print $3}')
CPU=${CPU#*'-'};
case $CPU in
[3-6][3-9][0-5]|[3-6][3-9][0-5][K-Y]) GPU='Intel HD Graphics';;
2[1-5][0-3][0-2]*|2390T|2600S) GPU='Intel HD Graphics 2000';;
2[1-5][1-7][0-8]*|2105|2500K) GPU='Intel HD Graphics 3000';;
32[1-5]0*|3[4-5][5-7]0*|33[3-4]0*) GPU='Intel HD Graphics 2500';;
3570K|3427U) GPU='Intel HD Graphics 4000';;
4[3-7][0-9][0-5]*) GPU='Intel HD Graphics 4600';;
5[5-6]75[C-R]|5350H) GPU='Intel Iris Pro Graphics 6200';;
esac
fi
}
DetectSoundCard(){
SoundCard=$(aplay -L|grep -m1 -A1 'default:'|sed -n 2p|tr , :)
SoundCard=${SoundCard#*'   '}
}
DetectRootUsage(){
RootUsage=$(df -hT|awk 'FNR==2{print$4"/"$3" "$2}')
}
DetectTerminal(){
if [ ${TMUX_PANE} ]
then
Terminal=tmux
else
Terminal=$TERM
fi
}
DetectGraphicEnvironment(){
if [ -S  $XDG_RUNTIME_DIR/wayland-[0-9] ]
then
GraphicEnvironment=Wayland
elif [ -S /tmp/.X11-unix/X0 ]
then
GraphicEnvironment=Xorg
else
GraphicEnvironment=Framebuffer
fi
if [ $TERM = linux ]
then
GraphicEnvironment=Framebuffer
fi
}
DetectRAM(){
RAM=$(free -h|awk 'FNR==2{print$3"/"$2}')
}
DetectResolution(){
Resolution=$(cat /sys/devices/virtual/graphics/fbcon/subsystem/fb0/device/drm/card0/device/graphics/fb0/virtual_size|tr ', ' 'x')
}
DetectGentooRelease
DetectGentooProfile
DetectGCC
DetectClib
DetectIntelGPU
DetectSoundCard
DetectRootUsage
DetectGraphicEnvironment
DetectTerminal
DetectRAM
DetectResolution
printf "%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n%s\n" \
"[1;35m         -/oyddmdhs+:.[1;35m              $USER[1;37m@[1;35m$(hostname)" \
'     -o[1;37mdNMMMMMMMMNNmhy+[1;35m-`           OS:[m Gentoo '$GentooRelease \
"[1;35m   -y[1;37mNMMMMMMMMMMMNNNmmdhyb[1;35m+-        Kernel:[m $(uname -sr)" \
'[1;35m `o[1;37mmMMMMMMMMMMMMNmdmmmmddhhy[1;35m/`      Uptime:[m '"$(uptime -p|tr -d 'uporsayinte ')" \
'[1;35m om[1;37mMMMMMMMMMMMN[1;35mhhyyyo[1;37mhmdddhhhd[1;35mo`    Packages:[m '$(ls -d /var/db/pkg/*/*|wc -l) \
'[1;35m.y[1;37mdMMMMMMMMMMd[1;35mhs++so/s[1;37mmdddhhhhdm[1;35m+`  Shell:[m '${SHELL##*/} \
'[1;35m oy[1;37mhdmNMMMMMMMN[1;35mdyooy[1;37mdmddddhhhhyhN[1;35md. CPU:[m '"$(uname -p|tr -d '(TM)R@')" \
"[1;35m  :o[1;37myhhdNNMMMMMMMNNNmmdddhhhhhyym[1;35mMh GPU:[m $GPU" \
'[1;35m    .:[1;37m+sydNMMMMMNNNmmmdddhhhhhhmM[1;35mmy RAM:[m '$RAM \
"[1;35m       /m[1;37mMMMMMMNNNmmmdddhhhhhmMNh[1;35ms: Root:[m ${RootUsage}" \
'[1;35m    `o[1;37mNMMMMMMMNNNmmmddddhhdmMNhs[1;35m+`  GCC:[m '"$GCCVersion" \
'[1;35m  `s[1;37mNMMMMMMMMNNNmmmdddddmNMmhs[1;35m/.    Clib:[m '"$Clib" \
'[1;35m /N[1;37mMMMMMMMMNNNNmmmdddmNMNdso[1;35m:`      Profile:[m '"$GentooProfile" \
'[1;35m+M[1;37mMMMMMMNNNNNmmmmdmNMNdso[1;35m/-         Terminal:[m '$Terminal \
'[1;35myM[1;37mMNNNNNNNmmmmmNNMmhs+/[1;35m-`           Sound Card:[m'"$SoundCard" \
'[1;35m/h[1;37mMMNNNNNNNNMNdhs++/[1;35m-`              Graphic Environment:[m '$GraphicEnvironment \
'[1;35m`/[1;37mohdmmddhys+++/:[1;35m.`                 Resolution:[m '$Resolution \
'[1;35m  `-//////:--.[m'
