#!/bin/bash
while read LINE; do
	STRAND=$(echo $LINE | cut -d ' ' -f7,7)
	CHROM=$(echo $LINE | cut -d ' ' -f1,1)
	ID=$(echo $LINE | cut -d ' ' -f9,9 | cut -d '=' -f2,2 | cut -d '-' -f1,1) 
	if [ "$STRAND" == "+" ]; then
		TSS=$(echo $LINE | cut -d ' ' -f4,4)
		let TSSEND=TSS+1
		echo $CHROM "	" $TSS "	" $TSSEND "	" $ID >> FungiDB-32_AnidulansFGSCA4_TSS.bed
	elif [ "$STRAND" == "-" ]; then
		TSSEND=$(echo $LINE | cut -d ' ' -f5,5)
		let TSS=TSSEND-1
		echo $CHROM "	" $TSS "	" $TSSEND "	" $ID >> FungiDB-32_AnidulansFGSCA4_TSS.bed
	fi
done < FungiDB-32_AnidulansFGSCA4_CDS1.gff
