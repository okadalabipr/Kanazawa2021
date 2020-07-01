#!/bin/bash

#This script identifies SEs in WT and Crk/Crkl KO cells using H3K27Ac ChIP-seq data and assigns SEs to genes.

WT_Tag_Directory="XXX" #Specify path to your HOMER Tag Directory of WT H3K27Ac ChIP-seq here.
KO_Tag_Directory="XXX" #Specify path to your HOMER Tag Directory of Crk/Crkl KO H3K27Ac ChIP-seq here.

WT_input_Tag_Directory="XXX" #Specify path to your HOMER Tag Directory of input of WT here.
KO_input_Tag_Directory="XXX" #Specify path to your HOMER Tag Directory of input of Crk/Crkl KO here.

#Get gencode annotation file (Release M25 (GRCm38.p6), Comprehensive gene annotation CHR, https://www.gencodegenes.org/mouse/release_M25.html)
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M25/gencode.vM25.annotation.gtf.gz
gunzip gencode.vM25.annotation.gtf.gz
GTF="./gencode.vM25.annotation.gtf" #Or just specify your path to your annotation file here.

#Identify SEs
findPeaks ${WT_Tag_Directory} -style super -typical ${WT_Tag_Directory}/typicalEnhancers.txt -L 0 -fdr 0.00005 -o auto -i ${WT_input_Tag_Directory}
findPeaks ${KO_Tag_Directory} -style super -typical ${KO_Tag_Directory}/typicalEnhancers.txt -L 0 -fdr 0.00005 -o auto -i ${KO_input_Tag_Directory}

#Assign SEs to genes. You can specify the number of threads with "-cpu" option.
annotatePeaks.pl ${WT_Tag_Directory}/superEnhancers.txt mm10 -gtf ${GTF} > ${WT_Tag_Directory}/WT_SE_annotated.txt 
annotatePeaks.pl ${KO_Tag_Directory}/superEnhancers.txt mm10 -gtf ${GTF} > ${KO_Tag_Directory}/KO_SE_annotated.txt