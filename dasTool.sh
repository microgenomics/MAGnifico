#!/bin/bash

#---define directories
#rhizosphere 2017
bindir="/datos/fgutzwiller/genome_extraction/bins/rhizosphere_2017"
compiledir="/datos/fgutzwiller/genome_extraction/bins/rhizosphere_2017/dastool"
assemblydir="/datos/fgutzwiller/genome_extraction/assembly/rhizosphere_2017/concat_samples"
#sediments 
bindir="/datos/fgutzwiller/genome_extraction/bins/sediments_marDeCortes"
compiledir="/datos/fgutzwiller/genome_extraction/bins/sediments_marDeCortes/dastool"
assemblydir="/datos/fgutzwiller/genome_extraction/assembly/sediments_marDeCortes/concat_samples_megahit"

#get tables of correspondance between contigs and bins
#sh prepare_DASTool_tables.sh

source activate dasTool

#rhizosphere 2017
##run DasTool, write out bins and lower score threshold 0.3 instead of 0.5
#/home/fgutzwiller/programs/DAS_Tool/DAS_Tool -i $bindir/maxbin_500.scaffolds2bin,$bindir/maxbin_1000.scaffolds2bin,$bindir/metabat.scaffolds2bin,$bindir/concoct.scaffolds2bin -l maxbin_500,maxbin_1000,metabat,concoct -c $assemblydir/contigs.fasta -o $compiledir/dasTool --search_engine blast --write_bins 1 -t 40 --score_threshold 0.3

#sediments
/home/fgutzwiller/programs/DAS_Tool/DAS_Tool -i $bindir/maxbin.scaffolds2bin,$bindir/metabat.scaffolds2bin,$bindir/concoct.scaffolds2bin -l maxbin,metabat,concoct -c $assemblydir/final.contigs.fa -o $compiledir/dasTool --search_engine blast --write_bins 1 -t 40 

source deactivate dasTool

