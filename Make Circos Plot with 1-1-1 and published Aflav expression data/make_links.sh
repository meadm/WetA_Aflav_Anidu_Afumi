#!/bin/bash
#make "conserved" links
while read CONSERVED; do
	#make variables for all the "conserved" IDs
	FLAVUS=$(echo $CONSERVED | cut -d ' ' -f1,1)
	NIDU=$(echo $CONSERVED | cut -d ' ' -f2,2)
	FUMI=$(echo $CONSERVED | cut -d ' ' -f3,3)
	#make variables for the locations where the repressed genes are in the highlight files
	FLLOC=$(grep -w "#$FLAVUS" flav_highlights.txt | cut -f1-3)
	NILOC=$(grep -w "#$NIDU" nidu_highlights.txt | cut -f1-3)
	FULOC=$(grep -w "#$FUMI" fumi_highlights.txt | cut -f1-3)
	#make a line in the link file for flav_nidu
	echo $FLLOC $NILOC "color=(239,90,91)" "#" $FLAVUS $NIDU "conserved" >> conserved_links.txt
	#make a line in the link file for flav_fumi
	echo $FLLOC $FULOC "color=(239,90,91)" "#" $FLAVUS $FUMI "repressed" >> conserved_links.txt
	#make a line in the link file for nidu_fumi
	echo $NILOC $FULOC "color=(239,90,91)" "#" $NIDU $FUMI "repressed" >> conserved_links.txt
done < ../conserved.txt
echo conserved_links.txt done

#make flav_nidu links
while read FLANI; do
	#make variables for all the "flav_nidu" IDs
	FLAVUS=$(echo $FLANI | cut -d ' ' -f1,1)
	NIDU=$(echo $FLANI | cut -d ' ' -f2,2)
	#make variables for the locations where the repressed genes are in the highlight files
	FLLOC=$(grep -w "#$FLAVUS" flav_highlights.txt | cut -f1-3)
	NILOC=$(grep -w "#$NIDU" nidu_highlights.txt | cut -f1-3)
	#make a line in the link file for flav_nidu
	echo $FLLOC $NILOC "color=(99,163,204)" "#" $FLAVUS $NIDU "flav_nidu" >> flav_nidu_links.txt
done < ../flav_nidu.txt
echo flav_nidu_links.txt done

#make flav_fumi links
while read FLAFU; do
	#make variables for all the "fumi" IDs
	FLAVUS=$(echo $FLAFU | cut -d ' ' -f1,1)
	FUMI=$(echo $FLAFU | cut -d ' ' -f3,3)
	#make variables for the locations where the flav_fumi genes are in the highlight files
	FLLOC=$(grep -w "#$FLAVUS" flav_highlights.txt | cut -f1-3)
	FULOC=$(grep -w "#$FUMI" fumi_highlights.txt | cut -f1-3)
	#make a line in the link file for flav_fumi
	echo $FLLOC $FULOC "color=(99,163,204)" "#" $FLAVUS $FUMI "flav_fumi" >> flav_fumi_links.txt
done < ../flav_fumi.txt
echo flav_fumi_links.txt done

#make "nidulans_fumigatus" links
while read NUFU; do
	#make variables for all the "nidulans_fumigatus" IDs
	NIDU=$(echo $NUFU | cut -d ' ' -f2,2)
	FUMI=$(echo $NUFU | cut -d ' ' -f3,3)
	#make variables for the locations where the nidu_fumi genes are in the highlight files
	NILOC=$(grep -w "#$NIDU" nidu_highlights.txt | cut -f1-3)
	FULOC=$(grep -w "#$FUMI" fumi_highlights.txt | cut -f1-3)
	#make a line in the link file for nidu_fumi
	echo $NILOC $FULOC "color=(166,86,40)" "#" $NIDU $FUMI "nidu_fumi" >> nidu_fumi_links.txt
done < ../nidu_fumi.txt
echo nidu_fumi_links.txt done

