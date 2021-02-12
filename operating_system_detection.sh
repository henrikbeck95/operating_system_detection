#!/usr/bin/env bash

#############################
#Global variables
#############################

#Operating systems for general purpose already implemented
OPERATING_SYSTEM_BASEMENT_ALPINE="Alpine"
OPERATING_SYSTEM_BASEMENT_ARCH="ArchLinux"
OPERATING_SYSTEM_BASEMENT_DEBIAN="Debian"
OPERATING_SYSTEM_BASEMENT_OPENSUSE="OpenSUSE"
OPERATING_SYSTEM_BASEMENT_REDHAT="RedHat"
OPERATING_SYSTEM_BASEMENT_SLACKWARE="Slackware"
OPERATING_SYSTEM_BASEMENT_UNKNOWN="Unknown"

#Operating systems for general purpose not implemented yet
# OPERATING_SYSTEM_BASEMENT_ANDROID="Android"
# OPERATING_SYSTEM_BASEMENT_FREEBSD="FreeBSD"
# OPERATING_SYSTEM_BASEMENT_GENTOO="Gentoo"
# OPERATING_SYSTEM_BASEMENT_MACOS="MacOS"
# OPERATING_SYSTEM_BASEMENT_WINDOWS="WSL"

#Controllers
IS_RUNNING_INSIDE_DOCKER=""
IS_RUNNING_INSIDE_DOCKER_MESSENGE=""
#PROCESSOR_ARCH=$(uname -m | sed 's/x86_//;s/i[3-6]86/32/')
PROCESSOR_ARCH=$(uname -m)
PROCESSOR_ARCH_BITS=""
OPERATING_SYSTEM_BASED=""
OPERATING_SYSTEM_NAME=""
OPERATING_SYSTEM_VERSION=""

INTRODUCTION_MESSENGE=""

#############################
#Functions
#############################

function check_if_this_script_is_running_inside_docker_container_or_not(){
    if grep docker /proc/1/cgroup -qa; then
        IS_RUNNING_INSIDE_DOCKER=TRUE
        IS_RUNNING_INSIDE_DOCKER_MESSENGE="I am running inside a DOCKER CONTAINER"
    else
        IS_RUNNING_INSIDE_DOCKER=FALSE
        IS_RUNNING_INSIDE_DOCKER_MESSENGE="I am running on a HOST MACHINE"
    fi
}

function checking_processor_arch(){
    case $PROCESSOR_ARCH in
        x86_64) PROCESSOR_ARCH_BITS=64 ;;
        i*86) PROCESSOR_ARCH_BITS=32 ;;
        *) PROCESSOR_ARCH_BITS="Undefined" ;;
    esac
}

function checking_linux_operating_system_using_command_awk(){
    #local SEARCH_FILE="/usr/lib/os-release"
    local SEARCH_FILE="/etc/*-release"

    if [ -z "$OPERATING_SYSTEM_BASED" ]; then #String is null, that is, has zero length
        OPERATING_SYSTEM_BASED=$(awk '/ID_LIKE=/' $SEARCH_FILE | sed 's/ID_LIKE=//' | tr '[:upper:]' '[:lower:]')
        OPERATING_SYSTEM_NAME=$(awk '/DISTRIB_ID=/' $SEARCH_FILE | sed 's/DISTRIB_ID=//' | tr '[:upper:]' '[:lower:]')
    fi

    if [ -z "$OPERATING_SYSTEM_VERSION" ]; then #String is null, that is, has zero length
        OPERATING_SYSTEM_VERSION=$(awk '/DISTRIB_RELEASE=/' $SEARCH_FILE | sed 's/DISTRIB_RELEASE=//' | sed 's/[.]0/./')
    fi

    #Checking Linux distro
    case $OPERATING_SYSTEM_BASED in
        "arch") OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_ARCH ;;
        "rhel fedora" | "fedora" | "centos" | "rhel") OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_REDHAT ;;
        "ubuntu" | "debian") OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_DEBIAN ;;
        "suse") OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_OPENSUSE ;;
        *) checking_linux_operating_system_using_command_awk_unknown ;;
    esac
}

function checking_linux_operating_system_using_command_awk_unknown(){
    local SEARCH_FILE="/etc/os-release"

    OPERATING_SYSTEM_BASED=$(awk '/ID=/' $SEARCH_FILE | sed 's/ID=//' | tr '[:upper:]' '[:lower:]')

    #Must be implemented more options
    case $OPERATING_SYSTEM_BASED in
        "alpine") OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_ALPINE ;;
        "arch") OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_ARCH ;;
        "debian") OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_DEBIAN ;;
        "rhel fedora" | "fedora" | "centos" | "rhel") OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_REDHAT ;;
        "slackware") OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_SLACKWARE ;;
        "sles") OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_OPENSUSE ;;
        *) OPERATING_SYSTEM_BASED="Unknown" ;;
    esac
}

#Unused function. Maybe someday in case of some problem
function checking_linux_operating_system_using_command_which(){
    if command -v dnf &> /dev/null || command -v yum &> /dev/null; then
        OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_REDHAT
    elif command -v apt &> /dev/null; then
        OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_DEBIAN
    elif command -v apk &> /dev/null; then
        OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_ALPINE
    elif command -v pacman &> /dev/null; then
        OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_ARCH
    else
        OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_UNKNOWN
    fi
}

