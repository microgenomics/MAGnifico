#!/bin/bash

#---define directories
#rhizosphere
#bindir="/datos/fgutzwiller/genome_extraction/bins/rhizosphere_2017/dastool/dasTool_DASTool_bins"
#resultsdir="/datos/fgutzwiller/genome_extraction/bins_annotation/rhizosphere_2017/amphora2"

#sediments
bindir="/datos/fgutzwiller/genome_extraction/bins/sediments_marDeCortes/dastool/dasTool_DASTool_bins"
resultsdir="/datos/fgutzwiller/genome_extraction/bins_annotation/sediments_marDeCortes/amphora2"
tmpbindir="/datos/fgutzwiller/genome_extraction/bins_annotation/sediments_marDeCortes/amphora2/tmp_bin"

source activate amphora2

#amphora will add iteratively the results to results already in folder. To start again, other files need to be erased
#run amphora2 with default parameters on bins selected by DASTool


for i in `ls $bindir/*.fa`
do

bin=$(basename "$i" )

#separate archae bins from bacterial
 if [[ $bin =~ ^(sediments.055.fasta.contigs.fa|metabat.13.fa_sub.contigs.fa)$ ]]; then
   
   cat $i | sed -e "s/>/>${bin}_/g" > $tmpbindir/$bin

   cd $resultsdir/archae
   perl /home/fgutzwiller/programs/amphora2/AMPHORA2/Scripts/MarkerScanner.pl -Archaea -DNA $tmpbindir/$bin
   rm $tmpbindir/$bin

 else

   cat $i | sed -e "s/>/>${bin}_/g" > $tmpbindir/$bin

   cd $resultsdir/bact
   perl /home/fgutzwiller/programs/amphora2/AMPHORA2/Scripts/MarkerScanner.pl -Bacteria -DNA $tmpbindir/$bin 
   rm $tmpbindir/$bin

 fi

done

cd $resultsdir/bact

perl /home/fgutzwiller/programs/amphora2/AMPHORA2/Scripts/MarkerAlignTrim.pl -WithReference -OutputFormat phylip

perl /home/fgutzwiller/programs/amphora2/AMPHORA2/Scripts/Phylotyping.pl -CPUs 5 > phylotype.result

cd $resultsdir/archae

perl /home/fgutzwiller/programs/amphora2/AMPHORA2/Scripts/MarkerAlignTrim.pl -WithReference -OutputFormat phylip

perl /home/fgutzwiller/programs/amphora2/AMPHORA2/Scripts/Phylotyping.pl -CPUs 5 > phylotype.result

source deactivate amphora2




