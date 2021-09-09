#extracting and counting COG categories from emapper result and query_pan_genome represenativa gene list

#copying emapper output for backup
cp -R eggnog_mapping/ eggnog_mapping_backup

# calculating COGs for given replicons
# chromosome
python COG_calculations.py accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt eggnog_mapping/chromosome/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations COG_output/Aliivibrio_chromosome_COG.csv
python COG_calculations.py accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt eggnog_mapping/chromosome/Photobacterium_genus/Photobacterium_genus.emapper.annotations COG_output/Photobacterium_chromosome_COG.csv
python COG_calculations.py accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt eggnog_mapping/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations COG_output/Pseudoalteromonas_chromosome_COG.csv
python COG_calculations.py accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt eggnog_mapping/chromosome/Salinivibrio_genus/Salinivibrio_genus.emapper.annotations COG_output/Salinivibrio_chromosome_COG.csv
python COG_calculations.py accessory_output/chromosome/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt eggnog_mapping/chromosome/Vibrio_genus/Vibrio_genus.emapper.annotations COG_output/Vibrio_chromosome_COG.csv

# chromid
python COG_calculations.py accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt eggnog_mapping/chromid/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations COG_output/Aliivibrio_chromid_COG.csv
python COG_calculations.py accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt eggnog_mapping/chromid/Photobacterium_genus/Photobacterium_genus.emapper.annotations COG_output/Photobacterium_chromid_COG.csv
python COG_calculations.py accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt eggnog_mapping/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations COG_output/Pseudoalteromonas_chromid_COG.csv
python COG_calculations.py accessory_output/chromid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt eggnog_mapping/chromid/Vibrio_genus/Vibrio_genus.emapper.annotations COG_output/Vibrio_chromid_COG.csv

# megaplasmid
python COG_calculations.py accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt eggnog_mapping/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations COG_output/Pseudoalteromonas_megaplasmid_COG.csv
python COG_calculations.py accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt eggnog_mapping/megaplasmid/Salinivibrio_genus/Salinivibrio_genus.emapper.annotations COG_output/Salinivibrio_megaplasmid_COG.csv
python COG_calculations.py accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt eggnog_mapping/megaplasmid/Vibrio_genus/Vibrio_genus.emapper.annotations COG_output/Vibrio_megaplasmid_COG.csv

# calculating Fisher Exact Test statistics (inner genus rreplicon comparisons)
python COG_fisher_test.py COG_output/Aliivibrio_chromosome_COG.csv COG_output/Aliivibrio_chromid_COG.csv

python COG_fisher_test.py COG_output/Photobacterium_chromosome_COG.csv COG_output/Photobacterium_chromid_COG.csv

python COG_fisher_test.py COG_output/Pseudoalteromonas_chromosome_COG.csv COG_output/Pseudoalteromonas_chromid_COG.csv
python COG_fisher_test.py COG_output/Pseudoalteromonas_chromosome_COG.csv COG_output/Pseudoalteromonas_megaplasmid_COG.csv
python COG_fisher_test.py COG_output/Pseudoalteromonas_chromid_COG.csv COG_output/Pseudoalteromonas_megaplasmid_COG.csv

python COG_fisher_test.py COG_output/Salinivibrio_chromosome_COG.csv COG_output/Salinivibrio_megaplasmid_COG.csv

python COG_fisher_test.py COG_output/Vibrio_chromosome_COG.csv COG_output/Vibrio_chromid_COG.csv
python COG_fisher_test.py COG_output/Vibrio_chromosome_COG.csv COG_output/Vibrio_megaplasmid_COG.csv
python COG_fisher_test.py COG_output/Vibrio_chromid_COG.csv COG_output/Vibrio_megaplasmid_COG.csv

#------------------------------------------------
# concatenating extrachromosomal replicons into single files for intragenus comparisons
# Pseudoalteromonas - chromid + megaplasmid
mkdir -p accessory_output/extrachromosomal/Pseudoalteromonas_genus
mkdir -p eggnog_mapping/extrachromosomal/Pseudoalteromonas_genus
cat accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
    accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
    > accessory_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt

cat eggnog_mapping/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
    | head -n -3 > \
    eggnog_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations

cat eggnog_mapping/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
    | tail -n +6 >> \
    eggnog_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations

#check
cat eggnog_mapping/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations | wc -l
# 7414
cat eggnog_mapping/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations | wc -l
# 1740
cat eggnog_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations | wc -l
# 9146

# Vibrio - chromid + megaplasmid
mkdir -p accessory_output/extrachromosomal/Vibrio_genus
mkdir -p eggnog_mapping/extrachromosomal/Vibrio_genus
cat accessory_output/chromid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
    accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
    > accessory_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt

cat eggnog_mapping/chromid/Vibrio_genus/Vibrio_genus.emapper.annotations \
    | head -n -3 > \
    eggnog_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus.emapper.annotations

