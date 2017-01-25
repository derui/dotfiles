#!/bin/zsh

TS=$1
BASE=$(basename "$TS" .ts)
[ "${BASE}.ts" = "$(basename $TS)" ] || exit 1

#CPU_CORES=0
CPU_CORES=$(/usr/bin/getconf _NPROCESSORS_ONLN)

X264_HIGH_HDTV=-f mp4 -vcodec libx264 -strict -2 \
    -fpre ${HOME}/bin/libx264-hq-ts.ffpreset \
    -r 30000/1001 -aspect 16:9 -s 1440x1080 -bufsize 20000k -maxrate 25000k \
    -acodec aac -strict experimental -ac 2 -ar 48000 -ab 128k -threads ${CPU_CORES}

ffmpeg -y -i "$TS" ${X264_HIGH_HDTV} "${BASE}.mp4"
