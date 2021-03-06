#!/bin/bash

dataDir=`pwd`/data
echo $dataDir

# index the genome
docker run -v $dataDir:/data biocontainers/bwa bwa index chr1.fa

# mapping with bwa algorithm (generate SAM file with mappings)
docker run -v $dataDir:/data biocontainers/bwa  \
    bwa mem -t 4 chr1.fa coriell_chr1.fq > coriell_chr1.sam

mv coriell_chr1.sam $dataDir

# sort mappings and generate binary representation
docker run -v $dataDir:/data biocontainers/samtools \
    samtools sort -O BAM -o coriell_chr1.bam coriell_chr1.sam
