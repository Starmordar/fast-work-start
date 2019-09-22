#!/bin/bash

declare -a university_link
university_link+=("https://github.com/Starmordar/algorithm-university")
university_link+=("https://stackoverflow.com/questions/29853974/wait-inside-loop-bash")

open_google_links () {
    arr=("$@")

    for i in "${arr[@]}";
      do
          google-chrome $i &>/dev/null & disown
          wait
      done
}

open_google_links "${university_link[@]}"
