#get directory name

#get directory names
dir <-commandArgs(trailingOnly = TRUE)

##rhizosphere_2017
##define sample list and number of samples
#samples <- c("G1-1","G1-2","G1-3","G2-1","G2-2","G2-3")

#sediments mar de cortes
#define sample list and number of samples
samples<-c("PRO1748_Plate1_C1", "PRO1748_Plate1_D1", "PRO1748_Plate1_B2", "PRO1748_Plate1_H2", "PRO1748_Plate1_B3", "PRO1748_Plate1_D3", "PRO1748_Plate1_F3", "PRO1748_Plate1_H3", "PRO1748_Plate1_D4", "PRO1748_Plate1_E4", "PRO1748_Plate1_A5", "PRO1748_Plate1_F5", "PRO1748_Plate2_A1", "PRO1748_Plate2_B1", "PRO1748_Plate2_C1", "PRO1748_Plate2_D1", "PRO1748_Plate2_E1", "PRO1748_Plate2_F1", "PRO1748_Plate2_G1", "PRO1748_Plate2_H1", "PRO1748_Plate2_A2", "PRO1748_Plate2_B2", "PRO1748_Plate2_C2", "PRO1748_Plate2_D2", "PRO1748_Plate2_E2", "PRO1748_Plate2_F2", "PRO1748_Plate2_G2", "PRO1748_Plate2_H2", "PRO1748_Plate2_A3", "PRO1748_Plate2_C3", "PRO1748_Plate2_D3", "PRO1748_Plate2_E3", "PRO1748_Plate2_F3", "PRO1748_Plate2_G3", "PRO1748_Plate2_H3", "PRO1748_Plate2_A4", "PRO1748_Plate2_B4", "PRO1748_Plate2_C4", "PRO1748_Plate2_D4", "PRO1748_Plate2_E4", "PRO1748_Plate2_F4", "PRO1748_Plate2_G4", "PRO1748_Plate2_H4", "PRO1748_Plate2_A5", "PRO1748_Plate2_B5", "PRO1748_Plate2_C5", "PRO1748_Plate2_D5", "PRO1748_Plate2_E5", "PRO1748_Plate2_F5", "PRO1748_Plate2_G5", "PRO1748_Plate2_H5", "PRO1748_Plate2_A6", "PRO1748_Plate2_B6", "PRO1748_Plate2_C6")


smpl_nb <- length(samples)

for (i in 1:smpl_nb )
{
#read table of coverage for each samples
 path <- paste (dir,samples[i] , ".coverage", sep='' )
 table_cov <- read.table (path , header = F)
#normalize read count to contig length and add a 10000 factor for workable values
 table_cov$V2 <- table_cov$V3*10000/table_cov$V2
#make a subtable with values of interest
 table_cov <- table_cov[,c(1,2)]
 colnames(table_cov) <- c("contig",samples[i])
 
 if (i == 1)
 {
#prepare the general table
  table_all <- table_cov
 } 

#rename sample table
 cur_sample <- samples[i]
 assign(paste (cur_sample , "_cov", sep = ""), table_cov)
}


for (i in 2:smpl_nb )
{
#add remaining samples to the general table
cur_sample <- paste (samples[i])
current <- get (paste (cur_sample , "_cov" , sep = ""))

table_all <- merge (table_all, current, by.table_all = contig, by.current  = contig )
}

#write the output table
path <- paste (dir, "concoct_all.coverage", sep='' )
write.table(table_all[c(2:length(table_all$contig)),] , path , row.names = F , col.names = F , quote = F , sep = "\t")

