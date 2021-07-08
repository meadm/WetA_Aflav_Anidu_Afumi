#1/bin/bash
for num in {1..3}; do
	grep 'Afu' dwetA$num/dwetA${num}.htseq | sed '/.*(.*/d' | sed 's/-T//' > dwetA$num/dwetA${num}_2.htseq
	grep 'Afu' WT$num/WT${num}.htseq | sed '/.*(.*/d' | sed 's/-T//' > WT$num/WT${num}_2.htseq
	
done
