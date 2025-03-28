library(readxl)
library(writexl)
library(ComplexHeatmap)
library(viridis)
library(viridisLite)
library(colorRamp2)
library(dplyr)


data <- read_excel("pan20_tpm_plot.xlsx") |> as.data.frame()
rownames(data) <- data[[1]]

data_matrix <- as.matrix(data[, -1]) 

rownames(data_matrix) <- as.character(rownames(data_matrix))
summary(data_matrix)

colors <- viridis(100, option="D", direction=-1)
data_matrix_flipped <- t(data_matrix)

pdf("pan20_tpm_plot_flipped.pdf")
heatmap_pan20_tpm <- Heatmap(data_matrix_flipped, name = "TPM", 
                             row_title = "Gene", column_title = "Tissue",
                             col = colors, 
                             na_col = "grey",  
                             cluster_rows = FALSE, cluster_columns = FALSE,
                             show_row_names = TRUE, show_column_names = TRUE,
                             use_raster = FALSE)
plot(heatmap_pan20_tpm)
dev.off()
