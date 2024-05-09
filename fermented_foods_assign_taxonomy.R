########################################
# Museum Fermented Foods
#
# ChowChow,Kombucha tea, and kimchi
#
# 2020.11 - LM Nichols - assigned Taxa via dada2 
#
########################################

########################################
#Assigned Taxa via dada2 
########################################

#load libraries
library("dada2")

#####
#16S

#read in files and sequences
path <- "~/Documents/Dunn Lab Files/⁩Fermented Foods Manuscript 2/FF16S_NoPrimers_data" 
list.files(path)

seq <- getSequences(file.path(path, "16S_representative_sequences2_mod.fasta"))
seq2=as.data.frame(seq)
str(seq)

#assign tax
taxa<- assignTaxonomy(seq, "~/Documents/Fermented Foods Manuscript 2/silva_nr99_v138_wSpecies_train_set.fa.gz")
taxa.plus <- addSpecies(taxa, "~/Documents/Fermented Foods Manuscript 2/silva_species_assignment_v138.fa.gz", allowMultiple=TRUE,verbose=TRUE)

tax2 <- cbind(seq2,taxa)
tax2

#read in asv file
asv<-read.csv("~/Documents/Dunn Lab Files⁩/Fermented Foods Manuscript 2/FF16S_NoPrimers_data/16S_feature-table2_mod.csv", header=T )
str(asv)

test<-merge(asv,tax2,by.x="ASVID", by.y=0,ALL=T)

write.csv(test, "16S_ASV_wTaxa.csv")

#######
#ITS

#read in files/sequences
path <- "~/Documents/Fermented Foods Manuscript 2/FFITS_NoPrimers_data" 
list.files(path)

seq <- getSequences(file.path(path, "ITS_representative_sequences2.fasta"))
seq2=as.data.frame(seq)
str(seq)

#assign taxonomy
#NOTE: LONG run time. Only run if needed!
taxa<- assignTaxonomy(seq, "~/Documents/Fermented Foods Manuscript 2/FFITS_NoPrimers_data/sh_general_release_04.02.2020/sh_general_release_dynamic_04.02.2020.fasta")
#taxa.plus <- addSpecies(taxa, "~/Documents/Fermented Foods Manuscript 2/silva_species_assignment_v138.fa.gz", allowMultiple=TRUE,verbose=TRUE)

tax2 <- cbind(seq2,taxa)
tax2

write.csv(tax2, "~/Documents/Fermented Foods Manuscript 2/FFITS_NoPrimers_data/ITS_RepresentativeSeq_wTaxa.csv")

#read in asv file
ITSasv<-read.csv("~/Documents/Fermented Foods Manuscript 2/FFITS_NoPrimers_data/ITS_feature-table2.csv", header=T )
tax2 <- read.csv("~/Documents/Fermented Foods Manuscript 2/FFITS_NoPrimers_data/ITS_RepresentativeSeq_wTaxa.csv")

str(ITSasv)

test<-merge(ITSasv,tax2,by.x="OTU.ID", by.y=0,ALL=T)

write.csv(test, "~/Documents/Fermented Foods Manuscript 2/FFITS_NoPrimers_data/ITS_asv_wTaxa.csv")
