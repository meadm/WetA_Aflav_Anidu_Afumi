#!/bin/bash
#make conserved links
while read LINE; do
  #an "until" loop that tells me how many flavus genes there are in that line
  COUNTER=1
  until [ $COUNTER == 0 ]; do
    ID=$(echo $LINE | cut -d ' ' -f$COUNTER,$COUNTER)
    SPECIES=$(echo $ID | cut -c1-2)
    if [[ $SPECIES == "AF" ]]; then
      let COUNTER=COUNTER+1
    elif [[ $SPECIES == "AN" ]]; then
      let FLAVTOT=COUNTER-1
      COUNTER=0
    fi
  done
  #an "until" loop that tells me how many nidulans genes there are in that line
	COUNTER=1
	until [ $COUNTER == 0 ]; do
		let NIDUID=FLAVTOT+COUNTER
		ID=$(echo $LINE | cut -d ' ' -f$NIDUID,$NIDUID)
		SPECIES=$(echo $ID | cut -c1-2)
    if [[ $SPECIES == "AN" ]]; then
			let COUNTER=COUNTER+1
		elif [[ $SPECIES == "Af" ]]; then
			let NIDUTOT=COUNTER-1
			COUNTER=0
		fi
	done
  #an "until" loop that tells me how many fumigatus genes there are in that line
	COUNTER=1
	until [ $COUNTER == 0 ]; do
		let FUMIID=FLAVTOT+NIDUTOT+COUNTER
		ID=$(echo $LINE | cut -d ' ' -f$FUMIID,$FUMIID)
		SPECIES=$(echo $ID | cut -c1-2)
		if [[ $SPECIES == "Af" ]]; then
			let COUNTER=COUNTER+1
		else
			let FUMITOT=COUNTER-1
			COUNTER=0
		fi
	done
  #make flavus to nidulans and fumigatus links
  COUNTER=1
  until [[ $COUNTER == 0 ]]; do
    if [[ $COUNTER -le $FLAVTOT ]]; then
      FLAVID=$(echo $LINE | cut -d ' ' -f$COUNTER,$COUNTER)
      FLAVLOC=$(grep -w "#${FLAVID}" make\ plot/flav_highlights.txt | cut -d ' ' -f1-3)
      let COUNTER=COUNTER+1
      #print all the nidu links for this flav id
      NIDUCOUNTER=1
      until [[ $NIDUCOUNTER == 0 ]]; do
        if [[ $NIDUCOUNTER -le $NIDUTOT ]]; then
          let NIDUNUM=FLAVTOT+NIDUCOUNTER
          NIDUID=$(echo $LINE | cut -d ' ' -f$NIDUNUM,$NIDUNUM)
          NIDULOC=$(grep -w "#${NIDUID}" make\ plot/nidu_highlights.txt | cut -d ' ' -f1-3)
          echo $FLAVLOC $NIDULOC "color=(239,90,91)" "#" $FLAVID $NIDUID >> make\ plot/conserved_links.txt
          let NIDUCOUNTER=NIDUCOUNTER+1
        else
            NIDUCOUNTER=0
        fi
      done
      #print all the fumi links for this flav id
      FUMICOUNTER=1
      until [[ $FUMICOUNTER == 0 ]]; do
        if [[ $FUMICOUNTER -le $FUMITOT ]]; then
          let FUMINUM=FLAVTOT+NIDUTOT+FUMICOUNTER
          FUMIID=$(echo $LINE | cut -d ' ' -f$FUMINUM,$FUMINUM)
          FUMILOC=$(grep -w "#${FUMIID}" make\ plot/fumi_highlights.txt | cut -d ' ' -f1-3)
          echo $FLAVLOC $FUMILOC "color=(239,90,91)" "#" $FLAVID $FUMIID >> make\ plot/conserved_links.txt
          let FUMICOUNTER=FUMICOUNTER+1
        else
            FUMICOUNTER=0
        fi
      done
    else
      COUNTER=0
    fi
  done
  #make nidulans and fumigatus links
  NIDUCOUNTER=1
  until [[ $NIDUCOUNTER == 0 ]]; do
    if [[ $NIDUCOUNTER -le $NIDUTOT ]]; then
      let NIDUNUM=FLAVTOT+NIDUCOUNTER
      NIDUID=$(echo $LINE | cut -d ' ' -f$NIDUNUM,$NIDUNUM)
      NIDULOC=$(grep -w "#${NIDUID}" make\ plot/nidu_highlights.txt | cut -d ' ' -f1-3)
      let NIDUCOUNTER=NIDUCOUNTER+1
      FUMICOUNTER=1
      until [[ $FUMICOUNTER == 0 ]]; do
        if [[ $FUMICOUNTER -le $FUMITOT ]]; then
          let FUMINUM=FLAVTOT+NIDUTOT+FUMICOUNTER
          FUMIID=$(echo $LINE | cut -d ' ' -f$FUMINUM,$FUMINUM)
          FUMILOC=$(grep -w "#${FUMIID}" make\ plot/fumi_highlights.txt | cut -d ' ' -f1-3)
          echo $NIDULOC $FUMILOC "color=(239,90,91)" "#" $NIDUID $FUMIID >> make\ plot/conserved_links.txt
          let FUMICOUNTER=FUMICOUNTER+1
        else
            FUMICOUNTER=0
        fi
      done
    else
      NIDUCOUNTER=0
    fi
  done
done < conserved.txt
