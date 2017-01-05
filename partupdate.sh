#!/bin/bash

package_version=$1

if [ ! -n "${package_version}" ]; then
    echo "please input version as format below: "
    echo "./partupdate.sh "hostfs_R1B_rtl_v0.16.20161110v1p""
elif [ ! -f /home/root/filesystempartupdate/package/${package_version}.tar.bz2 ]; then
    echo "you have echo a wrong version number, please input the correct version number"
else
    #stop sleep
    supervisorctl stop systemctrller_wake_locker 

    # start update
    if [ -f /home/root/filesystempartupdate/package/start_update.wav ]; then
        play /home/root/filesystempartupdate/package/start_update.wav
    fi
    
    if [ -f /home/root/filesystempartupdate/package/Bandari2_16_8000.wav ]; then
        /usr/bin/repeat_play.sh /home/root/filesystempartupdate/package/Bandari2_16_8000.wav &
    fi

    #rm index file
    old_index=()
    cnt=1
    for line in `cat /home/root/filesystempartupdate/index/old_index.md`
    do

        echo $cnt":"$line
        #remove line
        line=${line/./}
        echo $line
        rm -rf $line
        let "cnt=cnt+1"
    done

    #rm /usr/nativeapps
    rm -rf /usr/nativeapps

    #rm /usr/nativeapps_test
    rm -rf /usr/nativeapps_test

    #un-tar the update package the root folder
    tar -jxvf ${package_version}.tar.bz2 -C /

    #update done
    repeat_play_pid=`ps |grep repeat_play.sh|grep -v "grep"|awk '{print $1}'`
    play_pid=`ps |grep play|grep -v "grep"|awk '{print $1}'`

    for i in ${repeat_play_pid[@]}
    do
        echo $i
    kill -9 $i
    done

    for i in ${play_pid[@]}
    do
        echo $i
        kill -9 $i
    done

    if [ -f /home/root/filesystempartupdate/package/update_success.wav ]; then
        play /home/root/filesystempartupdate/package/update_success.wav
    fi

    #reboot
    reboot

fi