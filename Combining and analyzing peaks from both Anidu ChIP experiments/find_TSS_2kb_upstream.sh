#!/bin/bash
while read LINE; do
	STRAND=$(echo $LINE | cut -d ' ' -f7,7)
	CHROM=$(echo $LINE | cut -d ' ' -f1,1)
	ID=$(echo $LINE | cut -d ' ' -f9,9 | cut -d '=' -f2,2 | cut -d '-' -f1,1) 
	if [ "$STRAND" == "+" ]; then
		CDSEND=$(echo $LINE | cut -d ' ' -f4,4)
		let UPSTRMEND=CDSEND-1
		let UPSTRMSTART=UPSTRMEND-2000
		echo $CHROM"	"$UPSTRMSTART"	"$UPSTRMEND"	"$ID >> FungiDB-32_AnidulansFGSCA4_2kb_upstream.bed
	elif [ "$STRAND" == "-" ]; then
		CDSEND=$(echo $LINE | cut -d ' ' -f5,5)
		let UPSTRMEND=CDSEND+1
		let UPSTRMSTART=UPSTRMEND+2000
		echo $CHROM"	"$UPSTRMEND"	"$UPSTRMSTART"	"$ID >> FungiDB-32_AnidulansFGSCA4_2kb_upstream.bed
	fi
done < FungiDB-32_AnidulansFGSCA4_CDS1.gff
