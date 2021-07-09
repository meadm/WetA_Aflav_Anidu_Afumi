#!/bin/bash
while read LINE; do
    NIDUID=$(echo $LINE | cut -d ' ' -f2,2)
    if grep -wq "$NIDUID" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans_ChIP/Combining\ both\ sets/Motif-finding/FIMO/nidu/1e-5/FIMO_1e-5_genes_regulated.txt; then
        echo $LINE >> nidu_fumi_conserved_WRE.txt
    fi
done < fumi_conserved_WRE.txt
