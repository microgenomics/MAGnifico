#!/bin/bash

#---define samples
samples="G1-1 G1-2 G1-3 G2-1 G2-2 G2-3"
#---define directories
cleaneddir="/datos/fgutzwiller/cleaned_data/rhizosphere_2017/no_cut"
filtereddir="/datos/fgutzwiller/filtered_data/rhizosphere_2017/no_cut"
datadir="/datos/fgutzwiller/database"



for i in $samples
do
#map reads to plastid end to end mode and keep unmapped reads
bowtie2 -p 20 -x $datadir/plastid/plastid -1 $cleaneddir/${i}_1.fastq -2 $cleaneddir/${i}_2.fastq -U $cleaneddir/${i}_1_singletons.fastq,$cleaneddir/${i}_2_singletons.fastq --end-to-end --un-conc $filtereddir/${i}_tmp1 --un $filtereddir/${i}_singleton_tmp1 
#map reads to mitochondria end to end mode and keep unmapped reads
bowtie2 -p 20 -x $datadir/mitochondria/mitochondrion -1 $filtereddir/${i}_tmp1.1 -2 $filtereddir/${i}_tmp1.2 -U $filtereddir/${i}_singleton_tmp1 --end-to-end --un-conc $filtereddir/${i}_tmp2 --un $filtereddir/${i}_singleton_tmp2 
#map reads to plant genomes end to end mode and keep unmapped reads
bowtie2 -p 20 -x $datadir/plants/plants_all -1 $filtereddir/${i}_tmp2.1 -2 $filtereddir/${i}_tmp2.2 -U $filtereddir/${i}_singleton_tmp2 --end-to-end --un-conc $filtereddir/${i}_filtered --un $filtereddir/${i}_singleton_filtered 

#rename output files
mv $filtereddir/${i}_filtered.1 $filtereddir/${i}_filtered_1.fastq
mv $filtereddir/${i}_filtered.2 $filtereddir/${i}_filtered_2.fastq
mv $filtereddir/${i}_singleton_filtered $filtereddir/${i}_singleton_filtered.fastq

done
