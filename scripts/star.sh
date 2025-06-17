module load fastp/0.20.0
module load STAR/2.7.9a

#SAMPLE
#ZT04: ERR3564268, ERR3564269
#ZT16: ERR3564258, ERR3564259

#adapter and quality trimming
fastp -i SAMPLE.fastq.gz  -o SAMPLE.trim.fastq.gz  -h SAMPLE_report.html -j SAMPLE_report.json

#genome preparation
STAR --runMode genomeGenerate \
     --genomeDir /filer-5/agruppen/GGR/zhuz/Bowman_24/Akashinriki_ref \
     --genomeFastaFiles 220816_Akashinirki_pseudomolecules_and_unplaced_contigs_CPclean.fasta \
     --genomeSAindexNbases 13 \
     --genomeChrBinNbits 16  

#mapping (ZT04)
STAR --genomeDir /filer-5/agruppen/GGR/zhuz/Bowman_24/Akashinriki_ref \
--readFilesIn ERR3564268.trim.fastq.gz ERR3564269.trim.fastq.gz \
--readFilesCommand zcat --runThreadN 16 \
--twopassMode Basic \
--outSAMtype BAM SortedByCoordinate \
--outFilterScoreMinOverLread 0.1 \
--outFilterMatchNminOverLread 0.1 \
--outFilterMultimapNmax 50 \
--alignIntronMax 100000 \
--alignSJDBoverhangMin 1 \
--outFileNamePrefix Bow2Aka_ZT04
