#!/bin/bash

##rhizosphere 2017
#bindir="/datos/fgutzwiller/genome_extraction/bins/rhizosphere_2017"

#sediments
bindir="/datos/fgutzwiller/genome_extraction/bins/sediments_marDeCortes"

##for maxbin with 500 threshold
#
#rm $bindir/maxbin_500.scaffolds2bin
#touch $bindir/maxbin_500.scaffolds2bin
#
#for i in `tail -n +2 $bindir/maxbin/from500/maxbin_6samples.summary | awk '{print $1}' | tr '\n' ' '`
#do
#
# for j in `cat $bindir/maxbin/from500/$i | grep ">" | sed 's/>//g' | tr '\n' ' '`
# do
#  
#  printf "$j\t$i\n" >> $bindir/maxbin_500.scaffolds2bin
# 
# done
#
#done
#
##for maxbin with 1000 threshold
#
#rm $bindir/maxbin_1000.scaffolds2bin
#touch $bindir/maxbin_1000.scaffolds2bin
#
#for i in `tail -n +2 $bindir/maxbin/from1000/maxbin_6samples.summary | awk '{print $1}' | tr '\n' ' '`
#do
#
# for j in `cat $bindir/maxbin/from1000/$i | grep ">" | sed 's/>//g' | tr '\n' ' '`
# do
#
#  printf "$j\t$i\n" >> $bindir/maxbin_1000.scaffolds2bin
#
# done
#
#done

#for maxbin with 2000 threshold sediments

rm $bindir/maxbin.scaffolds2bin
touch $bindir/maxbin.scaffolds2bin

for i in `tail -n +2 $bindir/maxbin/sediments.summary | awk '{print $1}' | tr '\n' ' '`
do

 for j in `cat $bindir/maxbin/$i | grep ">" | sed 's/>//g' | tr '\n' ' '`
 do

  printf "$j\t$i\n" >> $bindir/maxbin.scaffolds2bin

 done

done


#for metabat

rm $bindir/metabat.scaffolds2bin
touch $bindir/metabat.scaffolds2bin

for i in `ls $bindir/metabat`
do

 for j in `cat $bindir/metabat/$i | grep ">" | sed 's/>//g' | tr '\n' ' '`
 do

  printf "$j\t$i\n" >> $bindir/metabat.scaffolds2bin

 done

done


rm $bindir/concoct.scaffolds2bin
touch $bindir/concoct.scaffolds2bin

#rhizosphere
#cat $bindir/concoct/clustering_gt1000.csv | sed 's/,/\t/g' > $bindir/concoct.scaffolds2bin

#sediments
cat $bindir/concoct/clustering_gt2000.csv | sed 's/,/\t/g' > $bindir/concoct.scaffolds2bin


