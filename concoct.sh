#!/bin/bash

#rhizosphere 2017
##---define samples
#samples="G1-1 G1-2 G1-3 G2-1 G2-2 G2-3"
##---define directory
#filtereddir="/datos/fgutzwiller/filtered_data/rhizosphere_2017/no_cut"
#assemblydir="/datos/fgutzwiller/genome_extraction/assembly/rhizosphere_2017/concat_samples"
#bamdir="/datos/fgutzwiller/genome_extraction/mapped_to_contigs/rhizosphere_2017"
#bindir="/datos/fgutzwiller/genome_extraction/bins/rhizosphere_2017/concoct"

#sediments
#---define samples
samples="PRO1748_Plate1_C1 PRO1748_Plate1_D1 PRO1748_Plate1_B2 PRO1748_Plate1_H2 PRO1748_Plate1_B3 PRO1748_Plate1_D3 PRO1748_Plate1_F3 PRO1748_Plate1_H3 PRO1748_Plate1_D4 PRO1748_Plate1_E4 PRO1748_Plate1_A5 PRO1748_Plate1_F5 PRO1748_Plate2_A1 PRO1748_Plate2_B1 PRO1748_Plate2_C1 PRO1748_Plate2_D1 PRO1748_Plate2_E1 PRO1748_Plate2_F1 PRO1748_Plate2_G1 PRO1748_Plate2_H1 PRO1748_Plate2_A2 PRO1748_Plate2_B2 PRO1748_Plate2_C2 PRO1748_Plate2_D2 PRO1748_Plate2_E2 PRO1748_Plate2_F2 PRO1748_Plate2_G2 PRO1748_Plate2_H2 PRO1748_Plate2_A3 PRO1748_Plate2_C3 PRO1748_Plate2_D3 PRO1748_Plate2_E3 PRO1748_Plate2_F3 PRO1748_Plate2_G3 PRO1748_Plate2_H3 PRO1748_Plate2_A4 PRO1748_Plate2_B4 PRO1748_Plate2_C4 PRO1748_Plate2_D4 PRO1748_Plate2_E4 PRO1748_Plate2_F4 PRO1748_Plate2_G4 PRO1748_Plate2_H4 PRO1748_Plate2_A5 PRO1748_Plate2_B5 PRO1748_Plate2_C5 PRO1748_Plate2_D5 PRO1748_Plate2_E5 PRO1748_Plate2_F5 PRO1748_Plate2_G5 PRO1748_Plate2_H5 PRO1748_Plate2_A6 PRO1748_Plate2_B6 PRO1748_Plate2_C6"
#---define directory
filtereddir="/datos/fgutzwiller/cleaned_data/sediments_marDeCortes"
assemblydir="/datos/fgutzwiller/genome_extraction/assembly/sediments_marDeCortes/concat_samples_megahit"
bamdir="/datos/fgutzwiller/genome_extraction/mapped_to_contigs/sediments_marDeCortes"
bindir="/datos/fgutzwiller/genome_extraction/bins/sediments_marDeCortes/concoct"

for i in $samples
do

#extract coverage value for each contigs from mapped samples bam files
samtools idxstats $bamdir/samples_to_concat/${i}.bam | awk 'BEGIN{OFS="\t"};{print $1, $2, $3}' > $bamdir/samples_to_concat/${i}.coverage


done

#make a coverage table gathering all samples
Rscript make_concoct_cov.r "$bamdir/samples_to_concat/"

source activate concoct_env

#rhizosphere 2017
##run concoct using default parameters
#concoct --coverage_file $bamdir/samples_to_concat/concoct_all.coverage  --composition_file $assemblydir/contigs.fasta -b $bindir/

#sediments
#run concoct using contig threshold 2000
concoct -l 2000 --coverage_file $bamdir/samples_to_concat/concoct_all.coverage  --composition_file $assemblydir/final.contigs.fa -b $bindir/

source deactivate concoct_env

