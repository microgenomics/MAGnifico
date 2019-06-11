#!/bin/bash

#-------for rhizosphere 2017
##---define samples
#samples="G1-1 G1-2 G1-3 G2-1 G2-2 G2-3"
##---define directories
#filtereddir="/datos/fgutzwiller/filtered_data/rhizosphere_2017/no_cut"
#assemblydir="/datos/fgutzwiller/genome_extraction/assembly/rhizosphere_2017"

#--------for sediments cortes sea
#---define directories
filtereddir="/datos/fgutzwiller/cleaned_data/sediments_marDeCortes"
assemblydir="/datos/fgutzwiller/genome_extraction/assembly/sediments_marDeCortes"


##run metaspades with default parameters
#metaspades.py -1 $filtereddir/concat_samples_1.fastq -2 $filtereddir/concat_samples_2.fastq -s $filtereddir/concat_samples_singletons.fastq -t 80 -m 1000 -o $assemblydir/concat_samples

#run megahit for less ram usage
/home/fgutzwiller/programs/megahit/megahit/megahit -1 $filtereddir/concat_samples_1.fastq -2 $filtereddir/concat_samples_2.fastq -r $filtereddir/concat_samples_singletons.fastq --k-min 39 --k-max 99 --k-step 12 -m 0.5 -t 20 -o $assemblydir/concat_samples_megahit

