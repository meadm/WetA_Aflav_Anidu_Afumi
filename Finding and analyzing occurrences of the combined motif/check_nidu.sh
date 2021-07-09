#!/bin/bash
while read LINE; do
    NIDUID=$(echo $LINE | cut -d ' ' -f2,2)
    if grep -wq "$NIDUID" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans_ChIP/Combining\ both\ sets/Motif-finding/FIMO/nidu/5e-5/nidu_FIMO_5e-5_genes.txt; then
        echo $LINE >> nidu_fumi_conserved_WRE.txt
    fi
#1 is the name of the file that contains consistently regulated genes that also have a WRE in their upstream region in A. fumigatus
done < $1
