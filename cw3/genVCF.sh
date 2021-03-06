#!/bin/bash

dataDir=`pwd`/data

docker run -v $dataDir:/data biocontainers/samtools \
    samtools mpileup -Ou -f chr1.fa coriell_chr1.bam > coriell_chr1.bcf

mv coriell_chr1.bcf $dataDir

docker run -v $dataDir:/data biocontainers/bcftools \
    bcftools call -mv coriell_chr1.bcf > coriell_chr1.vcf

mv coriell_chr1.vcf $dataDir

docker run -v $dataDir:/data biocontainers/bcftools \
    bcftools filter -i "INFO/DP> 10" coriell_chr1.vcf > coriell_chr1_filtered.vcf

mv coriell_chr1_filtered.vcf $dataDir
