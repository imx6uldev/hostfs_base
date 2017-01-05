#!/bin/bash

wav_name=$1

while true
do
    play_exist=`ps |grep $wav_name|grep -v "grep"|wc -l`
    if [ $play_exist == 0 ]; then
        play $wav_name
    fi
    
done