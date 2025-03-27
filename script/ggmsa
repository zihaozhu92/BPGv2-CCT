library(Biostrings)
library(ggmsa)
library(ggplot2)

#for Figure2B HvCO1 dna sequences
aln<-readAAMultipleAlignment(dna_sequences)
ggmsa(dna_sequences,char_width=0.05,seq_name=F,
            font=NULL,color="Zappo_NT",
            border=NA)+geom_msaBar()

#for Figure3B HvCMF4 and FigureS3C HvCMF1 amino acid sequences
Strand_color <-read.csv("Strand_code.csv",stringsAsFactors = FALSE)
head(Strand_color)
Strand_color$color <- trimws(Strand_color$color)
plot<-ggmsa(protein_sequences,char_width=0.05,seq_name=F,
            font=NULL,custom_color=Strand_color, 
            border=NA)+geom_msaBar()

