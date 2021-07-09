#!/bin/bash
while read LINE; do
#make a variable (or not) if the peak-associated gene is in the first column of the regulation data
    REGCHECK=$(awk -v LINE="$LINE" '$1 == LINE { print $0 }' nidu_regulated.txt)
#check to see if the variable exists
    if [ -z "$REGCHECK" ]; then
#if it doesn't exist, add a line to the file that says it doesn't exist
        echo $LINE NO N/A >> peak_genes_regulated_direction.txt
    else
#if it does exist, make a variable that is the log2 fold-change value (only before the period)
        DIRECTION=$(awk -v LINE="$LINE" '$1 == LINE { print $0 }' nidu_regulated.txt | cut -f3,3 | cut -d '.' -f1,1)
#if the regulation is positive, say it is induced
        if [[ "$DIRECTION" -gt "0" ]]; then
            echo $LINE YES induced >> peak_genes_regulated_direction.txt
#if the regulation is negative, say it is repressed
        elif [[ "$DIRECTION" -lt "0" ]]; then
            echo $LINE YES repressed >> peak_genes_regulated_direction.txt
        fi
    fi
done < peak_genes_all.txt
