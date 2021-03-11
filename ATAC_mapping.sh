#!/bin/sh

parallel-fastq-dump --sra-id SRR5470874 --outdir ./ --split-files --gzip

gunzip ./SRR5470874_*.gz

index="XXX" #Path to your mm10 index of Bowtie2
adapter="XXX" #Path to your 'trimmomatic/adapters/TruSeq3-PE.fa'

file_name="XXX" #Specify the file name you like here.

trimmomatic PE -threads 16 -phred33 SRR5470874_1.fastq SRR5470874_2.fastq \
./trimmed_R1.fastq ./unpaired_R1.fastq \
./trimmed_R2.fastq ./unpaired_R2.fastq \
ILLUMINACLIP:${adapter}:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

bowtie2 -x ${index} -1 ./trimmed_R1.fastq -2 ./trimmed_R2.fastq -S mapped.sam 
 
samtools view -bS ./mapped.sam -o ./mapped.bam 

samtools sort ./mapped.bam -o ./mapped_sorted.bam 

picard MarkDuplicates I=./mapped_sorted.bam O=./${file_name}_rm_dups.bam M=./${file_name}_report.txt REMOVE_DUPLICATES=true

samtools index ./${file_name}_rm_dups.bam

rm -rf ./trimmed_R1.fastq ./trimmed_R2.fastq ./unpaired_R1.fastq ./unpaired_R2.fastq ./mapped.sam ./mapped.bam ./mapped_sorted.bam

macs2 callpeak -f BAM -t ${file_name}_rm_dups.bam -g mm --outdir MEF_ATAC_macs2 -n MEF_ATAC

cat MEF_ATAC_macs2/MEF_ATAC_peaks.xls | grep -v '^#' | sed '/^$/d' | awk -v 'OFS=\t' '{print $1, $2, $3}' | sed -e '1d' > MEF_ATAC_macs2/MEF_ATAC_peaks.bed