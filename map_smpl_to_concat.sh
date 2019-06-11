#!/bin/bash

#rhizosphere 2017
##---define samples
#samples="G1-1 G1-2 G1-3 G2-1 G2-2 G2-3"
##---define directories
#filtereddir="/datos/fgutzwiller/filtered_data/rhizosphere_2017/no_cut"
#assemblydir="/datos/fgutzwiller/genome_extraction/assembly/rhizosphere_2017/concat_samples"
#bamdir="/datos/fgutzwiller/genome_extraction/mapped_to_contigs/rhizosphere_2017"

#sediments
#---define samples
samples="PRO1748_Plate1_C1 PRO1748_Plate1_D1 PRO1748_Plate1_B2 PRO1748_Plate1_H2 PRO1748_Plate1_B3 PRO1748_Plate1_D3 PRO1748_Plate1_F3 PRO1748_Plate1_H3 PRO1748_Plate1_D4 PRO1748_Plate1_E4 PRO1748_Plate1_A5 PRO1748_Plate1_F5 PRO1748_Plate2_A1 PRO1748_Plate2_B1 PRO1748_Plate2_C1 PRO1748_Plate2_D1 PRO1748_Plate2_E1 PRO1748_Plate2_F1 PRO1748_Plate2_G1 PRO1748_Plate2_H1 PRO1748_Plate2_A2 PRO1748_Plate2_B2 PRO1748_Plate2_C2 PRO1748_Plate2_D2 PRO1748_Plate2_E2 PRO1748_Plate2_F2 PRO1748_Plate2_G2 PRO1748_Plate2_H2 PRO1748_Plate2_A3 PRO1748_Plate2_C3 PRO1748_Plate2_D3 PRO1748_Plate2_E3 PRO1748_Plate2_F3 PRO1748_Plate2_G3 PRO1748_Plate2_H3 PRO1748_Plate2_A4 PRO1748_Plate2_B4 PRO1748_Plate2_C4 PRO1748_Plate2_D4 PRO1748_Plate2_E4 PRO1748_Plate2_F4 PRO1748_Plate2_G4 PRO1748_Plate2_H4 PRO1748_Plate2_A5 PRO1748_Plate2_B5 PRO1748_Plate2_C5 PRO1748_Plate2_D5 PRO1748_Plate2_E5 PRO1748_Plate2_F5 PRO1748_Plate2_G5 PRO1748_Plate2_H5 PRO1748_Plate2_A6 PRO1748_Plate2_B6 PRO1748_Plate2_C6"
#---define directories
filtereddir="/datos/fgutzwiller/cleaned_data/sediments_marDeCortes"
assemblydir="/datos/fgutzwiller/genome_extraction//assembly/sediments_marDeCortes/concat_samples_megahit"
bamdir="/datos/fgutzwiller/genome_extraction/mapped_to_contigs/sediments_marDeCortes"

bamlist=""

#rhizosphere 2017
##index contig fasta
#bowtie2-build $assemblydir/contigs.fasta  $assemblydir/contigs

sediments
bowtie2-build $assemblydir/final.contigs.fa  $assemblydir/contigs

mkdir $bamdir/samples_to_concat
mkdir $bamdir/concat_samples

for i in $samples
do

#rhizosphere 2017
##map sample fastq to contigs with default parametes, then sort bam files
#bowtie2 -p 20 -x $assemblydir/contigs -1 $filtereddir/${i}_filtered_1.fastq -2 $filtereddir/${i}_filtered_2.fastq -U $filtereddir/${i}_singleton_filtered.fastq |  samtools view -bh | samtools sort -o $bamdir/samples_to_concat/${i}.bam

wholename=`ls $filtereddir/${i}*_1.fastq`
smpl=$(basename $wholename _1.fastq)

#sediments
bowtie2 -p 30 -x $assemblydir/contigs -1 $filtereddir/${smpl}_1.fastq -2 $filtereddir/${smpl}_2.fastq -U $filtereddir/${smpl}_1_singletons.fastq,$filtereddir/${smpl}_2_singletons.fastq |  samtools view -bh | samtools sort -o $bamdir/samples_to_concat/${i}.bam

#index generated bam files
samtools index -b $bamdir/samples_to_concat/${i}.bam


done
#
#rhizosphere 2017
##map concatenated samples fastq to contigs, then sort bam file 
#bowtie2 -p 20 -x $assemblydir/contigs -1 $filtereddir/concat_samples_1.fastq -2 $filtereddir/concat_samples_2.fastq -U $filtereddir/concat_samples_singleton.fastq |  samtools view -bh | samtools sort -o $bamdir/concat_samples/concat_samples.bam

#sediments
#map concatenated samples fastq to contigs, then sort bam file 
bowtie2 -p 30 -x $assemblydir/contigs -1 $filtereddir/concat_samples_1.fastq -2 $filtereddir/concat_samples_2.fastq -U $filtereddir/concat_samples_singletons.fastq |  samtools view -bh | samtools sort -o $bamdir/concat_samples/concat_samples.bam
