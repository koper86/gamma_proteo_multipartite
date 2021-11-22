# calculating KO second level categories for given replicons
# chromosome
python KO_calculations_v2.py accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt \
                            eggnog_mapping/chromosome/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations \
                            KO_output/Aliivibrio_chromosome_KO.csv \
                            ko00001.json

python KO_calculations_v2.py accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/chromosome/Photobacterium_genus/Photobacterium_genus.emapper.annotations \
                             KO_output/Photobacterium_chromosome_KO.csv \
                             ko00001.json
python KO_calculations_v2.py accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
                             KO_output/Pseudoalteromonas_chromosome_KO.csv \
                             ko00001.json
python KO_calculations_v2.py accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/chromosome/Salinivibrio_genus/Salinivibrio_genus.emapper.annotations \
                             KO_output/Salinivibrio_chromosome_KO.csv \
                             ko00001.json
python KO_calculations_v2.py accessory_output/chromosome/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/chromosome/Vibrio_genus/Vibrio_genus.emapper.annotations \
                             KO_output/Vibrio_chromosome_KO.csv \
                             ko00001.json
                             
#chromid
python KO_calculations_v2.py accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt \
                            eggnog_mapping/chromid/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations \
                            KO_output/Aliivibrio_chromid_KO.csv \
                            ko00001.json
python KO_calculations_v2.py accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/chromid/Photobacterium_genus/Photobacterium_genus.emapper.annotations \
                             KO_output/Photobacterium_chromid_KO.csv \
                             ko00001.json
python KO_calculations_v2.py accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
                             KO_output/Pseudoalteromonas_chromid_KO.csv \
                             ko00001.json
python KO_calculations_v2.py accessory_output/chromid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/chromid/Vibrio_genus/Vibrio_genus.emapper.annotations \
                             KO_output/Vibrio_chromid_KO.csv \
                             ko00001.json
                             
#megaplasmid
python KO_calculations_v2.py accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
                             KO_output/Pseudoalteromonas_megaplasmid_KO.csv \
                             ko00001.json
                             
python KO_calculations_v2.py accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/megaplasmid/Salinivibrio_genus/Salinivibrio_genus.emapper.annotations \
                             KO_output/Salinivibrio_megaplasmid_KO.csv \
                             ko00001.json
                             
python KO_calculations_v2.py accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/megaplasmid/Vibrio_genus/Vibrio_genus.emapper.annotations \
                             KO_output/Vibrio_megaplasmid_KO.csv \
                             ko00001.json

# etrachromosomal
python KO_calculations_v2.py accessory_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
                             KO_output/Pseudoalteromonas_extrachromosomal_KO.csv \
                             ko00001.json
                             
python KO_calculations_v2.py accessory_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt \
                             eggnog_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus.emapper.annotations \
                             KO_output/Vibrio_extrachromosomal_KO.csv \
                             ko00001.json

#all genera
python KO_calculations_v2.py \
    accessory_output/chromosome/All_genus/All_genus_95_gene_list_represenative.txt \
    eggnog_mapping/chromosome/All_genus/All_genus.emapper.annotations \
    KO_output/All_chromosome_KO.csv \
    ko00001.json


python KO_calculations_v2.py \
    accessory_output/extrachromosomal/All_genus/All_genus_95_gene_list_represenative.txt \
    eggnog_mapping/extrachromosomal/All_genus/All_genus.emapper.annotations \
    KO_output/All_extrachromosomal_KO.csv \
    ko00001.json

#calculating Fishers exact test
# calculating Fisher Exact Test statistics (inner genus rreplicon comparisons)
python KO_fisher_test.py KO_output/Aliivibrio_chromosome_KO.csv KO_output/Aliivibrio_chromid_KO.csv

python KO_fisher_test.py KO_output/Photobacterium_chromosome_KO.csv KO_output/Photobacterium_chromid_KO.csv

python KO_fisher_test.py KO_output/Pseudoalteromonas_chromosome_KO.csv KO_output/Pseudoalteromonas_chromid_KO.csv
python KO_fisher_test.py KO_output/Pseudoalteromonas_chromosome_KO.csv KO_output/Pseudoalteromonas_megaplasmid_KO.csv
python KO_fisher_test.py KO_output/Pseudoalteromonas_chromid_KO.csv KO_output/Pseudoalteromonas_megaplasmid_KO.csv

python KO_fisher_test.py KO_output/Salinivibrio_chromosome_KO.csv KO_output/Salinivibrio_megaplasmid_KO.csv

python KO_fisher_test.py KO_output/Vibrio_chromosome_KO.csv KO_output/Vibrio_chromid_KO.csv
python KO_fisher_test.py KO_output/Vibrio_chromosome_KO.csv KO_output/Vibrio_megaplasmid_KO.csv
python KO_fisher_test.py KO_output/Vibrio_chromid_KO.csv KO_output/Vibrio_megaplasmid_KO.csv

#extrachromosomal
python KO_fisher_test.py \
    KO_output/Pseudoalteromonas_chromosome_KO.csv \
    KO_output/Pseudoalteromonas_extrachromosomal_KO.csv

python KO_fisher_test.py \
    KO_output/Vibrio_chromosome_KO.csv \
    KO_output/Vibrio_extrachromosomal_KO.csv
    
#All
python KO_fisher_test.py \
    KO_output/All_chromosome_KO.csv \
    KO_output/All_extrachromosomal_KO.csv