#!/bin/bash
while read PROTEOME; do
	CARROT=$(echo $PROTEOME | cut -c1)
	if [ "$CARROT" = ">" ]
	then
		REFSEQ=$(echo $PROTEOME | cut -c2-13)
		AFLA=$(grep "$REFSEQ" flavus_refseq_locustag2.txt | cut -f2)
		echo ">"$AFLA >> flavus_proteins.fasta
	else
		echo $PROTEOME >> flavus_proteins.fasta
	fi
done <GCF_000006275.2_JCVI-afl1-v2.0_protein.faa
