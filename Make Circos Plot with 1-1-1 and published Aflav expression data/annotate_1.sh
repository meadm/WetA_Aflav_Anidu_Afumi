#!/bin/bash
#read in each line of the 1:1:1 orthos file
while read LINE; do
#make a variable that is each gene id
    FLAV=$(echo $LINE | cut -d ' ' -f1,1)
	NIDU=$(echo $LINE | cut -d ' ' -f2,2)
	FUMI=$(echo $LINE | cut -d ' ' -f3,3)
#check to see if the id is in any of the expression pattern files I made with the awk script
#if it is in that specific file, print the line and annotate it with whatever file it was found in
    if grep -q -w "$FLAV" flav_fumi_induced.txt; then
		echo $LINE "flav_fumi_induced" >> 1_1_1_annotated.txt
	elif grep -q -w "$FLAV" flav_fumi_repressed.txt; then
		echo $LINE "flav_fumi_repressed" >> 1_1_1_annotated.txt
	elif grep -q -w "$FLAV" flav_induced.txt; then	
		echo $LINE "flav_induced" >> 1_1_1_annotated.txt
	elif grep -q -w "$FLAV" flav_nidu_induced.txt; then
		echo $LINE "flav_nidu_induced" >> 1_1_1_annotated.txt
	elif grep -q -w "$FLAV" flav_nidu_repressed.txt; then
		echo $LINE "flav_nidu_repressed" >> 1_1_1_annotated.txt
	elif grep -q -w "$FLAV" flav_repressed.txt; then
		echo $LINE "flav_repressed" >> 1_1_1_annotated.txt
	elif grep -q -w "$FUMI" fumi_induced.txt; then
		echo $LINE "fumi_induced" >> 1_1_1_annotated.txt
    elif grep -q -w "$FUMI" fumi_repressed.txt; then
        echo $LINE "fumi_repressed" >> 1_1_1_annotated.txt
    elif grep -q -w "$FLAV" induced.txt; then
        echo $LINE "induced" >> 1_1_1_annotated.txt
    elif grep -q -w "$NIDU" nidu_fumi_induced.txt; then
        echo $LINE "nidu_fumi_induced" >> 1_1_1_annotated.txt
    elif grep -q -w "$NIDU" nidu_fumi_repressed.txt; then
        echo $LINE "nidu_fumi_repressed" >> 1_1_1_annotated.txt
    elif grep -q -w "$NIDU" nidu_induced.txt; then
        echo $LINE "nidu_induced" >> 1_1_1_annotated.txt
    elif grep -q -w "$NIDU" nidu_repressed.txt; then
        echo $LINE "nidu_repressed" >> 1_1_1_annotated.txt
    elif grep -q -w "$FLAV" repressed.txt; then
        echo $LINE "repressed" >> 1_1_1_annotated.txt
    else
        echo $LINE "rando" >> 1_1_1_annotated.txt
    fi
done <1_1_1_sig.txt	
