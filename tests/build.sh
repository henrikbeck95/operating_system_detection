#!/usr/bin/env bash

#Global variables declaration (edit these line according to your needs)
OPERATING_SYSTEM_DETECTION_LINK_FILE_RAW="https://raw.githubusercontent.com/henrikbeck95/operating_system_detection/main/operating_system_detection.sh"
OPERATING_SYSTEM_DETECTION_FILENAME="operating_system_detection.sh"
OPERATING_SYSTEM_DETECTION_PATH="${BASH_SOURCE%/*}/operating_system_detection"

#Create the directory if it does not exists
if [ ! -d $OPERATING_SYSTEM_DETECTION_PATH/ ]; then
  mkdir -p $OPERATING_SYSTEM_DETECTION_PATH/;
fi

#Remove the old version file if it exists
if [ -f $OPERATING_SYSTEM_DETECTION_PATH/$OPERATING_SYSTEM_DETECTION_FILENAME ]; then
    rm $OPERATING_SYSTEM_DETECTION_PATH/$OPERATING_SYSTEM_DETECTION_FILENAME
fi

#Download the raw file on the right project folder
#The reason of the --no-check-certificate flag is: Slackware Docker does not download the file without it
#wget $OPERATING_SYSTEM_DETECTION_LINK_FILE_RAW -O $OPERATING_SYSTEM_DETECTION_PATH/$OPERATING_SYSTEM_DETECTION_FILENAME
wget $OPERATING_SYSTEM_DETECTION_LINK_FILE_RAW --no-check-certificate -O $OPERATING_SYSTEM_DETECTION_PATH/$OPERATING_SYSTEM_DETECTION_FILENAME || curl -o $OPERATING_SYSTEM_DETECTION_PATH/$OPERATING_SYSTEM_DETECTION_FILENAME $OPERATING_SYSTEM_DETECTION_LINK_FILE_RAW

#Give the executable permission
chmod +x $OPERATING_SYSTEM_DETECTION_PATH/$OPERATING_SYSTEM_DETECTION_FILENAME

#Import the Operating system detection script file
#source "$OPERATING_SYSTEM_DETECTION_PATH/$OPERATING_SYSTEM_DETECTION_FILENAME"

#Uncomment the lines belows to display the API result right now
#echo $INTRODUCTION_MESSENGE
#echo $IS_RUNNING_INSIDE_DOCKER
#echo $MESSENGE
#echo $PROCESSOR_ARCH
#echo $PROCESSOR_ARCH_BITS
#echo $OPERATING_SYSTEM_NAME
#echo $OPERATING_SYSTEM_BASED
#echo $OPERATING_SYSTEM_VERSION