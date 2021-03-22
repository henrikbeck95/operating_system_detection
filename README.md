# Operating system detection

## Description

This project is a shell script application that has been developmented to identify which Linux distro or MacOS X version is running on the current operating system. It is an API and it can be useful for developers settting the right commands on the terminal according to the right Linux distro package manager or the MacOS X commands. As well as both of them use `Bash` terminals.

Futhermore this project is also able to identify if the current operating system is running inside a Docker container or it is running on the host machine.

## Inspiration (little story that you can skip it)

As a Linux distro hopper I know exactly how automation enviroments sounds to be amazing for quickly setting a setup with only one command. By the way, it is not so easy coding a script for each Linux distro basement such as `Debian`, `Fedora` or even `ArchLinux` futhermore a `MacOS X` or `Windows` operating system which I still use them. The commands are different between them mainly the package managers.

However if you are also a `Docker` user you probably know that some Shell scripts should not be rewritten with one dedicated version for running inside a Docker container and another dedicated version for running on the host machine. How would it be incredible if you could write only one script and it distinguishes the way it should works using a switch case or if/else threatment. In this scenario you could save your time reusing the variables once you have already declared.

Otherwise identifying the right operating system I am using is certainly the first step to start the automation setups. Besides it would be more amazing if I must not implement all the source code threatment every single time I must code a new Shell script project. 

I am sure you have also identified yourself with some (or all) these words above. This is the reason why this project exists! This is the reason why you are here.

## What this script does...

- Once this script is implemented on your source code **the only thing this software does** is to identify the current user's operating system and export this information to your software. Such as the terminal commands might be different from each Linux distribution this API can tell your source code these informations. Keep in mind that is your software responsability to identify the best conditional statements to procede once you get these datas.

- This API is able to export these operating system variables information to your code. You can test if this script is working just typing on your terminal one of the following options below

    1. Giving the executable permission to this script file
        > $ `chmod +x ./operating_system_detection.sh`

    1, Importing the Operating system detection script file (without parameters it only displays if it is Linux or MacOS X)
        > $ `source ./operating_system_detection.sh`

    1. Using the new avaliable variables
        - Get a funny introduction messenge based on with operating system you are using
            > $ `echo $INTRODUCTION_MESSENGE`

        - Check if the script is running inside a Docker container or in the host machine
            > $ `echo $IS_RUNNING_INSIDE_DOCKER`
        
        - Check the user's processor architecture
            > $ `echo $PROCESSOR_ARCH`
        
        - Check the user's processor architecture
            > $ `echo $PROCESSOR_ARCH_BITS`
        
        - Check the user's current operating system basement
            > $ `echo $OPERATING_SYSTEM_BASED`
        
        - Check the user's current operating system name
            > $ `echo $OPERATING_SYSTEM_NAME`
        
        - Check the user's current operating system version
            > $ `echo $OPERATING_SYSTEM_VERSION`

        - Using it with one command for only displaying the specified variables
            > $ `source ./operating_system_detection.sh && echo -e "\nYour oprating system is: $OPERATING_SYSTEM_NAME"`
    
    1. Using parameters
        - Avaliable parameters list
            - Display all the available variables `-p` or `--print`
            - Display processor arch variable `-a` or `--arch`
            - Display processor arch bits variable `-ab` or `--arch-bits`
            - Display if the scripting is running inside a docker container variable `-d` or `--docker`
            - Display if the scripting is running inside a docker container messenge variable `-dm` or `--docker-message`
            - Display the introduction messenge `-m"`or `--messenge`
            - Display all the available operating system variables `-os` or `--operating-system`
            - Display operating system basement variable `-osb` or `--operating-system-based`
            - Display operating system name variable `-osn` or `--operating-system-name`
            - Display operating system versio variable `-osv` or `--operating-system-version`
            - Clear the display and then display the current command `"-c` or ` clear`

        - Example
            > $`source ./operating_system_detection.sh -p` or $`source ./operating_system_detection.sh --print`

## What this script does not do...

- This script **does not** do any modification on the operating system that runs this code.

- This script **does not** exports user's privacy informations such as a telemetry method or generate some user's statistics.

## How does this script works?

- This API uses the `/etc/os-release`, `lsb_release`, `/etc/lsb-release`, `/etc/*-release`, `/proc/1/cgroup -qa` and `/usr/libexec/PlistBuddy` files with regular expressions to identify the informations.

## Warning!

1. Be sure you have not forgotten to give this script the executable permission.
    > $ `chmod +x ./operating_system_detection.sh`