#This function is only be called if there is no "ID_LIKE" on /etc/*-release files.
function checking_linux_operating_system_using_command_grep(){
    OPERATING_SYSTEM_NAME=$(cat /etc/*-release | grep "^NAME=" | cut -d '=' -f 2)
    OPERATING_SYSTEM_VERSION=$(cat /etc/*-release | grep "^ID=" | cut -d '=' -f 2)
    #OPERATING_SYSTEM_BASED=$(cat /etc/*-release | grep "^ID_LIKE=" | cut -d '=' -f 2)
    #OPERATING_SYSTEM_BASED="This is an original Linux distro!"
    OPERATING_SYSTEM_BASED="$OPERATING_SYSTEM_NAME"

    #Checking Linux distro
    case $OPERATING_SYSTEM_NAME in
        "alpine") OPERATING_SYSTEM_BASED=$OPERATING_SYSTEM_BASEMENT_ALPINE ;;
        "arch") OPERATING_SYSTEM_NAME=$OPERATING_SYSTEM_BASEMENT_ARCH ;;
        "rhel fedora" | "fedora" | "centos" | "rhel") OPERATING_SYSTEM_NAME=$OPERATING_SYSTEM_BASEMENT_REDHAT ;;
        "ubuntu" | "debian") OPERATING_SYSTEM_NAME=$OPERATING_SYSTEM_BASEMENT_DEBIAN ;;
        "suse") OPERATING_SYSTEM_NAME=$OPERATING_SYSTEM_BASEMENT_OPENSUSE ;;
        "Slackware") OPERATING_SYSTEM_NAME=$OPERATING_SYSTEM_BASEMENT_SLACKWARE ;;
        *) checking_linux_operating_system_using_command_awk_unknown ;;
    esac
}

function print_all(){
    echo -e "$INTRODUCTION_MESSENGE\n\nWhere is this script running? $IS_RUNNING_INSIDE_DOCKER_MESSENGE\nYour processor arch is: $PROCESSOR_ARCH\nYour processor arch bits is: $PROCESSOR_ARCH_BITS\nYour oprating system is based on: $OPERATING_SYSTEM_BASED\nYour oprating system name is: $OPERATING_SYSTEM_NAME\nYour oprating system version is: $OPERATING_SYSTEM_VERSION"
}

#############################
#Calling the functions
#############################

#Files to be checked
FILE_SYSTEM_LINUX="/etc/os-release"
FILE_SYSTEM_MACOS="/usr/libexec/PlistBuddy"

checking_processor_arch

#Threatment to check if the system information files exists on Linux and MacOS
if [[ -f $FILE_SYSTEM_LINUX ]]; then
    INTRODUCTION_MESSENGE="Excellent!!! You are a Linux user \o/"

    check_if_this_script_is_running_inside_docker_container_or_not

    if grep -q "^ID_LIKE=" /etc/*-release; then
        echo "Found: ID_LIKE on /etc/*-release"
        checking_linux_operating_system_using_command_awk
        #checking_linux_operating_system_using_command_which
    else
        echo "Not found: ID_LIKE on /etc/*-release"
        checking_linux_operating_system_using_command_grep
    fi
elif [[ -f $FILE_SYSTEM_MACOS ]]; then
    INTRODUCTION_MESSENGE="Good! You are a MacOS USER"
    
    OPERATING_SYSTEM_BASED="Unix"
    OPERATING_SYSTEM_NAME="$(sw_vers -productName)"
    OPERATING_SYSTEM_VERSION="$(sw_vers -productVersion)"
else
    INTRODUCTION_MESSENGE="So bad! You are probably using FreeBSD or Windows operating system."
fi

#Convertion from possible upper case characters to lower case
AUX1="$(echo $1 | tr A-Z a-z)"
AUX2="$(echo $2 | tr A-Z a-z)"

#Script paramenters threatments control to clear the display or not.
case $AUX2 in
    "-c" | "--clear") clear ;;
    *) : ;; #Does not do nothing
esac

#Script paramenters threatments control to display all the variables or not.
case $AUX1 in
    "") echo "Inform a parameter to display a variable container" ;;
    "-p" | "--print") print_all ;;
    "-a" | "--arch") echo "$PROCESSOR_ARCH" ;;
    "-ab" | "--arch-bits") echo "$PROCESSOR_ARCH_BITS" ;;
    "-d" | "--docker") echo "$IS_RUNNING_INSIDE_DOCKER" ;;
    "-dm" | "--docker-message") echo "$IS_RUNNING_INSIDE_DOCKER_MESSENGE" ;;
    "-m" | "--messenge") echo "$INTRODUCTION_MESSENGE" ;;
    "-os" | "--operating-system") echo -e "$OPERATING_SYSTEM_BASED\n$OPERATING_SYSTEM_NAME\n$OPERATING_SYSTEM_VERSION" ;;
    "-osb" | "--operating-system-based") echo "$OPERATING_SYSTEM_BASED" ;;
    "-osn" | "--operating-system-name") echo "$OPERATING_SYSTEM_NAME" ;;
    "-osv" | "--operating-system-version") echo "$OPERATING_SYSTEM_VERSION" ;;
    *) : ;; #Does not do nothing
esac