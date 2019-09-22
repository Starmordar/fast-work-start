#!/bin/bash

university_poll () {
    echo "1 - Algorithm"
    echo "2 - Android"
    echo "3 - Testing"
    echo "4 - Back"

    read -n 1 -t 15 action

    case $action in 

    1* ) university_algorithm_open;;
    2* ) echo "Android";;
    3* ) echo "Testing";;
    4* ) main_poll;;

    esac
}

custom_poll() {
    echo "1 - Hack script"
    echo "2 - Back"

    read -n 1 -t 15 action

    case $action in 

    1* ) echo "Hack script";;
    2* ) main_poll;;

    esac
}

git_projects_poll() {
    echo "1 - Jarki-zaezd"
    echo "2 - Sticker Pack creator"
    echo "3 - Back"

    read -n 1 -t 15 action

    case $action in 

    1* ) echo "Jarki-zaezd";;
    2* ) echo "Sticker Pack creator";;
    3* ) main_poll;;

    esac
}

main_poll() {
    clear
    echo "1 - Custom directory"
    echo "2 - University"
    echo "3 - Main projects"

    read -n 1 -t 15 action
    printf "\n"
    echo $action1

    case $action in

    1* ) custom_poll;;
    2* ) university_poll;;
    3* ) git_projects_poll;;

    esac
}

main_poll