#!/bin/bash
while read GENE; do
#find the strand the gene is on
	STRAND=$(grep -w "$GENE" $1 | head -n1 | cut -f7,7)
#find the chromosome the gene is on
	CHROM=$(grep -w "$GENE" $1 | head -n1 | cut -f1,1)
#if the gene is on the positive strand...
	if [ "$STRAND" == "+" ]; then
#find the end of the last CDS
#1 is the GFF file
		CDSEND=$(grep -w "$GENE" $1 | grep 'CDS' | tail -n1 | cut -f5,5)
#the UTR will start one base after the end of the last CDS
		let UTRSTART=CDSEND+1
#the end the downstream region 2kb after the start of the UTR
		let UTRSTOP=UTRSTART+2000
#print the chromosome, start of the UTR, the end of the UTR, and the gene name in BED format
		echo $CHROM"	"$UTRSTART"	"$UTRSTOP"	"$GENE >> FungiDB-32_AnidulansFGSCA4_2kb_downstream.bed
	elif [ "$STRAND" == "-" ]; then
		CDSEND=$(grep -w "$GENE" $1 | grep 'CDS' | head -n1 | cut -f4,4)
		let UTRSTART=CDSEND-1
		let UTRSTOP=UTRSTART-2000
		echo $CHROM"	"$UTRSTART"	"$UTRSTOP"	"$GENE >> FungiDB-32_AnidulansFGSCA4_2kb_upstream_TSS.bed
	fi
done < nidulans_all_genes.txt
