#!/bin/bash

cnt=1
for line in `cat old_index.md`
do
    echo "$cnt:$line"
    if [ -f $line ]; then
        cp $line ../Tools_from_base/
        rm $line
    fi
    let "cnt=cnt+1"
    
done