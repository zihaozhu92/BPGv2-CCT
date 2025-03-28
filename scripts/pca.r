library(Biostrings)
library(FactoMineR)
library(factoextra)
library(ggplot2)

#parse Figure3C_pan76_CCT_pca.fasta into separate .fas files for each genotype
#for FigureS3A, all VRN2 sequences were removed
#read all .fas files in the folder
fasta_files <- list.files(path = "C:\\Users\\zhuz\\Desktop\\CCT\\PCA\\pan76", pattern = "\\.fas$", full.names = TRUE)

#read amino acid sequences, generate k-mers, and count frequencies of each k-mer
compute_kmer_freq <- function(fasta_file, k = 3) {
  sequences <- readAAStringSet(fasta_file) 
  generate_kmers <- function(seq, k) {
    kmers <- character(length = nchar(seq) - k + 1)  
    for (i in 1:(nchar(seq) - k + 1)) {
      kmers[i] <- substr(seq, i, i + k - 1)  
    }
    return(kmers)
  }
  all_kmers <- unlist(lapply(sequences, generate_kmers, k = k))
  kmer_freq <- table(all_kmers)
  return(kmer_freq)  
  }

#compute for all genotypes, and get the union of all possible k-mers
kmer_list <- lapply(fasta_files, compute_kmer_freq)
all_kmers_union <- unique(unlist(lapply(kmer_list, names)))

#build k-mer matrix
kmer_matrix <- matrix(0, nrow = length(fasta_files), ncol = length(all_kmers_union))
colnames(kmer_matrix) <- all_kmers_union
for (i in 1:length(fasta_files)) {
  kmer_freq <- kmer_list[[i]]
  kmer_matrix[i, names(kmer_freq)] <- as.numeric(kmer_freq) 
}

#normalize by total number of k-mers in each file, to account for PAVs and CNVs
kmer_matrix <- sweep(kmer_matrix, 1, rowSums(kmer_matrix), "/")

#assign genotype names as row names (remove "_CCT" and use short names)
genotype_names <- basename(fasta_files)
genotype_names <- sub("_CCT.*", "", genotype_names)
rownames(kmer_matrix) <- genotype_names

#pca and visualization
pca_result <- PCA(kmer_matrix, scale.unit = TRUE, graph = FALSE)
fviz_pca_ind(pca_result,
             label = "all",  
             col.ind = "cos2",  
             gradient.cols = c("blue", "red"),
             repel = TRUE,
             labelsize=5,
             pointsize=3)+ 
theme_minimal(base_size = 20)

