#!/bin/bash
while read LINE; do
#check to see if gene is only regulated in flavus
    SPECCHECK=$(grep "$LINE" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/Updates/6th\ Update_October\ 2017/10-6-17/new_NNN_tables/L_induced.txt)
    if [[ $SPECCHECK ]]; then
        NIDUID=$(echo $SPECCHECK | cut -d ' ' -f2,2)
        NIDUCHECK=$(grep -w "$NIDUID" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans_ChIP/Combining\ both\ sets/Motif-finding/FIMO/nidu/5e-5/nidu_FIMO_5e-5_genes.txt)
        if [[ $NIDUCHECK ]]; then
            :
        else
            FUMIID=$(echo $SPECCHECK | cut -d ' ' -f3,3)
            FUMICHECK=$(grep -w "$FUMIID" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans_ChIP/Combining\ both\ sets/Motif-finding/FIMO/fumi/5e-5/fumi_FIMO_5e-5_genes.txt)
            if [[ $FUMICHECK ]]; then
                :
            else
                echo $SPECCHECK >> flav_specific_WRE_regulated.txt
            fi
        fi
    fi
    REDUCHECK=$(grep "$LINE" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/Updates/6th\ Update_October\ 2017/10-6-17/new_NNN_tables/L_reduced.txt)
    if [[ $REDUCHECK ]]; then
        NIDUID=$(echo $REDUCHECK | cut -d ' ' -f2,2)
        NIDUCHECK=$(grep -w "$NIDUID" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans_ChIP/Combining\ both\ sets/Motif-finding/FIMO/nidu/5e-5/nidu_FIMO_5e-5_genes.txt)
        if [[ $NIDUCHECK ]]; then
            :
        else
            FUMIID=$(echo $REDUCHECK | cut -d ' ' -f3,3)
            FUMICHECK=$(grep -w "$FUMIID" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans_ChIP/Combining\ both\ sets/Motif-finding/FIMO/fumi/5e-5/fumi_FIMO_5e-5_genes.txt)
            if [[ $FUMICHECK ]]; then
                :
            else
                echo $REDUCHECK >> flav_specific_WRE_regulated.txt
            fi
        fi
    fi
done < flav_FIMO_5e-5_genes.txt
