#!/bin/bash

declare -a university_algorithm
declare -a university_android
declare -a university_testEpam

declare -a main_git_zaezd
declare -a main_git_telegram_sticker

declare -a custom_hacker

university_algorithm+=("https://github.com/Starmordar/algorithm-university")
university_testEpam+=("https://github.com/Starmordar/automation-training")
university_android+=("https://github.com/Starmordar/university-android")

main_git_zaezd+=("https://github.com/jarki-zaezd/jarki-zaezd.github.io")
main_git_main_git_telegram_sticker+=("https://github.com/Starmordar/telegram-sticker-pack")

custom_hacker+=("https://github.com/Starmordar/fast-work-start")

open_google_links () {
    arr=("$@")

    for i in "${arr[@]}";
      do
          google-chrome $i &>/dev/null & disown
          wait
      done
}