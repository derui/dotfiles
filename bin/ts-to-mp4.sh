#!/bin/zsh

TS=$1
BASE=$(basename "$TS" .ts)
[ "${BASE}.ts" = "$(basename $TS)" ] || exit 1

VCODEC=libx264

#CPU_CORES=0
CPU_CORES=$(/usr/bin/getconf _NPROCESSORS_ONLN)

X264_HIGH_HDTV="-threads $CPU_CORES -vcodec $VCODEC \
    -fpre ${HOME}/bin/libx264-hq-ts.ffpreset \
    -vsync 1 -deinterlace \
    -r 30000/1001 -s 1280x720 -bufsize 20000k -maxrate 25000k \
    -f mp4 -acodec aac -ac 2 -ar 48000 -ab 128k"

ffmpeg -y -i "$TS" ${=X264_HIGH_HDTV} "$BASE.mp4"
