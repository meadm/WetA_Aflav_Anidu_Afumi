#!/bin/bash
for FILE in *repressed.txt; do
    COUNTER=0
    while read LINE; do
        if grep -q -w "$LINE" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/manuscript/Drafts/1-2-18/Files\ for\ Ming/Orthologs/ALL_reduced.txt; then
            let COUNTER=COUNTER+1
        fi
    done < $FILE
    TOTAL=$(wc -l < $FILE)
    NAME=$(echo $FILE | cut -d '_' -f1-2)
    echo $NAME $COUNTER $TOTAL >> fodder.txt
done
