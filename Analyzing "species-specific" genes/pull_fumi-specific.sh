#!/bin/bash
while read LINE; do
#an "until" loop that tells me how many genes there are in that line
	COUNTER=1
	until [ $COUNTER == 0 ]; do
		ID=$(echo $LINE | cut -d ' ' -f$COUNTER,$COUNTER)
		if [[ $ID ]]; then
			CUTID=$(echo $ID | cut -c1)
			if [[ $CUTID == "A" ]]; then 
				let COUNTER=COUNTER+1
			else
				let GENES=COUNTER-1
				COUNTER=0
			fi
		else
			COUNTER=0
		fi
	done
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
		elif [[ $SPECIES == "Af" ]]; then
			let FLAVTOT=COUNTER-1
			COUNTER=0
		else
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
		else
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
#an "until" loop that makes sure the flavus genes are not expressed
    FLAVCOUNTER=0
	COUNTER=1
	until [ $COUNTER == 0 ]; do
		let FLAVNUM=GENES+COUNTER
		IDEXP=$(echo $LINE | cut -d ' ' -f$FLAVNUM,$FLAVNUM | cut -d '.' -f1,1)
		if [[ $IDEXP -eq 0 ]] && [[ $COUNTER -le $FLAVTOT ]]; then
			let COUNTER=COUNTER+1
            let FLAVCOUNTER=FLAVCOUNTER+1
		else
			COUNTER=0
		fi	
	done
#an "until" loop that makes sure the nidulans genes are not expressed
	NIDUCOUNTER=0
	COUNTER=1
	until [ $COUNTER == 0 ]; do
		let NIDUNUM=GENES+FLAVTOT+COUNTER
		IDEXP=$(echo $LINE | cut -d ' ' -f$NIDUNUM,$NIDUNUM | cut -d '.' -f1,1)
		if [[ $IDEXP -eq 0 ]] && [ $COUNTER -le $NIDUTOT ]; then
			let COUNTER=COUNTER+1
			let NIDUCOUNTER=NIDUCOUNTER+1
		else
			COUNTER=0
		fi
	done
#an "until" loop that makes sure the fumigatus genes are expressed
	FUMICOUNTER=0
	COUNTER=1
	until [ $COUNTER == 0 ]; do
		let FUMINUM=GENES+FLAVTOT+NIDUTOT+COUNTER
		IDEXP=$(echo $LINE | cut -d ' ' -f$FUMINUM,$FUMINUM | cut -d '.' -f1,1)
		if [[ "$IDEXP" -ne "0" ]] && [ "$COUNTER" -le "$FUMITOT" ]; then
			let COUNTER=COUNTER+1
			let FUMICOUNTER=FUMICOUNTER+1
		else
			COUNTER=0
		fi
	done
#making sure that all flavus genes are regulated, all nidulans genes are NOT regulated, and all fumigatus genes are NOT regulated 
	if [[ "$FLAVCOUNTER" -eq "$FLAVTOT" ]] && [[ "$NIDUCOUNTER" -eq "$NIDUTOT" ]] && [[ "$FUMICOUNTER" -eq "$FUMITOT" ]]; then
		echo $LINE >> NNN_fumigatus-specific_expressed.txt
	fi
done< /Users/MattMead/Documents/Work/Collaborations/Jae-Hyuk\ Yu/flavus_nidulans_fumigatus_wetA/orthologs/FungiDB/NNN/With\ published\ Aflav/NNN_expression.txt
