module load samtools/1.16.1
module load mafft/7.490
module load minimap2/2.24
module load syri/1.6
module load plotsr/0.5.2

#extract VRN2 regions
samtools faidx 220816_Akashinirki_pseudomolecules_and_unplaced_contigs_CPclean.fasta chr4H:604639923-604760731 > Akashinriki_vrn2.fasta
samtools faidx 220810_Igri_pseudomolecules_and_unplaced_contigs_CPclean.fasta chr4H:602472172-602574215 > Igri_vrn2.fasta
samtools faidx 220503_HOR_7552_pseudomolecules_and_unplaced_contigs_CPclean.fasta chr4H:605045179-605145146 > H75_vrn2.fasta
samtools faidx 211126_HOR_6220_pseudomolecules_and_unplaced_contigs_CPclean.fasta chr4H:605387828-605495113 > H62_vrn2.fasta
samtools faidx 220411_10TJ18_pseudomolecules_and_unplaced_contigs_CPclean.fasta chr4H:602497650-602604576 > 10TJ_vrn2.fasta

#msa was used to determine the order of pair-wise comparison
cat Akashinriki_vrn2.fasta Igri_vrn2.fasta H75_vrn2.fasta H62_vrn2.fasta 10TJ_vrn2.fasta > vrn2_combined.fasta
mafft --auto vrn2_combined.fasta > vrn2_aligned.fasta

#pair-wise alignment
minimap2 -ax sr --eqx -t 8 Igri_vrn2.fasta Akashinriki_vrn2.fasta > I_vs_A.sam
minimap2 -ax sr --eqx -t 8 Akashinriki_vrn2.fasta H62_vrn2.fasta > A_vs_H62.sam
minimap2 -ax sr --eqx -t 8 H62_vrn2.fasta H75_vrn2.fasta > H62_vs_H75.sam
minimap2 -ax sr --eqx -t 8 H75_vrn2.fasta 10TJ_vrn2.fasta > H75_vs_10TJ.sam

#synteny report and visualization
syri -c I_vs_A.sam -r Igri_vrn2.fasta -q Akashinriki_vrn2.fasta -F S --cigar --prefix I_A --all
syri -c A_vs_H62.sam -r Akashinriki_vrn2.fasta -q H62_vrn2.fasta -F S --cigar --prefix A_H62 --all
syri -c H62_vs_H75.sam -r H62_vrn2.fasta -q H75_vrn2.fasta -F S --cigar --prefix H62_H75 --all
syri -c H75_vs_10TJ.sam -r H75_vrn2.fasta -q 10TJ_vrn2.fasta -F S --cigar --prefix H75_10TJ --all

plotsr \
     --sr I_Asyri.out \
     --sr A_H62syri.out \
     --sr H62_H75syri.out \
     --sr H75_10TJsyri.out \
     -o synteny_plot.pdf \
     --genomes genomes.txt \
     -s 1000 \
     -d 1000 \
     -W 6 \
     -H 4
     