cat eggnog_mapping/megaplasmid/Vibrio_genus/Vibrio_genus.emapper.annotations \
    | tail -n +6 >> \
    eggnog_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus.emapper.annotations

#check
cat eggnog_mapping/chromid/Vibrio_genus/Vibrio_genus.emapper.annotations | wc -l
# 23341
cat eggnog_mapping/megaplasmid/Vibrio_genus/Vibrio_genus.emapper.annotations | wc -l
# 1313
cat eggnog_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus.emapper.annotations | wc -l
# 24646

# calculating COGs for extrachromosomal replicons
python COG_calculations.py \
    accessory_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
    eggnog_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
    COG_output/Pseudoalteromonas_extrachromosomal_COG.csv

python COG_calculations.py \
    accessory_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
    eggnog_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus.emapper.annotations \
    COG_output/Vibrio_extrachromosomal_COG.csv

# calculating Fisher's exact test for chromosome vs extrachromosomal replicons
python COG_fisher_test.py \
    COG_output/Pseudoalteromonas_chromosome_COG.csv \
    COG_output/Pseudoalteromonas_extrachromosomal_COG.csv

python COG_fisher_test.py \
    COG_output/Vibrio_chromosome_COG.csv \
    COG_output/Vibrio_extrachromosomal_COG.csv

#-------------------------------------------------------------------------
#concatenating all chromosome and extrachromosomal genes lists and annotations into single files
# chromosome
mkdir -p accessory_output/chromosome/All_genus
mkdir -p eggnog_mapping/chromosome/All_genus

cat accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt \
    accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt \
    accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
    accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt \
    accessory_output/chromosome/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
    > accessory_output/chromosome/All_genus/All_genus_95_gene_list_represenative.txt

cat eggnog_mapping/chromosome/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations \
    | head -n -3 > \
    eggnog_mapping/chromosome/All_genus/All_genus.emapper.annotations
cat eggnog_mapping/chromosome/Photobacterium_genus/Photobacterium_genus.emapper.annotations \
    | tail -n +6 | head -n -3 >> \
    eggnog_mapping/chromosome/All_genus/All_genus.emapper.annotations
cat eggnog_mapping/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
    | tail -n +6 | head -n -3 >> \
    eggnog_mapping/chromosome/All_genus/All_genus.emapper.annotations
cat eggnog_mapping/chromosome/Salinivibrio_genus/Salinivibrio_genus.emapper.annotations \
    | tail -n +6 | head -n -3 >> \
    eggnog_mapping/chromosome/All_genus/All_genus.emapper.annotations
cat eggnog_mapping/chromosome/Vibrio_genus/Vibrio_genus.emapper.annotations \
    | tail -n +6 >> \
    eggnog_mapping/chromosome/All_genus/All_genus.emapper.annotations

# extrachromosomal
mkdir -p accessory_output/extrachromosomal/All_genus
mkdir -p eggnog_mapping/extrachromosomal/All_genus

cat accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt \
    accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt \
    accessory_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
    accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt \
    accessory_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
    > accessory_output/extrachromosomal/All_genus/All_genus_95_gene_list_represenative.txt

cat eggnog_mapping/chromid/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations \
    | head -n -3 > \
    eggnog_mapping/extrachromosomal/All_genus/All_genus.emapper.annotations
cat eggnog_mapping/chromid/Photobacterium_genus/Photobacterium_genus.emapper.annotations \
    | tail -n +6 | head -n -3 >> \
    eggnog_mapping/extrachromosomal/All_genus/All_genus.emapper.annotations
cat eggnog_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
    | tail -n +6 | head -n -3 >> \
    eggnog_mapping/extrachromosomal/All_genus/All_genus.emapper.annotations
cat eggnog_mapping/megaplasmid/Salinivibrio_genus/Salinivibrio_genus.emapper.annotations \
    | tail -n +6 | head -n -3 >> \
    eggnog_mapping/extrachromosomal/All_genus/All_genus.emapper.annotations
cat eggnog_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus.emapper.annotations \
    | tail -n +6 >> \
    eggnog_mapping/extrachromosomal/All_genus/All_genus.emapper.annotations

# calculating COG for all genera
python COG_calculations.py \
    accessory_output/chromosome/All_genus/All_genus_95_gene_list_represenative.txt \
    eggnog_mapping/chromosome/All_genus/All_genus.emapper.annotations \
    COG_output/All_chromosome_COG.csv

python COG_calculations.py \
    accessory_output/extrachromosomal/All_genus/All_genus_95_gene_list_represenative.txt \
    eggnog_mapping/extrachromosomal/All_genus/All_genus.emapper.annotations \
    COG_output/All_extrachromosomal_COG.csv

# calculating Fisher's exact test for all genera chromosome vs extrachromosomal replicons
python COG_fisher_test.py \
    COG_output/All_chromosome_COG.csv \
    COG_output/All_extrachromosomal_COG.csv