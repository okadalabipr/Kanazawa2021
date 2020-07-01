#!/bin/sh

#This script conducts mapping of ChIP-seq data and makes HOMER tag directories.

R1="XXX" #Path to your fastq of read1
R2="XXX" #Path to your fastq of read2

mkdir Tagdirectory

index="XXX" #Path to your mm10 index of Bowtie2
adapter="XXX" #Path to your 'trimmomatic/adapters/TruSeq3-PE.fa'

file_name="XXX" #Specify the file name you like here.

#Adapter trimming with trimmomatic
trimmomatic PE -threads 16 -phred33 $R1 $R2 ./trimmed_R1.fastq ./unpaired_R1.fastq ./trimmed_R2.fastq ./unpaired_R2.fastq \
ILLUMINACLIP:${adapter}:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

#Mapping with bowtie2
bowtie2 -x ${index} -1 ./trimmed_R1.fastq -2 ./trimmed_R2.fastq -S ./mapped.sam #You can specify the number of threads with "-p" option.

#Convert sam to bam with samtools
samtools view -bS ./mapped.sam -o ./mapped.bam #You can specify the number of threads with "-@" option.

#Sort bam with samtools
samtools sort ./mapped.bam -o ./mapped_sorted.bam #You can specify the number of threads with "-@" option.

#Remove duplicates with picard
picard MarkDuplicates I=./mapped_sorted.bam O=./${file_name}_rm_dups.bam M=./${file_name}_report.txt REMOVE_DUPLICATES=true

#Make index
samtools index ./${file_name}_rm_dups.bam #You can specify the number of threads with "-@" option.

#Remove intermediate files
rm -rf ./trimmed_R1.fastq ./trimmed_R2.fastq ./unpaired_R1.fastq ./unpaired_R2.fastq ./mapped.sam ./mapped.bam ./mapped_sorted.bam

#Make HOMER Tagdirectory
makeTagDirectory ./Tagdirectory/${file_name} -single ${file_name}_rm_dups.bam