1. This software does not require `sudo` administration permissions to be used. At least if you are going to implement this script on your software to make critical modifications such as installing new softwares then your must run your code with `sudo` anyway.

1. It is not a good practic to implement this script on `$HOME/.bashrc` file or `$HOME/.zshrc` file as an alias. The best practic is to use this script always inside your source code folder.

1. If you are developing using any other language besides the `Shell script` be sure the following steps might not work rightly unless you search about how to use `bash` commands on the programming language you want by yourself.

## Usage

### Implement this file on your own project

- Download the shell script file
    - Method 1
        > $ `curl https://raw.githubusercontent.com/henrikbeck95/operating_system_detection/main/tests/build.sh --output build.sh`
    
    - Method 2
        > $ `wget https://raw.githubusercontent.com/henrikbeck95/operating_system_detection/main/tests/build.sh -O build.sh`

    - Method Error
        - In case of `ERROR: cannot verify raw.githubusercontent.com's certificate, issued by 'CN=DigiCert SHA2 High Assurance Server CA,OU=www.digicert.com,O=DigiCert Inc,C=US': Unable to locally verify the issuer's authority. To connect to raw.githubusercontent.com insecurely, use `--no-check-certificate'.` try:

            > $ `wget https://raw.githubusercontent.com/henrikbeck95/operating_system_detection/main/tests/build.sh --no-check-certificate -O build.sh`
    
    - Fastest mode (only recommended for running inside a Docker container)
        > $ `clear && rm -fr ./build.sh /operating_system_detection/ && wget https://raw.githubusercontent.com/henrikbeck95/operating_system_detection/main/tests/build.sh --no-check-certificate -O build.sh && ls && chmod +x ./build.sh && ./build.sh && ./operating_system_detection/operating_system_detection.sh --print`

- Give executable permission
    > $ `chmod +x ./build.sh`

- Build the API
    > $ `./build.sh`

- Run the API
    > $ `./operating_system_detection/operating_system_detection.sh` or $ `./operating_system_detection/operating_system_detection.sh --print`

### Check a specific information

- Download the shell script file
    > $ `curl https://raw.githubusercontent.com/henrikbeck95/operating_system_detection/main/tests/build.sh --output build.sh`

- Give executable permission
    > $ `chmod +x ./build.sh`

- Build the API
    > $ `./build.sh`

- Load the API
    > $ `source ./operating_system_detection/operating_system_detection.sh`

- Display the information (example)
    > $ `echo $PROCESSOR_ARCH_BITS`

<!--
### Online verification method

This method seems to be a good way to use the newest updated version from this script to your project. Once you have followed the right steps to implement this script on your project it is going to download the most recent version file avaliable on the offical repository and it is also going to erase the old version file download before.

- Requirements
    - Be sure [Wget](https://github.com/jay/wget) or [cURL](https://github.com/curl/curl) sorftware are already installed on the user's operating system. Do not worry almost every Linux distro or MacOS X already has installed at least one of these softwares by default.
    
- Source code

```bash
```

### Offline method

This method seems to be a better way for those whom wants more stability once the script file is not going to be updated automatically.

- Source code

```bash
```
-->

## Support this project

Help this project to stay alive improving the source code. Implement possible bugs fixes or new functions.

## Features

- Operating system information detection
    - [x] Operating system basement detection
    - [x] Operating system name detection
    - [x] Operating system version detection

- Processor architecture
    - [x] Processor architecture detection
    - [x] Processor architecture bits detection

- Container
    - [x] Docker detection
    - [ ] Podman detection <!--Not tested yet-->
    - [ ] Kubernates detection <!--Not tested yet-->

- Operating system detection
    - [x] Alpine
    - [ ] Android
    - [x] ArchLinux
    - [x] Debian
    - [x] Fedora
    - [ ] FreeBSD <!--Not implemented yet-->
    - [x] Gentoo
    - [ ] MacOS X <!--Not tested yet-->
    - [x] Mandriva
    - [ ] OpenSUSE <!--Not tested yet-->
    - [ ] RedHat <!--Not tested yet-->
    - [x] Slackware
    - [x] Ubuntu

- Windows subsystem (WSL) detection
    - [ ] Alpine <!--Not tested yet-->
    - [ ] Debian <!--Not tested yet-->
    - [ ] Kali Linux <!--Not tested yet-->
    - [ ] OpenSUSE <!--Not tested yet-->
    - [x] Ubuntu

<!--
## Ideas

- [ ] Identificar a interface gráfica
- [ ] Identificar a resolução da tela
- [ ] Identificar se está rodando em WSL ou não
-->