#!/bin/bash

# Define color escape sequences
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[1;33m"
BLUE="\033[0;34m"
RESET="\033[0m"

facebook_link="$1"
youtube_title="$2"
youtube_description="$3"

# Setup default description with current date in Japanese format
current_date=$(date +"%Y年%-m月%-d日")
default_description="${current_date}礼拝ビデオ"
youtube_description="${youtube_description:-$default_description}"

echo "Facebook Link: $facebook_link"
echo "Youtube Title: $youtube_title"
echo "Youtube Description: $youtube_description"

# Setup working directory
#rm -rf ./fb2yt-working-directory
#mkdir ./fb2yt-working-directory
#cd ./fb2yt-working-directory

# Download from Facebook
echo ""
echo -e "${BLUE}STEP 1 - Download video from Facebook ...${RESET}"
echo ""
sleep 2
#yt-dlp -f sd "$facebook_link" -o fbvideo.mp4
yt-dlp "$facebook_link" -o fbvideo.mp4

# Amplify volume  with ffmpeg
echo ""
echo -e "${BLUE}STEP 2 - Amplify audio ...${RESET}"
echo ""
sleep 2
ffmpeg -i fbvideo.mp4 -vcodec copy -filter:a "volume=20dB" fbvideo_louder.mp4

# Upload to YouTube
echo ""
echo -e "${BLUE}STEP 3 - Upload video to YouTube ...${RESET}"
echo ""
sleep 2
./youtubeuploader -title="$youtube_title" -description="$youtube_description" -filename "fbvideo_louder.mp4"

# Attempt to make CD
echo ""
echo -e "${BLUE}PLEASE WAIT. Attempting to create CD ...${RESET}"
echo ""
sleep 2
ffmpeg -i fbvideo_louder.mp4 cdaudio.mp3
mp3burn cdaudio.mp3
eject /dev/sr0

echo ""
echo -e "${GREEN}FINISHED.${RESET}"
echo ""
echo -e "${YELLOW}Press any key to clear files and exit ...${RESET}"
read -n 1 -s
rm cdaudio.mp3
rm fbvideo.mp4
rm fbvideo_louder.mp4
exit
;;

