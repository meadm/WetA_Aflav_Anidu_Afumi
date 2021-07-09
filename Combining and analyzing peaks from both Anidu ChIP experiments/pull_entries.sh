#!/bin/bash
while read PEAK; do
#2 is the fasta file that contains the entries you want
#3 is what you want to name the file
    grep -A1 -w "$PEAK" $2 >> $3
#1 is the file that contains the ids for the entries you want to pull
done < $1
