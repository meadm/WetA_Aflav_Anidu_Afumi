#!/bin/bash
while read LINE; do
    ID=$(echo $LINE| cut -d ' ' -f1,1)
#2 is the that contains the annotations you need
    grep -w $ID $2 >> flav_regulated_annotations.txt
#1 is the file that you want to annotate
done < $1
