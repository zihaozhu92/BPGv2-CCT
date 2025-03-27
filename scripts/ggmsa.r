##ggmsa
##http://yulab-smu.top/ggmsa/articles/ggmsa.html

library(Biostrings)
library(ggmsa)
library(ggplot2)

#for Figure2B HvCO1 dna sequences
dna_sequences <- system.file("extdata", "xxx_msa4ggmsa.fasta", package = "ggmsa")
ggmsa(dna_sequences,char_width=0.05,seq_name=F,
            font=NULL,color="Zappo_NT",
            border=NA)+geom_msaBar()

#for Figure3B HvCMF4 and FigureS3C HvCMF1 amino acid sequences
protein_sequences <- system.file("extdata", "xxx_msa4ggmsa.fasta", package = "ggmsa")
Strand_color <-read.csv("ggmsa_strand_code.csv",stringsAsFactors = FALSE)
head(Strand_color)
Strand_color$color <- trimws(Strand_color$color)
plot<-ggmsa(protein_sequences,char_width=0.05,seq_name=F,
            font=NULL,custom_color=Strand_color, 
            border=NA)+geom_msaBar()

