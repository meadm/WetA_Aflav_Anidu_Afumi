#!/bin/bash
while read LINE; do
	STRAND=$(echo $LINE | cut -d ' ' -f7,7)
	CHROM=$(echo $LINE | cut -d ' ' -f1,1)
	ID=$(echo $LINE | cut -d ' ' -f9,9 | cut -d '=' -f2,2 | cut -d '-' -f1,1) 
	if [ "$STRAND" == "+" ]; then
		TSS=$(echo $LINE | cut -d ' ' -f4,4)
		let TSSUP=TSS-2000
		echo $CHROM"	"$TSSUP"	"$TSS"	"$ID >> FungiDB-32_AnidulansFGSCA4_2kb_upstream_TSS.bed
	elif [ "$STRAND" == "-" ]; then
		TSS=$(echo $LINE | cut -d ' ' -f5,5)
		let TSSUP=TSS+2000
		echo $CHROM"	"$TSS"	"$TSSUP"	"$ID >> FungiDB-32_AnidulansFGSCA4_2kb_upstream_TSS.bed
	fi
done < FungiDB-32_AnidulansFGSCA4_CDS1.gff
