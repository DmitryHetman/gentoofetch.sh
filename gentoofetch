#!/bin/dash
DetectGentooRelease(){
. /etc/portage/make.conf
case $ACCEPT_KEYWORDS in
 [a-z]*) GentooRelease=stable       ;;
 ~*)     GentooRelease=testing      ;;
 '**')   GentooRelease=experimental ;;
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
fi ;;
esac
Clib="${Clib} ${ClibVer}"
}
DetectIntelGPU(){
GPU=$(awk '{print $2}' /proc/fb)
case $GPU in
 *intel*) GPU=intel ;;
esac
if [ $GPU = intel ]
then
 local CPU=$(uname -p | awk '{print $3}')
 CPU=${CPU#*'-'};
 case $CPU in
   [3-6][3-9][0-5]|[3-6][3-9][0-5][K-Y]) GPU='Intel HD Graphics' ;;
   2[1-5][0-3][0-2]*|2390T|2600S) GPU='Intel HD Graphics 2000' ;;
   2[1-5][1-7][0-8]*|2105|2500K) GPU='Intel HD Graphics 3000' ;;
   32[1-5]0*|3[4-5][5-7]0*|33[3-4]0*) GPU='Intel HD Graphics 2500' ;;
   3570K|3427U) GPU='Intel HD Graphics 4000' ;;
   4[3-7][0-9][0-5]*) GPU='Intel HD Graphics 4600' ;;
   5[5-6]75[C-R]|5350H) GPU='Intel Iris Pro Graphics 6200' ;;
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
'[0m[1;35m         -/oyddmdhs+:.[0m[1;35m              '$USER'[0m[1m@[0m[0m[1;35m'"$(hostname)" \
'[0m[1;35m     -o[0m[1;37mdNMMMMMMMMNNmhy+[0m[1;35m-`           OS:[0m Gentoo '$GentooRelease \
'[0m[1;35m   -y[0m[1;37mNMMMMMMMMMMMNNNmmdhyb[0m[1;35m+-        Kernel:[0m '"$(uname -sr)" \
'[0m[1;35m `o[0m[1;37mmMMMMMMMMMMMMNmdmmmmddhhy[0m[1;35m/`      Uptime:[0m '"$(uptime -p|tr -d 'uporsayinte ')" \
'[0m[1;35m om[0m[1;37mMMMMMMMMMMMN[0m[1;35mhhyyyo[0m[1;37mhmdddhhhd[0m[1;35mo`    Packages:[0m '$(ls -d /var/db/pkg/*/*|wc -l) \
'[0m[1;35m.y[0m[1;37mdMMMMMMMMMMd[0m[1;35mhs++so/s[0m[1;37mmdddhhhhdm[0m[1;35m+`  Shell:[0m '${SHELL##*/} \
'[0m[1;35m oy[0m[1;37mhdmNMMMMMMMN[0m[1;35mdyooy[0m[1;37mdmddddhhhhyhN[0m[1;35md. CPU:[0m '"$(uname -p|tr -d '(TM)R@')" \
'[0m[1;35m  :o[0m[1;37myhhdNNMMMMMMMNNNmmdddhhhhhyym[0m[1;35mMh GPU:[0m '"$GPU" \
'[0m[1;35m    .:[0m[1;37m+sydNMMMMMNNNmmmdddhhhhhhmM[0m[1;35mmy RAM:[0m '$RAM \
'[0m[1;35m       /m[0m[1;37mMMMMMMNNNmmmdddhhhhhmMNh[0m[1;35ms: Root:[0m '"${RootUsage}" \
'[0m[1;35m    `o[0m[1;37mNMMMMMMMNNNmmmddddhhdmMNhs[0m[1;35m+`  GCC:[0m '"$GCCVersion" \
'[0m[1;35m  `s[0m[1;37mNMMMMMMMMNNNmmmdddddmNMmhs[0m[1;35m/.    Clib:[0m '"$Clib" \
'[0m[1;35m /N[0m[1;37mMMMMMMMMNNNNmmmdddmNMNdso[0m[1;35m:`      Profile:[0m '"$GentooProfile" \
'[0m[1;35m+M[0m[1;37mMMMMMMNNNNNmmmmdmNMNdso[0m[1;35m/-         Terminal:[0m '$Terminal \
'[0m[1;35myM[0m[1;37mMNNNNNNNmmmmmNNMmhs+/[0m[1;35m-`           Sound Card:[0m'"$SoundCard" \
'[0m[1;35m/h[0m[1;37mMMNNNNNNNNMNdhs++/[0m[1;35m-`              Graphic Environment:[0m '$GraphicEnvironment \
'[0m[1;35m`/[0m[1;37mohdmmddhys+++/:[0m[1;35m.`                 Resolution:[0m '$Resolution \
'[0m[1;35m  `-//////:--.[0m'
