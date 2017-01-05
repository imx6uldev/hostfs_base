#!/bin/bash


index=()
SAVEIFS=$IFS
IFS=$(echo -en "\n\b")
#1. find all paths
all_paths=`find -type d`
for path in ${all_paths[@]}
do
    if [ `ls $path|wc -l` == 0 ]; then
        echo $path
        index=(${index[@]} $path)
    fi
done

#2. find all files
all_files=`find -type f|grep -v 'index.sh'|grep -v 'old_index.md'|grep -v 'part_update.sh'|grep -v 'nativeapps'|grep -v 'nativeapps_test'`
index=(${index[@]} ${all_files[@]})

#3. fild all softlink files
all_softlink_files=`find -type l|grep -v 'nativeapps'`
echo ${all_softlink_files[@]}
index=(${index[@]} ${all_softlink_files[@]})

##4. replace "./" with "/"
#index=${index[@]/./}

#5. write to old_index.md
echo ${index[@]} > old_index.md

#6. display index
cnt=1
for i in ${index[@]}
do
    echo $cnt":"$i
    let "cnt=cnt+1"
done