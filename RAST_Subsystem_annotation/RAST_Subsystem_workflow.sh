#extracting accessory 95 gene list from x_pan_genome_reference.fa and merging into one contig fasta file, to prepare input for PATRIC Rast annotation
# calculations for  given replicons
# in main folder
# chromosome
python pangenome_merge.py \
  accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_pan_genome_reference.fa \
  accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt \
  accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_pan_genome_artgenome.fasta
python pangenome_merge.py \
  accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_pan_genome_reference.fa \
  accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt \
  accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_pan_genome_artgenome.fasta
python pangenome_merge.py \
  accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_pan_genome_reference.fa \
  accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
  accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_pan_genome_artgenome.fasta
python pangenome_merge.py \
  accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_pan_genome_reference.fa \
  accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt \
  accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_pan_genome_artgenome.fasta
python pangenome_merge.py \
  accessory_output/chromosome/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa \
  accessory_output/chromosome/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
  accessory_output/chromosome/Vibrio_genus/Vibrio_genus_95_pan_genome_artgenome.fasta

# chromid
python pangenome_merge.py \
  accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_pan_genome_reference.fa \
  accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt \
  accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_pan_genome_artgenome.fasta
python pangenome_merge.py \
  accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_pan_genome_reference.fa \
  accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt \
  accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_95_pan_genome_artgenome.fasta
python pangenome_merge.py \
  accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_pan_genome_reference.fa \
  accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
  accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_pan_genome_artgenome.fasta
python pangenome_merge.py \
  accessory_output/chromid/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa \
  accessory_output/chromid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
  accessory_output/chromid/Vibrio_genus/Vibrio_genus_95_pan_genome_artgenome.fasta

# megaplasmid
python pangenome_merge.py \
  accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_pan_genome_reference.fa \
  accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
  accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_pan_genome_artgenome.fasta
python pangenome_merge.py \
  accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_pan_genome_reference.fa \
  accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt \
  accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_pan_genome_artgenome.fasta
python pangenome_merge.py \
  accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa \
  accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
  accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_pan_genome_artgenome.fasta

# uploading fasta files to PATRIC ws
p3-login xxx
p3-mkdir /piotrkoper@patricbrc.org/home/gamma_multipartite

#chromosome
p3-mkdir /piotrkoper@patricbrc.org/home/gamma_multipartite/chromosome
p3-cp accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/chromosome
p3-cp accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/chromosome
p3-cp accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/chromosome
p3-cp accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/chromosome
p3-cp accessory_output/chromosome/Vibrio_genus/Vibrio_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/chromosome

p3-ls /piotrkoper@patricbrc.org/home/gamma_multipartite/chromosome

#chromid
p3-mkdir /piotrkoper@patricbrc.org/home/gamma_multipartite/chromid
p3-cp accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/chromid
p3-cp accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/chromid
p3-cp accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/chromid
p3-cp accessory_output/chromid/Vibrio_genus/Vibrio_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/chromid
p3-ls /piotrkoper@patricbrc.org/home/gamma_multipartite/chromid

#megaplasmid
p3-mkdir /piotrkoper@patricbrc.org/home/gamma_multipartite/megaplasmid
p3-cp accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/megaplasmid
p3-cp accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/megaplasmid
p3-cp accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_pan_genome_artgenome.fasta \
  ws:/piotrkoper@patricbrc.org/home/gamma_multipartite/megaplasmid
p3-ls /piotrkoper@patricbrc.org/home/gamma_multipartite/megaplasmid

#change file type to contigs
#start annotation job from webserver or using p3-submit-genome-annotation script
p3-submit-genome-annotation

#download subsystem annotation from PATRIC server xxx_replicon_95_pan_genome_subsystems.csv file naming scheme

#calculating subsytems for given replicons
#chromosome
python subsystems_calculations.py RAST_mapping/chromosome/Aliivibrio_genus/Aliivibrio_genus_chromosome_95_pan_genome_subsystems.csv
python subsystems_calculations.py RAST_mapping/chromosome/Photobacterium_genus/Photobacterium_genus_chromosome_95_pan_genome_subsystems.csv
python subsystems_calculations.py RAST_mapping/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_chromosome_95_pan_genome_subsystems.csv
python subsystems_calculations.py RAST_mapping/chromosome/Salinivibrio_genus/Salinivibrio_genus_chromosome_95_pan_genome_subsystems.csv
python subsystems_calculations.py RAST_mapping/chromosome/Vibrio_genus/Vibrio_genus_chromosome_95_pan_genome_subsystems.csv

