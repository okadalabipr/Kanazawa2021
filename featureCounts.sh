#!/bin/sh

#This script runs featureCounts.

#Get gencode annotation file (Release M25 (GRCm38.p6), Comprehensive gene annotation CHR, https://www.gencodegenes.org/mouse/release_M25.html)
wget ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M25/gencode.vM25.annotation.gtf.gz
gunzip gencode.vM25.annotation.gtf.gz
GTF="./gencode.vM25.annotation.gtf" #Or just specify your path to your annotation file here.

BAMs="XXX.bam YYY.bam ZZZ.bam" #Specify the list of bams you want to count reads here. (Space delimited.) 

#Run featureCounts. You can specify the number of the threads with "-T" option.
featureCounts -p -t exon -g gene_id -a ${GTF} -o RNA-seq_counts.txt ${BAMs}