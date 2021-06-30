# UCSC_exon_fetcher


```bash
# Get genome and redGene annotations
wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/database/refGene.txt.gz
wget http://hgdownload.cse.ucsc.edu/goldenpath/hg19/bigZips/hg19.2bit

# Convert 2bit to fa
wget http://hgdownload.cse.ucsc.edu/admin/exe/linux.x86_64/twoBitToFa
chmod 744 twoBitToFa
./twoBitToFa hg19.2bit hg19.fa

# Extract exon coordinates
zcat refGene.txt.gz | awk -f to_transcript.awk > hg19_all_exons.bed

# Run Rscipt
/usr/bin/Rscript ./GetExonsOfInterest.R "~/Biliary_Brush/UCSC_hg19/hg19_all_exons.bed" "~/Biliary_Brush/UCSC_hg19/target_exons.csv"

```
