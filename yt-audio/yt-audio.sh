#!/bin/bash

URL="$1"

#
#
#
YTDL_DIR=/tmp/ytdl-audio/
mkdir -p $YTDL_DIR
YTDL_OUT=$YTDL_DIR/yt-$$.out
YTDL_ERR=$YTDL_DIR/yt-$$.err
YTDL_RET=0

if [ "$URL" = "" ]
then
    echo "Missing url"
    exit 1
fi


download_url()
{
    youtube-dl "$URL" > $YTDL_OUT 2>$YTDL_ERR
    YTDL_RET=$?
    if [ $YTDL_RET -ne 0 ]
    then
        echo "Failed downloading $URL"
        exit 2
    fi
}

find_video_file()
{
    VIDEO_FILE=$(cat $YTDL_OUT  | grep "Merging formats" | cut -d  '"' -f2)
    if [ ! -f "$VIDEO_FILE" ]
    then
        echo "Missing could not extract video file name from output of youtube-dl"
        echo "Find new method"
        exit 1
    fi

}

extract_audio()
{
    MP3_FILE=${VIDEO_FILE%.mkv}.mp3
    MP3_FILE=$(echo ${MP3_FILE} | sed 's, ,_,g')
    
#    echo "$VIDEO_FILE"
 #   echo "  ==>"
  #  echo "$MP3_FILE"
    
    if [ -f "$MP3_FILE" ]
    then
        echo "File ("$MP3_FILE") already exists"
        exit 3
    fi
    ffmpeg -i "${VIDEO_FILE}" -vn -c:a libmp3lame -y "$MP3_FILE"
    if [ ! -f "$MP3_FILE" ]
    then
        echo "Failed extracting audio to ("$MP3_FILE")"
        exit 4
    else
        rm "${VIDEO_FILE}"
    fi
}


download_url
find_video_file
extract_audio


echo "Created $MP3_FILE"

