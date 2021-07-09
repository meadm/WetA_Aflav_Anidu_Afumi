#!/bin/bash
#start a counter at 1
COUNTER=1
#make a variable that is the total number of lines in the single line FASTA file of the upstream regions
LINES=$(wc -l < $1 )
#start an until loop that will keep going as long as the counter is less than the total number of lines in the file
until [ $COUNTER -gt $LINES ]; do
#make a variable that is the first character in the line
  CARROTCHECK=$(sed "${COUNTER}q;d" $1 | cut -c1)
#if the first character is a ">", then...
  if [ $CARROTCHECK == ">" ]; then
  #make a variable that is the carrot and the gene id
  #sed "${COUNTER}q;d" $1 = read the "COUNTER" line of the file that you give as the first input for the script
    GENEID=$(sed "${COUNTER}q;d" $1 | cut -d ' ' -f1,1)
  #make a variable that is just the gene id
    NOCARROT=$(sed "${COUNTER}q;d" $1 | cut -d ' ' -f1,1 | cut -d '>' -f2,2)
  #make a variable that is the strand of the occurrence
    STRAND=$(grep "$NOCARROT" $2 | cut -f2,2)
  #if the occurrence is in the positive direction...
    if [ $STRAND == "+" ]; then
    #make a variable that is the line number of the gene id plus one (aka the line that has the sequence for the gene id you are workign on)
      let COUNTERPLUS=COUNTER+1
    #make a variable that is the occurrence you are about to search for
      SITE=$(grep "$NOCARROT" $2 | cut -f3,3)
    #make a variable that is the occurrence plus the 10 bases surrounding it
    #first print the line that has the sequence and pipe it to the grep command
    #the grep command pulls the sequence 10bp upstream, the occurrence, and 10bp downstream
      RESULT=$(sed "${COUNTERPLUS}q;d" $1 | grep -Eo ".{0,10}${SITE}.{0,10}")
    #if the occurrence is in the reverse direction...
    elif [[ $STRAND == "-" ]]; then
      let COUNTERPLUS=COUNTER+1
      #... rev | tr ATCG TAGC finds the reverse complement of the occurrence
      SITE=$(grep "$NOCARROT" $2 | cut -f3,3 | rev | tr ATCG TAGC)
      #make sure to find the reverse complement of the result so that it matches the others
      RESULT=$(sed "${COUNTERPLUS}q;d" $1 | grep -Eo ".{0,10}${SITE}.{0,10}" | rev | tr ATCG TAGC)
    fi
    #print results to a file
    echo $GENEID >> wetA_occurrences.fasta
    echo $RESULT >> wetA_occurrences.fasta
  fi
  let COUNTER=COUNTER+1
done
