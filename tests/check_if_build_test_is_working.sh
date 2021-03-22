#!/bin/bash

#############################
#Shell script description
#############################

#This script is only to check if the ./build is working correctly.

#############################
#Global variables
#############################

PATH_ROOT="$HOME/my_repositories/operating_system_detection"
FOLDER_ORIGIN="$PATH_ROOT/tests"
FOLDER_DESTINY="$PATH_ROOT/running"

#############################
#Functions
#############################

function main(){
    removing_script_oldest
    copying_script_newest
    # list_folder_containt_project_root
    running_script_build
    # list_folder_containt_project_new
    print_result
}

function copying_script_newest(){
    print_separator "COPYING THE NEW SCRIPT"

    if [ ! -d $FOLDER_DESTINY/ ]; then
        mkdir $FOLDER_DESTINY/
    fi

    cp $FOLDER_ORIGIN/build.sh $FOLDER_DESTINY/build.sh
}

function list_folder_containt_project_new(){
    print_separator "LS NEW FOLDER"
    ls -lR $FOLDER_DESTINY/
}

function list_folder_containt_project_root(){
    print_separator "LS ROOT FOLDER"
    ls -lR $FOLDER_DESTINY/
}

function removing_script_oldest(){
    print_separator "REMOVING THE OLD SCRIPT"
    rm -fr $FOLDER_DESTINY/*
}

function running_script_build(){
    print_separator "RUNNING BUILD SCRIPT"
    $FOLDER_DESTINY/build.sh
}

function print_separator(){
    echo -e "\n#############################\n$1\n#############################\n"
}

print_result(){
    print_separator "RESULT"
    source $FOLDER_DESTINY/operating_system_detection/operating_system_detection.sh
}

main