#!/bin/sh

R1="XXX" #Path to your fastq of read1
R2="XXX" #Path to your fastq of read2

mkdir Tagdirectory

index="XXX" #Path to your mm10 index of Bowtie2
adapter="XXX" #Path to your 'trimmomatic/adapters/TruSeq3-PE.fa'

file_name="XXX" #Specify the file name you like here.

trimmomatic PE -threads 16 -phred33 $R1 $R2 ./trimmed_R1.fastq ./unpaired_R1.fastq ./trimmed_R2.fastq ./unpaired_R2.fastq \
ILLUMINACLIP:${adapter}:2:30:10 LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36

bowtie2 -x ${index} -1 ./trimmed_R1.fastq -2 ./trimmed_R2.fastq -S ./mapped.sam 

samtools view -bS ./mapped.sam -o ./mapped.bam 

samtools sort ./mapped.bam -o ./mapped_sorted.bam 

picard MarkDuplicates I=./mapped_sorted.bam O=./${file_name}_rm_dups.bam M=./${file_name}_report.txt REMOVE_DUPLICATES=true

samtools index ./${file_name}_rm_dups.bam 

rm -rf ./trimmed_R1.fastq ./trimmed_R2.fastq ./unpaired_R1.fastq ./unpaired_R2.fastq ./mapped.sam ./mapped.bam ./mapped_sorted.bam

makeTagDirectory ./Tagdirectory/${file_name} -single ${file_name}_rm_dups.bam