#chromid
python subsystems_calculations.py RAST_mapping/chromid/Aliivibrio_genus/Aliivibrio_genus_chromid_95_pan_genome_subsystems.csv
python subsystems_calculations.py RAST_mapping/chromid/Photobacterium_genus/Photobacterium_genus_chromid_95_pan_genome_subsystems.csv
python subsystems_calculations.py RAST_mapping/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_chromid_95_pan_genome_subsystems.csv
python subsystems_calculations.py RAST_mapping/chromid/Vibrio_genus/Vibrio_genus_chromid_95_pan_genome_subsystems.csv

#megaplasmid
python subsystems_calculations.py RAST_mapping/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_megaplasmid_95_pan_genome_subsystems.csv
python subsystems_calculations.py RAST_mapping/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_megaplasmid_95_pan_genome_subsystems.csv
python subsystems_calculations.py RAST_mapping/megaplasmid/Vibrio_genus/Vibrio_genus_megaplasmid_95_pan_genome_subsystems.csv

#calculating Fisher Exact Test for inner genus replicon comparisons
python subsystems_fisher_test.py RAST_mapping/Fisher_test/Aliivibrio_genus_chromosome_95_pan_genome_subsystems_calc.csv \
    RAST_mapping/Fisher_test/Aliivibrio_genus_chromid_95_pan_genome_subsystems_calc.csv

python subsystems_fisher_test.py RAST_mapping/Fisher_test/Photobacterium_genus_chromosome_95_pan_genome_subsystems_calc.csv \
    RAST_mapping/Fisher_test/Photobacterium_genus_chromid_95_pan_genome_subsystems_calc.csv

python subsystems_fisher_test.py RAST_mapping/Fisher_test/Pseudoalteromonas_genus_chromosome_95_pan_genome_subsystems_calc.csv \
    RAST_mapping/Fisher_test/Pseudoalteromonas_genus_chromid_95_pan_genome_subsystems_calc.csv
python subsystems_fisher_test.py RAST_mapping/Fisher_test/Pseudoalteromonas_genus_chromosome_95_pan_genome_subsystems_calc.csv \
    RAST_mapping/Fisher_test/Pseudoalteromonas_genus_megaplasmid_95_pan_genome_subsystems_calc.csv

python subsystems_fisher_test.py RAST_mapping/Fisher_test/Salinivibrio_genus_chromosome_95_pan_genome_subsystems_calc.csv \
    RAST_mapping/Fisher_test/Salinivibrio_genus_megaplasmid_95_pan_genome_subsystems_calc.csv
    
python subsystems_fisher_test.py RAST_mapping/Fisher_test/Vibrio_genus_chromosome_95_pan_genome_subsystems_calc.csv \
    RAST_mapping/Fisher_test/Vibrio_genus_chromid_95_pan_genome_subsystems_calc.csv
python subsystems_fisher_test.py RAST_mapping/Fisher_test/Vibrio_genus_chromosome_95_pan_genome_subsystems_calc.csv \
    RAST_mapping/Fisher_test/Vibrio_genus_megaplasmid_95_pan_genome_subsystems_calc.csv


# concatenating extrachromosomal replicons into single files for intragenus comparisons
# Pseudoalteromonas - chromid + megaplasmid
mkdir -p mkdir -p RAST_mapping/extrachromosomal/Pseudoalteromonas_genus

cat RAST_mapping/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_chromid_95_pan_genome_subsystems.csv \
    > RAST_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_extrachromosomal_95_pan_genome_subsystems

cat RAST_mapping/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_megaplasmid_95_pan_genome_subsystems.csv \
    | tail -n +2 \
    >> RAST_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_extrachromosomal_95_pan_genome_subsystems.csv

#check
cat RAST_mapping/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_chromid_95_pan_genome_subsystems.csv | wc -l
#564
cat RAST_mapping/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_megaplasmid_95_pan_genome_subsystems.csv | wc -l
#195
cat RAST_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_extrachromosomal_95_pan_genome_subsystems.csv | wc -l
#768

# Vibrio - chromid + megaplasmid
mkdir -p mkdir -p RAST_mapping/extrachromosomal/Vibrio_genus

cat RAST_mapping/chromid/Vibrio_genus/Vibrio_genus_chromid_95_pan_genome_subsystems.csv \
    > RAST_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus_extrachromosomal_95_pan_genome_subsystems

cat RAST_mapping/megaplasmid/Vibrio_genus/Vibrio_genus_megaplasmid_95_pan_genome_subsystems.csv \
    | tail -n +2 \
    >> RAST_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus_extrachromosomal_95_pan_genome_subsystems.csv
    
