#!/bin/bash

##rhizosphere 2017
##---define directories
#filtereddir="/datos/fgutzwiller/filtered_data/rhizosphere_2017/no_cut"
#assemblydir="/datos/fgutzwiller/genome_extraction/assembly/rhizosphere_2017/concat_samples"
#bindir="/datos/fgutzwiller/genome_extraction/bins/rhizosphere_2017/metabat"
#bamdir="/datos/fgutzwiller/genome_extraction/mapped_to_contigs/rhizosphere_2017/concat_samples"

#sediments mar de cortes
#---define directories
filtereddir="/datos/fgutzwiller/cleaned_data/sediments_marDeCortes"
assemblydir="/datos/fgutzwiller/genome_extraction/assembly/sediments_marDeCortes/concat_samples_megahit"
bindir="/datos/fgutzwiller/genome_extraction/bins/sediments_marDeCortes/metabat"
bamdir="/datos/fgutzwiller/genome_extraction/mapped_to_contigs/sediments_marDeCortes/concat_samples"


#get depth information for metabat
jgi_summarize_bam_contig_depths --outputDepth $bamdir/depth.txt  $bamdir/concat_samples.bam

##rhizosphere 2017
##run metabat with default parameters
#metabat2 -i $assemblydir/contigs.fasta -a $bamdir/depth.txt -o $bindir/metabat -t 20 

#sediments
#run metabat with contig size >= 2000
metabat2 -i $assemblydir/final.contigs.fa -m 2000 -a $bamdir/depth.txt -o $bindir/metabat -t 20 
