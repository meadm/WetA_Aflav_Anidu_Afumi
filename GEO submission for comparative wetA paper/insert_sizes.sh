#!/bin/bash
COUNTER=1
until [ $COUNTER -eq "5" ]; do
    cd dwetA${COUNTER}
    pwd
    java -jar /opt/easybuild/software/Core/picard/2.9.2-Java-1.8.0_92/picard.jar CollectInsertSizeMetrics I=accepted_hits.bam O=Picard_insert_sizes.txt H=Picard_insert_sizes.pdf M=0.5
    cd ..
    let COUNTER=COUNTER+1
done
