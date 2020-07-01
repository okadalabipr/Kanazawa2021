#!/bin/sh

#This script conducts mapping of RNA-seq data.

R1="XXX" #Path to your fastq of read1
R2="XXX" #Path to your fastq of read2

mkdir fastQC

index="XXX" #Path to your mm10 index of HISAT2

file_name="XXX" #Specify the file name you like here.

#Adapter trimming with trimgalore. You can specify the number of threads with "--cores" option.
trim_galore --paired ${R1} ${R2} --basename ${file_name}

#Mapping with hisat2. You can specify the number of threads with "-p" and "-@" options in hisat2 and samtools sort respectively.
hisat2 -x ${index} -1 ${file_name}_val_1.fq -2 ${file_name}_val_2.fq | samtools sort -O BAM -o ${file_name}.bam

#Make index of BAM. You can specify the number of threads with "-@" option.
samtools index -@ 16 ${file_name}.bam