#check
cat RAST_mapping/chromid/Vibrio_genus/Vibrio_genus_chromid_95_pan_genome_subsystems.csv | wc -l
#3639
cat RAST_mapping/megaplasmid/Vibrio_genus/Vibrio_genus_megaplasmid_95_pan_genome_subsystems.csv | wc -l
#156
cat RAST_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus_extrachromosomal_95_pan_genome_subsystems.csv | wc -l

#calculating subsystems summary for extrachromosomal replicons
python subsystems_calculations.py RAST_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_extrachromosomal_95_pan_genome_subsystems.csv
python subsystems_calculations.py RAST_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus_extrachromosomal_95_pan_genome_subsystems.csv

#calculating Fisher Exact Test for extrachromosomal vs chromosome comparisons
python subsystems_fisher_test.py RAST_mapping/Fisher_test/Pseudoalteromonas_genus_chromosome_95_pan_genome_subsystems_calc.csv \
    RAST_mapping/Fisher_test/Pseudoalteromonas_genus_extrachromosomal_95_pan_genome_subsystems_calc.csv
python subsystems_fisher_test.py RAST_mapping/Fisher_test/Vibrio_genus_chromosome_95_pan_genome_subsystems_calc.csv \
    RAST_mapping/Fisher_test/Vibrio_genus_extrachromosomal_95_pan_genome_subsystems_calc.csv

#concatenating all chromosome and extrachromosomal annotations into single files
#chromosome
mkdir -p RAST_mapping/chromosome/All_genus

cat RAST_mapping/chromosome/Aliivibrio_genus/Aliivibrio_genus_chromosome_95_pan_genome_subsystems.csv \
    > RAST_mapping/chromosome/All_genus/All_genus_chromosome_95_pan_genome_subsystems.csv
cat RAST_mapping/chromosome/Photobacterium_genus/Photobacterium_genus_chromosome_95_pan_genome_subsystems.csv \
    | tail -n +2 \
    >> RAST_mapping/chromosome/All_genus/All_genus_chromosome_95_pan_genome_subsystems.csv
cat RAST_mapping/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_chromosome_95_pan_genome_subsystems.csv \
    | tail -n +2 \
    >> RAST_mapping/chromosome/All_genus/All_genus_chromosome_95_pan_genome_subsystems.csv
cat RAST_mapping/chromosome/Salinivibrio_genus/Salinivibrio_genus_chromosome_95_pan_genome_subsystems.csv \
    | tail -n +2 \
    >> RAST_mapping/chromosome/All_genus/All_genus_chromosome_95_pan_genome_subsystems.csv
cat RAST_mapping/chromosome/Vibrio_genus/Vibrio_genus_chromosome_95_pan_genome_subsystems.csv \
    | tail -n +2 \
    >> RAST_mapping/chromosome/All_genus/All_genus_chromosome_95_pan_genome_subsystems.csv

#extrachromosomal
mkdir -p RAST_mapping/extrachromosomal/All_genus

cat RAST_mapping/chromid/Aliivibrio_genus/Aliivibrio_genus_chromid_95_pan_genome_subsystems.csv \
    > RAST_mapping/extrachromosomal/All_genus/All_genus_extrachromosomal_95_pan_genome_subsystems.csv
cat RAST_mapping/chromid/Photobacterium_genus/Photobacterium_genus_chromid_95_pan_genome_subsystems.csv \
    | tail -n +2 \
    >> RAST_mapping/extrachromosomal/All_genus/All_genus_extrachromosomal_95_pan_genome_subsystems.csv
cat RAST_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_extrachromosomal_95_pan_genome_subsystems.csv \
    | tail -n +2 \
    >> RAST_mapping/extrachromosomal/All_genus/All_genus_extrachromosomal_95_pan_genome_subsystems.csv
cat RAST_mapping/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_megaplasmid_95_pan_genome_subsystems.csv \
    | tail -n +2 \
    >> RAST_mapping/extrachromosomal/All_genus/All_genus_extrachromosomal_95_pan_genome_subsystems.csv
cat RAST_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus_extrachromosomal_95_pan_genome_subsystems.csv \
    | tail -n +2 \
    >> RAST_mapping/extrachromosomal/All_genus/All_genus_extrachromosomal_95_pan_genome_subsystems.csv

#calculating subsystems summary for all chromosome and all eztrachromosomal
python subsystems_calculations.py RAST_mapping/chromosome/All_genus/All_genus_chromosome_95_pan_genome_subsystems.csv
python subsystems_calculations.py RAST_mapping/extrachromosomal/All_genus/All_genus_extrachromosomal_95_pan_genome_subsystems.csv

python subsystems_fisher_test.py RAST_mapping/Fisher_test/All_genus_chromosome_95_pan_genome_subsystems_calc.csv \
    RAST_mapping/Fisher_test/All_genus_extrachromosomal_95_pan_genome_subsystems_calc.csv

