#!/bin/sh

set -e

help () {
    cat<<EOF
Usage: quick-shell [install|uninstall|help]
Commands:

    install    installs from the git repo
    uninstall  restores original settings
    help       print this msg
EOF
}

backup () {
    if [ -e ~/shell-backup ]
    then
        echo 'skipping backup'
    else
        mkdir -p ~/shell-backup
        if [ -e ~/.bashrc ]
        then
            mv ~/.bashrc ~/shell-backup/.bashrc
        else
            touch ~/.bashrc && mv ~/.bashrc ~/shell-backup/.bashrc
          fi
        if [ -e ~/.bash_profile ]
        then
            mv ~/.bash_profile ~/shell-backup/.bash_profile
        else
            touch ~/.bash_profile && mv ~/.bash_profile ~/shell-backup/.bash_profile
        fi
        fi
    echo "Backups are in ~/shell-backup"
}

install () {
    backup
    cp ./.bashrc ~/.bashrc
    cp ./.bash_profile ~/.bash_profile
}

uninstall () {
    if [ -e ./backup ]
    then
        if [ -e ~/shell-backup/.bashrc ]
        then
            mv ~/shell-backup/.bashrc ~/.bashrc
        fi
        if [ -e ~/shell-backup/.bash_profile ]
        then
            mv ~/shell-backup/.bash_profile ~/.bash_profile
        fi
        rm -rf ~/shell-backup
    fi
}


# fucking cryptic bash, test for a valid arg and execute it if so; otherwise show the help
if [ "$1" != "" ]; then
    wl=(install uninstall upgrade help)
    for i in "${wl[@]}"
    do
        if [ "$i" == "$1" ]
        then
            $1
            exit 0
        fi
    done
fi

# show a flailer some help
help
exit 0
