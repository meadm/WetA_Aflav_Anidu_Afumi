#!/bin/bash
while read LINE; do
  ANNOTATION=$(grep -w "$LINE" ../NNN_parsed_published_Aflav/* | cut -d '/' -f3 | cut -d '.' -f1,1)
  if [[ $ANNOTATION ]]; then
    echo "#"$LINE $ANNOTATION >> nidulans_NNN_annotated.txt
  else
    echo "#"$LINE not_expressed >> nidulans_NNN_annotated.txt
  fi
done < nidulans_NNN.txt
