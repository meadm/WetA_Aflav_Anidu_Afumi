#!/bin/bash
while read LINE; do
    FIRST=$(echo $LINE | cut -c1)
    if [[ $FIRST == ">" ]]; then
        HEADER=$(echo $LINE | cut -d '|' -f1,1)
#2 is the name of the new file
        echo $HEADER >> $2
    else
        echo $LINE >> $2
    fi
#1 is the file that you want to strip
done < $1
