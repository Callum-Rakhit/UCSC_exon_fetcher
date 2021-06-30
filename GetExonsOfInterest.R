# Load libraries
library(data.table)

# Import all exons
args = commandArgs(trailingOnly = T)

# args <- c("~/Biliary_Brush/UCSC_hg19/hg19_all_exons.bed", 
#           "~/Biliary_Brush/UCSC_hg19/target_exons.csv")
exon_bed <- read.table(file = args[1])
colnames(exon_bed) <- c("Chr", "Start", "End", "Gene", "Strand", "Accession_Number")

all_rows <- list()
for(i in as.data.frame(table(exon_bed$Gene))$Freq) {
  row <- rep(paste("exon_", 1:i, sep = ""), 1)
  all_rows <- append(all_rows, row)
}

exon_bed <- exon_bed[order(exon_bed$Gene),]
row.names(exon_bed) <- NULL

exon_bed$Exon_Numbers <- all_rows
exon_bed$Exon_Numbers <- as.character(exon_bed$Exon_Numbers)

write.table(x = exon_bed, 
            file = "~/Biliary_Brush/UCSC_hg19/hg19_all_exons_with_numbers.bed", 
            row.names = F, quote = F)

target_exons <- read.table(file = args[2], sep = ",", header = T)
target_exons_df <- exon_bed[F,]

for (i in unique(target_exons$Gene)) {
  temp_df <- exon_bed[exon_bed$Gene == i, ]
  temp_targets <- target_exons[target_exons$Gene == i, ]
  exons_to_select <- strsplit(as.character(temp_targets$Target_exons_identified), split = ",")
  exons_to_select <- as.data.frame(exons_to_select)
  colnames(exons_to_select) <- c("Exons")
  exons_to_select$Exons <- as.character(exons_to_select$Exons)
  for (i in 1:length(exons_to_select$Exons)){
    exons_to_select$Exons[i] <- paste("exon_", exons_to_select$Exons[i], sep = "")
  }
  target_exons_df <- rbind(target_exons_df, temp_df[match(exons_to_select$Exons, table = temp_df$Exon_Numbers),])
  row.names(target_exons_df) <- NULL
}

write.table(x = target_exons_df, file = "~/Biliary_Brush/Target_Exon_Coordinates", 
            quote = F, sep = "\t", row.names = F)