#make "flavus divergent" links
while read FLDI; do
	FLAVUS=$(echo $FLDI | cut -d ' ' -f5,5 | cut -d '#' -f2,2)
	NIDUCHECK=$(grep -w "$FLAVUS" ../1_1_1_sig.txt | cut -d ' ' -f5,5 | cut -d '.' -f1,1)
	if [[ "$NIDUCHECK" -ne 0 ]]; then
		NIDUNAME=$(grep -w "$FLAVUS" ../1_1_1_sig.txt | cut -d ' ' -f2,2)
		NIDUHASH=$(echo \#${NIDUNAME})
		NIDULOC=$(grep -w "$NIDUHASH" nidu_highlights.txt | cut -f1-3)
		FLAVLOC=$(echo $FLDI | cut -d ' ' -f1-3)
		echo $FLAVLOC $NIDULOC "color=(254,159,56)" "#" $FLAVUS $NIDUNAME "flav_nidu divergent" >> flav_divergent_links.txt
	fi
	FUMICHECK=$(grep -w "$FLAVUS" ../1_1_1_sig.txt | cut -d ' ' -f6,6 | cut -d '.' -f1,1)
	if [[ "$FUMICHECK" -ne 0 ]]; then
		FUMINAME=$(grep -w "$FLAVUS" ../1_1_1_sig.txt | cut -d ' ' -f3,3)
		FUMIHASH=$(echo \#${FUMINAME})
		FUMILOC=$(grep -w "$FUMIHASH" fumi_highlights.txt | cut -f1-3)
		FLAVLOC=$(echo $FLDI | cut -d ' ' -f1-3)
		echo $FLAVLOC $FUMILOC "color=(254,159,56)" "#" $FLAVUS $FUMINAME "flav_fumi divergent" >> flav_divergent_links.txt
	fi
done <../flav_divergent.txt
echo flav_divergent_links.txt done

#make "fumigatus divergent" links
while read FUDI; do
	FUMI=$(echo $FUDI | cut -d ' ' -f5,5 | cut -d '#' -f2,2)
	if grep -q -w "$FUMI" flav_divergent_links.txt; then
		:
	else
		FLAVCHECK=$(grep -w "$FUMI" ../1_1_1_sig.txt | cut -d ' ' -f4,4 | cut -d '.' -f1,1)
		if [[ "$FLAVCHECK" -ne 0 ]]; then
			FLAVUS=$(grep -w "$FUMI" ../1_1_1_sig.txt | cut -d ' ' -f1,1)
			FLAVHASH=$(echo \#${FLAVUS})
			FLAVLOC=$(grep -w "$FLAVHASH" flav_highlights.txt | cut -f1-3)
			FUMILOC=$(echo "$FUDI" | cut -f1-3)
			echo $FUMILOC $FLAVLOC "color=(254,159,56)" "#" $FUMI $FLAVUS "fumi_flavus divergent" >> fumi_divergent_links.txt
		fi
		NIDUCHECK=$(grep -w "$FUMI" ../1_1_1_sig.txt | cut -d ' ' -f5,5 | cut -d '.' -f1,1)
		if [[ "$NIDUCHECK" -ne 0 ]]; then
			NIDU=$(grep -w "$FUMI" ../1_1_1_sig.txt | cut -d ' ' -f2,2)
			NIDUHASH=$(echo \#${NIDU})
			NIDULOC=$(grep -w "$NIDUHASH" nidu_highlights.txt | cut -f1-3)
			FUMILOC=$(echo "$FUDI" | cut -f1-3)
			echo $FUMILOC $NIDULOC "color=(254,159,56)" "#" $FUMI $NIDU "fumi_nidu divergent" >> fumi_divergent_links.txt
		fi
	fi
done <../fumi_divergent.txt
echo fumi_divergent_links.txt done

#make "nidulans divergent" links
while read NIDI; do
	NIDU=$(echo $NIDI | cut -d ' ' -f5,5 | cut -d '#' -f2,2)
	if grep -q -w "$NIDU" flav_divergent_links.txt; then
		:
	elif grep -q -w "$NIDU" fumi_divergent_links.txt; then
		:
	else
		FLAVCHECK=$(grep -w "$NIDU" ../1_1_1_sig.txt | cut -d ' ' -f4,4 | cut -d '.' -f1,1)
		if [[ "$FLAVCHECK" -ne 0 ]]; then
			FLAVUS=$(grep -w "$NIDU" ../1_1_1_sig.txt | cut -d ' ' -f1,1)
			FLAVHASH=$(echo \#${FLAVUS})
			FLAVLOC=$(grep -w "$FLAVHASH" flav_highlights.txt | cut -f1-3)
			NIDULOC=$(echo "$NIDI" | cut -f1-3)
			echo $NIDULOC $FLAVLOC "color=(254,159,56)" "#" $NIDU $FLAVUS "nidu_flavus divergent" >> nidu_divergent_links.txt
		fi
		FUMICHECK=$(grep -w "$NIDU" ../1_1_1_sig.txt | cut -d ' ' -f6,6 | cut -d '.' -f1,1)
		if [[ "$FUMICHECK" -ne 0 ]]; then
			FUMI=$(grep -w "$NIDU" ../1_1_1_sig.txt | cut -d ' ' -f3,3)
			FUMIHASH=$(echo \#${FUMI})
			FUMILOC=$(grep -w "$FUMIHASH" fumi_highlights.txt | cut -f1-3)
			NIDULOC=$(echo "$NIDI" | cut -f1-3)
			echo $NIDULOC $FUMILOC "color=(254,159,56)" "#" $NIDU $FUMI "nidu_fumi divergent" >> nidu_divergent_links.txt
		fi
	fi
done <../nidu_divergent.txt
echo nidu_divergent_links.txt done
