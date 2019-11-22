#!/usr/bin/env bash
#title           :post-install.sh
#description     :This script will install predefined programs 
# after user defined options.
#author		     :Jan Gehlen
#date            :2019-11-22
#version         :0.1    
#usage		     :bash post-install.sh
#==============================================================================

# exit on error
set -euo pipefail

# Create array, which hold options for whiptail
available_options=( \
    "chromium" "Chromium Browser" on \
    "git" "Git" on \
    "py_ce" "PyCharm Community Edition" off \
    "py_pro" "PyCharm Pro Edition" off \
    "r" "R and Rstudio Desktop" on \
    "skype" "MS Skype" off \
    "slack" "Slack" off \
    "snapd" "snap" on \
    "vscode" "MS Visual Study Code" on \
    )
# Dialog Box with selection options:
CHOICES=$(whiptail --separate-output --title "Select Programs" --checklist "Select Programs to be installed:" 25 55 15 \
    "${available_options[@]}" 3>&1 1>&2 2>&3 )

# Enter password:
PASSWORD=$(whiptail --passwordbox "Please enter your secret password" 8 50 --title "Enter Password" 3>&1 1>&2 2>&3)

for PROGRAM in ${CHOICES[@]}
do
printf "\033[1;31mInstalling ${PROGRAM}:\033[0m\n"

    if [ "$PROGRAM" == "chromium" ]
    then
        echo $PASSWORD | sudo -S apt -y install chromium-browser 
    fi    

    if [ "$PROGRAM" == "git" ]
            then
                echo $PASSWORD | sudo -S apt -y install git
    fi    

    if [ "$PROGRAM" == "r" ]
            then
                # R and Rstudio
                echo $PASSWORD | sudo -S apt -y install r-base-dev
                # Rstudio
                wget https://download1.rstudio.org/desktop/bionic/amd64/rstudio-1.2.5019-amd64.deb
                echo $PASSWORD | sudo -S apt -y install ./rstudio-1.2.5019-amd64.deb
                rm rstudio-1.2.5019-amd64.deb
    fi    

    if [ "$PROGRAM" == "py_ce" ]
            then
                echo $PASSWORD | sudo -S snap install pycharm-community --classic
    fi    

    if [ "$PROGRAM" == "py_pro" ]
            then
                echo $PASSWORD | sudo -S snap install pycharm-professional --classic
    fi    

    if [ "$PROGRAM" == "skype" ]
            then
                echo $PASSWORD | sudo -S snap install skype --classic
    fi  

    if [ "$PROGRAM" == "slack" ]
            then
                echo $PASSWORD | sudo -S snap install slack --classic
    fi  

    if [ "$PROGRAM" == "snapd" ]
            then
                echo $PASSWORD | sudo -S apt -y install snapd
    fi    

    if [ "$PROGRAM" == "spotify" ]
            then
                echo $PASSWORD | sudo -S snap install spotify 
    fi  

    if [ "$PROGRAM" == "vscode" ]
            then
                echo $PASSWORD | sudo -S snap install code --classic
    fi    

    if [ "$PROGRAM" == "zoom" ]
            then
                wget https://zoom.us/client/latest/zoom_amd64.deb
                echo $PASSWORD | sudo -S apt -y install ./zoom_amd64
                rm zoom_amd64 
    fi  


done

echo "Good bye!"


# Add program with this scheme
# if [ "$PROGRAM" == "" ]
    #         then
    #             # echo $PASSWORD 
    # fi  