#!/bin/sh

R1="XXX" #Path to your fastq of read1
R2="XXX" #Path to your fastq of read2

mkdir fastQC

index="XXX" #Path to your mm10 index of HISAT2

file_name="XXX" #Specify the file name you like here.

trim_galore --paired ${R1} ${R2} --basename ${file_name}

hisat2 -x ${index} -1 ${file_name}_val_1.fq -2 ${file_name}_val_2.fq | samtools sort -O BAM -o ${file_name}.bam

samtools index -@ 16 ${file_name}.bam