#!/bin/bash

##-----------for rhizosphere 2017
##--define sample list
#samples="G1-1 G1-2 G1-3 G2-1 G2-2 G2-3"
#
##--define directories
#rawdir="/datos/fgutzwiller/raw_data/rhizosphere_2017"
##cleaneddir="/datos/fgutzwiller/cleaned_data/rhizosphere_2017"
#cleaneddir="/datos/fgutzwiller/cleaned_data/rhizosphere_2017/no_cut"


#-----------for sediments cortes sea

#--define directories
rawdir="/datos/fgutzwiller/raw_data/sediments_marDeCortes"
cleaneddir="/datos/fgutzwiller/cleaned_data/sediments_marDeCortes"

mkdir $cleaneddir

#make sample list

list_sample=""

for i in `ls -d $rawdir/Sample_*`
do
 
 for j in `ls $i/*R1.fastq.gz`
 do
  sample=${j:77:44}
  list_sample="$list_sample$sample "
 done
done


# clean reads using sliding windows to get rid of low quality tail
for i in $list_sample
do

##-----------for rhizosphere 2017
##prinseq using paired end reads, min read lenght of 50, min quality over whole read of 20, and mean quality on 50bp sliding window of 20 from 3', sliding window step of 10, no N allowed, remove only exact duplicate (because metagenomics) present 2 or more time, sequence with low complexity score of 32 or less (repeated teramere), method dust , remove 5 left nt and 20 nt right
#prinseq-lite.pl -verbose -fastq $rawdir/${i}_1.fastq -fastq2 $rawdir/${i}_2.fastq -min_len 50 -min_qual_mean 20 -ns_max_p 0 -derep 1 -derep_min 2 -lc_method dust -lc_threshold 32 -trim_left 5 -trim_right 20 -trim_qual_right 20 -trim_qual_window 20 -trim_qual_step 5 -out_format 3 -out_good $cleaneddir/${i} -out_bad null >> $cleaneddir/prinseq_${i}.log

#-----------for sediments cortes sea
dir="Sample_${i:0:19}"
zcat $rawdir/$dir/${i}_R1.fastq.gz > $rawdir/$dir/${i}_R1.fastq
zcat $rawdir/$dir/${i}_R2.fastq.gz > $rawdir/$dir/${i}_R2.fastq


#prinseq using paired end reads, min read lenght of 50, min quality over whole read of 20, and mean quality on 50bp sliding window of 20 from 3', sliding window step of 10, no N allowed, remove only exact duplicate (because metagenomics) present 2 or more time, sequence with low complexity score of 32 or less (repeated teramere), method dust , remove 5 left nt and 20 nt right
prinseq-lite.pl -verbose -fastq $rawdir/$dir/${i}_R1.fastq -fastq2 $rawdir/$dir/${i}_R2.fastq -min_len 50 -min_qual_mean 20 -ns_max_p 0 -derep 1 -derep_min 2 -lc_method dust -lc_threshold 32 -trim_left 10 -trim_right 0 -trim_qual_right 20 -trim_qual_window 10 -trim_qual_step 5 -out_format 3 -out_good $cleaneddir/${i} -out_bad null

done


