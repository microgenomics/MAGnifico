#!/bin/bash

##---define samples
#samples="G1-1 G1-2 G1-3 G2-1 G2-2 G2-3"
#
##---define directories
#filtereddir="/datos/fgutzwiller/filtered_data/rhizosphere_2017/no_cut"
#assemblydir="/datos/fgutzwiller/genome_extraction/assembly/rhizosphere_2017/concat_samples"
#bindir="/datos/fgutzwiller/genome_extraction/bins/rhizosphere_2017/maxbin"


#--------for sediments cortes sea
#---define directories
filtereddir="/datos/fgutzwiller/cleaned_data/sediments_marDeCortes"
assemblydir="/datos/fgutzwiller/genome_extraction/assembly/sediments_marDeCortes/concat_samples_megahit"
bindir="/datos/fgutzwiller/genome_extraction/bins/sediments_marDeCortes"

#prepare empty file for read list
rm reads_list.txt
touch reads_list.txt


for i in `ls $filtereddir/*_all.fastq`
do

echo $i >> reads_list.txt

done

##run maxbin with a contig size threshold of 500
#run_MaxBin.pl -verbose -thread 32 -min_contig_length 500 -contig $assemblydir/contigs.fasta -out $bindir/from500/maxbin_6samples -reads_list reads_list.txt

#run maxbin with the default contig size threshold of 2000
run_MaxBin.pl -verbose -thread 20 -min_contig_length 2000 -contig $assemblydir/final.contigs.fa -out $bindir/maxbin/sediments -reads_list reads_list.txt

