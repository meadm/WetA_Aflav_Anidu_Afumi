#!/bin/bash
while read ORTHOS; do
	FLAV=$(echo $ORTHOS | cut -d ' ' -f4- | cut -d '(' -f1,1)
	NIDU=$(echo $ORTHOS | cut -d ' ' -f5- | cut -d '(' -f1,1)
	FUMI=$(echo $ORTHOS | cut -d ' ' -f6- | cut -d '(' -f1,1)
	if grep -q -w "$FLAV" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/a_flavus\ wetA/Updates/PUBLISHED_flav_sig.txt; then
		FLAVEX=$(grep -w "$FLAV" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/a_flavus\ wetA/Updates/PUBLISHED_flav_sig.txt | cut -f3,3)
	else
		FLAVEX=$(echo 0)
	fi
	if grep -q -w "$NIDU" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans\ RNAseq/FungiDB-based\ Analyses/DESeq2/nidu_sig.txt; then
		NIDUEX=$(grep -w "$NIDU" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/nidulans\ RNAseq/FungiDB-based\ Analyses/DESeq2/nidu_sig.txt | cut -f3,3)
	else
		NIDUEX=$(echo 0)
	fi
	if grep -q -w "$FUMI" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/fumigatus\ RNAseq/FungiDB-based\ Analysis/DESeq2/fumi_sig.txt; then
		FUMIEX=$(grep -w "$FUMI" /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/fumigatus\ RNAseq/FungiDB-based\ Analysis/DESeq2/fumi_sig.txt | cut -f3,3)
	else
		FUMIEX=$(echo 0)
	fi
	echo $FLAV $NIDU $FUMI $FLAVEX $NIDUEX $FUMIEX >> 1_1_1_sig.txt
done <../../3genes3taxa_fungiDB.txt
