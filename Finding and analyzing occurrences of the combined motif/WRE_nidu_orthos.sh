#!/bin/bash
while read NIDUGENE; do
    grep -w "$NIDUGENE" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/manuscript/Drafts/1-2-18/Files\ for\ Ming/Orthologs/NNN_expression.txt >> WRE_nidu_orthos.txt
done < /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans_ChIP/Combining\ both\ sets/Motif-finding/FIMO/nidu/1e-5/FIMO_1e-5_genes.txt
while read FUMIGENE; do
    grep -w "$FUMIGENE" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans_ChIP/Combining\ both\ sets/Motif-finding/FIMO/3\ species/WRE_nidu_orthos.txt >> WRE_nidu_fumi_orthos.txt
done < /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans_ChIP/Combining\ both\ sets/Motif-finding/FIMO/fumi/FIMO_fumi_genes.txt
while read FLAVGENE; do
    grep -w "$FLAVGENE" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans_ChIP/Combining\ both\ sets/Motif-finding/FIMO/3\ species/WRE_nidu_fumi_orthos.txt >> WRE_nidu_fumi_flav_orthos.txt
done < /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans_ChIP/Combining\ both\ sets/Motif-finding/FIMO/flav/FIMO_flav_genes.txt
