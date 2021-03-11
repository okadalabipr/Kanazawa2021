#!/bin/bash

WT_Tag_Directory="XXX" #Specify path to your HOMER Tag Directory of WT H3K27Ac ChIP-seq here.
KO_Tag_Directory="XXX" #Specify path to your HOMER Tag Directory of Crk/Crkl KO H3K27Ac ChIP-seq here.

WT_input_Tag_Directory="XXX" #Specify path to your HOMER Tag Directory of input of WT here.
KO_input_Tag_Directory="XXX" #Specify path to your HOMER Tag Directory of input of Crk/Crkl KO here.

GTF="XXX" #Path to your annotation file

findPeaks ${WT_Tag_Directory} -style super -typical ${WT_Tag_Directory}/typicalEnhancers.txt -L 0 -fdr 0.00005 -o auto -i ${WT_input_Tag_Directory}
findPeaks ${KO_Tag_Directory} -style super -typical ${KO_Tag_Directory}/typicalEnhancers.txt -L 0 -fdr 0.00005 -o auto -i ${KO_input_Tag_Directory}

annotatePeaks.pl ${WT_Tag_Directory}/superEnhancers.txt mm10 -gtf ${GTF} > ${WT_Tag_Directory}/WT_SE_annotated.txt 
annotatePeaks.pl ${KO_Tag_Directory}/superEnhancers.txt mm10 -gtf ${GTF} > ${KO_Tag_Directory}/KO_SE_annotated.txt