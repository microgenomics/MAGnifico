#!/bin/bash

##-------rhizosphere 2017
##---define samples
#samples="G1-1 G1-2 G1-3 G2-1 G2-2 G2-3"
##---define directory
#cleaneddir="/datos/fgutzwiller/filtered_data/rhizosphere_2017/no_cut"

#-------sediments cortes sea

#---define samples
samples="PRO1748_Plate1_C1 PRO1748_Plate1_D1 PRO1748_Plate1_B2 PRO1748_Plate1_H2 PRO1748_Plate1_B3 PRO1748_Plate1_D3 PRO1748_Plate1_F3 PRO1748_Plate1_H3 PRO1748_Plate1_D4 PRO1748_Plate1_E4 PRO1748_Plate1_A5 PRO1748_Plate1_F5 PRO1748_Plate2_A1 PRO1748_Plate2_B1 PRO1748_Plate2_C1 PRO1748_Plate2_D1 PRO1748_Plate2_E1 PRO1748_Plate2_F1 PRO1748_Plate2_G1 PRO1748_Plate2_H1 PRO1748_Plate2_A2 PRO1748_Plate2_B2 PRO1748_Plate2_C2 PRO1748_Plate2_D2 PRO1748_Plate2_E2 PRO1748_Plate2_F2 PRO1748_Plate2_G2 PRO1748_Plate2_H2 PRO1748_Plate2_A3 PRO1748_Plate2_C3 PRO1748_Plate2_D3 PRO1748_Plate2_E3 PRO1748_Plate2_F3 PRO1748_Plate2_G3 PRO1748_Plate2_H3 PRO1748_Plate2_A4 PRO1748_Plate2_B4 PRO1748_Plate2_C4 PRO1748_Plate2_D4 PRO1748_Plate2_E4 PRO1748_Plate2_F4 PRO1748_Plate2_G4 PRO1748_Plate2_H4 PRO1748_Plate2_A5 PRO1748_Plate2_B5 PRO1748_Plate2_C5 PRO1748_Plate2_D5 PRO1748_Plate2_E5 PRO1748_Plate2_F5 PRO1748_Plate2_G5 PRO1748_Plate2_H5 PRO1748_Plate2_A6 PRO1748_Plate2_B6 PRO1748_Plate2_C6"

#unsucessful="PRO1748_Plate1_A1 PRO1748_Plate1_B1 PRO1748_Plate1_E1 PRO1748_Plate1_F1 PRO1748_Plate1_G1 PRO1748_Plate1_H1 PRO1748_Plate1_A2 PRO1748_Plate1_C2 PRO1748_Plate1_D2 PRO1748_Plate1_E2 PRO1748_Plate1_F2 PRO1748_Plate1_G2 PRO1748_Plate1_A3 PRO1748_Plate1_C3 PRO1748_Plate1_E3 PRO1748_Plate1_G3 PRO1748_Plate1_A4 PRO1748_Plate1_B4 PRO1748_Plate1_C4 PRO1748_Plate1_F4 PRO1748_Plate1_G4 PRO1748_Plate1_H4 PRO1748_Plate1_B5 PRO1748_Plate1_C5 PRO1748_Plate1_D5 PRO1748_Plate1_E5 PRO1748_Plate1_G5 PRO1748_Plate1_H5 PRO1748_Plate2_B3"

#---define directory
cleaneddir="/datos/fgutzwiller/cleaned_data/sediments_marDeCortes"

#prepare list for all samples concatenation
for i in $samples
do

##-------rhizosphere 2017
#concat_1_list="$concat_1_list$cleaneddir/${i}_filtered_1.fastq "
#concat_2_list="$concat_2_list$cleaneddir/${i}_filtered_2.fastq "
#concat_singleton_list="$concat_singleton_list$cleaneddir/${i}_singleton_filtered.fastq "

#-------sediments cortes sea

concat_1_list="$concat_1_list$cleaneddir/${i}*_1.fastq "
concat_2_list="$concat_2_list$cleaneddir/${i}*_2.fastq "
concat_singleton_list="$concat_singleton_list$cleaneddir/${i}*_1_singletons.fastq $cleaneddir/${i}*_2_singletons.fastq "

done


#concatenate samples
cat $concat_1_list > $cleaneddir/concat_samples_1.fastq
cat $concat_2_list > $cleaneddir/concat_samples_2.fastq
cat $concat_singleton_list > $cleaneddir/concat_samples_singletons.fastq

for i in $samples
do

#fuse fastq files for each sample (needed for maxbin)
##-------rhizosphere 2017
#cat $cleaneddir/${i}_filtered_1.fastq $cleaneddir/${i}_filtered_2.fastq $cleaneddir/${i}_singleton_filtered.fastq  > $cleaneddir/${i}_all.fastq

#-------sediments cortes sea
cat $cleaneddir/${i}*_1.fastq $cleaneddir/${i}*_2.fastq $cleaneddir/${i}*_1_singletons.fastq $cleaneddir/${i}*_2_singletons.fastq  > $cleaneddir/${i}_all.fastq

done


