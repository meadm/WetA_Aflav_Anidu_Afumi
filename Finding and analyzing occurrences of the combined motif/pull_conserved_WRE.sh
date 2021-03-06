#!/bin/bash
while read LINE; do
    ID=$(echo $LINE | cut -d ' ' -f1,1)
    grep -w $ID /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/Updates/6th\ Update_October\ 2017/10-6-17/new_NNN_tables/ALL_induced.txt >> fumi_conserved_5e-5_WRE.txt
    grep -w $ID /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/Updates/6th\ Update_October\ 2017/10-6-17/new_NNN_tables/ALL_reduced.txt >> fumi_conserved_5e-5_WRE.txt
#1 is the file that contains the regulated genes that also have a WRE in their upstream region
done < $1
