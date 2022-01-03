# all the analysis were conducted using conda env 'bioinfo'. .yml env file is present

# make backup of prokka results
cp -R prokka_results/ prokka_results_backup

# running split_and_extract_gff.py script for prokka annotatad genomes to get separate replicon files
python split_and_extract_gff.py prokka_results/ ./mutipartite_vibrio_pseudo.xls

# move chromosome, chromid, megaplasmid gff files to separate folders
mkdir chromosome_gff
mkdir chromid_gff
mkdir megaplasmid_gff

find . -type f -iname '*chromosome*.gff' -exec cp {} chromosome_gff/ \;
find . -type f -iname '*chromid*.gff' -exec cp {} chromid_gff/ \;
find . -type f -iname '*megaplasmid*.gff' -exec cp {} megaplasmid_gff/ \;

# checking number of files in every category:
# should be 141
ls chromosome_gff | wc -l

# should be 122
ls chromid_gff | wc -l

# should be 23
ls megaplasmid_gff | wc -l

# move entire genome and replicon specific gff files to corresponding dirs in pangenome_input
python pangenome_input_preparation.py prokka_results/ "multipartite_vibrio_pseudo.xls" pangenome_input/

# according to talk with G diCenzo, species level pangenomes should be calc with
# a range of tresholds (90, 80..40) and plotted (core genes and and num of total genes as a function of threshold)
#for the species level stick with 95 percent.
nohup python pangenome_calculations.py pangenome_input/ pangenome_output/ >pangenome_output.log &

#make backup for pangenome calc
cp -R pangenome_output/ pangenome_output_backup

# plotting core and total genes for genus level calculations
python pangenome_output_analysis.py

#ACCESSORY
# getting list of genes present in 95 percent of strains (accessory genome) from roary set at -i 60
#chromosome
query_pan_genome -a complement -c 95 -o accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromosome/Aliivibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromosome/Aliivibrio_genus/*.gff
query_pan_genome -a complement -c 95 -o accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromosome/Photobacterium_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromosome/Photobacterium_genus/*.gff
query_pan_genome -a complement -c 95 -o accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromosome/Pseudoalteromonas_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromosome/Pseudoalteromonas_genus/*.gff
query_pan_genome -a complement -c 95 -o accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromosome/Salinivibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromosome/Salinivibrio_genus/*.gff
query_pan_genome -a complement -c 95 -o accessory_output/chromosome/Vibrio_genus/Vibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromosome/Vibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromosome/Vibrio_genus/*.gff

# chromid
query_pan_genome -a complement -c 95 -o accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromid/Aliivibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromid/Aliivibrio_genus/*.gff
query_pan_genome -a complement -c 95 -o accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromid/Photobacterium_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromid/Photobacterium_genus/*.gff
query_pan_genome -a complement -c 95 -o accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromid/Pseudoalteromonas_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromid/Pseudoalteromonas_genus/*.gff
query_pan_genome -a complement -c 95 -o accessory_output/chromid/Vibrio_genus/Vibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromid/Vibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromid/Vibrio_genus/*.gff

# megaplasmid
query_pan_genome -a complement -c 95 -o accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/megaplasmid/Pseudoalteromonas_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/megaplasmid/Pseudoalteromonas_genus/*.gff
query_pan_genome -a complement -c 95 -o accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/megaplasmid/Salinivibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/megaplasmid/Salinivibrio_genus/*.gff
query_pan_genome -a complement -c 95 -o accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/megaplasmid/Vibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/megaplasmid/Vibrio_genus/*.gff


# extracting gene_list from accessory_output files
# chromosome
cat accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95.txt | cut -d':' -f1 > accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list.txt
cat accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_95.txt | cut -d':' -f1 > accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_gene_list.txt
cat accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f1 > accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list.txt
cat accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95.txt | cut -d':' -f1 > accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_gene_list.txt
cat accessory_output/chromosome/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f1 > accessory_output/chromosome/Vibrio_genus/Vibrio_genus_95_gene_list.txt

# chromid
cat accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95.txt | cut -d':' -f1 > accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_gene_list.txt
cat accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_95.txt | cut -d':' -f1 > accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_95_gene_list.txt
cat accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f1 > accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list.txt
cat accessory_output/chromid/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f1 > accessory_output/chromid/Vibrio_genus/Vibrio_genus_95_gene_list.txt

# megaplasmid
cat accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f1 > accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list.txt
cat accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95.txt | cut -d':' -f1 > accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_gene_list.txt
cat accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f1 > accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_gene_list.txt

# extracting representative CDS names from accessory_output files for COG extraction
# chromosome
cat accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt
cat accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt
cat accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt
cat accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt
cat accessory_output/chromosome/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/chromosome/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt

# chromid
cat accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt
cat accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt
cat accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt
cat accessory_output/chromid/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/chromid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt

# megaplasmid
cat accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt
cat accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt
cat accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt

#--------------------------------------------------------------------------------------------------------------------------------------------
#CORE
#List of the genes included in the core pangenomes of the chromids
# (or in general of the secondary replicons) for each genus.
#chromosome
query_pan_genome -a intersection -c 95 -o core_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromosome/Aliivibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromosome/Aliivibrio_genus/*.gff
query_pan_genome -a intersection -c 95 -o core_output/chromosome/Photobacterium_genus/Photobacterium_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromosome/Photobacterium_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromosome/Photobacterium_genus/*.gff
query_pan_genome -a intersection -c 95 -o core_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromosome/Pseudoalteromonas_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromosome/Pseudoalteromonas_genus/*.gff
query_pan_genome -a intersection -c 95 -o core_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromosome/Salinivibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromosome/Salinivibrio_genus/*.gff
query_pan_genome -a intersection -c 95 -o core_output/chromosome/Vibrio_genus/Vibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromosome/Vibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromosome/Vibrio_genus/*.gff

# chromid
query_pan_genome -a intersection -c 95 -o core_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromid/Aliivibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromid/Aliivibrio_genus/*.gff
query_pan_genome -a intersection -c 95 -o core_output/chromid/Photobacterium_genus/Photobacterium_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromid/Photobacterium_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromid/Photobacterium_genus/*.gff
query_pan_genome -a intersection -c 95 -o core_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromid/Pseudoalteromonas_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromid/Pseudoalteromonas_genus/*.gff
query_pan_genome -a intersection -c 95 -o core_output/chromid/Vibrio_genus/Vibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromid/Vibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromid/Vibrio_genus/*.gff

# megaplasmid
query_pan_genome -a intersection -c 95 -o core_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/megaplasmid/Pseudoalteromonas_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/megaplasmid/Pseudoalteromonas_genus/*.gff
query_pan_genome -a intersection -c 95 -o core_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/megaplasmid/Salinivibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/megaplasmid/Salinivibrio_genus/*.gff
query_pan_genome -a intersection -c 95 -o core_output/megaplasmid/Vibrio_genus/Vibrio_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/megaplasmid/Vibrio_genus_60/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/megaplasmid/Vibrio_genus/*.gff

# extracting gene_list from core_output files
# chromosome
cat core_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95.txt | cut -d':' -f1 > core_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list.txt
cat core_output/chromosome/Photobacterium_genus/Photobacterium_genus_95.txt | cut -d':' -f1 > core_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_gene_list.txt
cat core_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f1 > core_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list.txt
cat core_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95.txt | cut -d':' -f1 > core_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_gene_list.txt
cat core_output/chromosome/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f1 > core_output/chromosome/Vibrio_genus/Vibrio_genus_95_gene_list.txt

# chromid
cat core_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95.txt | cut -d':' -f1 > core_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_gene_list.txt
cat core_output/chromid/Photobacterium_genus/Photobacterium_genus_95.txt | cut -d':' -f1 > core_output/chromid/Photobacterium_genus/Photobacterium_genus_95_gene_list.txt
cat core_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f1 > core_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list.txt
cat core_output/chromid/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f1 > core_output/chromid/Vibrio_genus/Vibrio_genus_95_gene_list.txt

# megaplasmid
cat core_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f1 > core_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list.txt
cat core_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95.txt | cut -d':' -f1 > core_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_gene_list.txt
cat core_output/megaplasmid/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f1 > core_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_gene_list.txt

# extracting representative CDS names from core_output files for COG extraction
# chromosome
cat core_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt
cat core_output/chromosome/Photobacterium_genus/Photobacterium_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt
cat core_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt
cat core_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt
cat core_output/chromosome/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/chromosome/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt

# chromid
cat core_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt
cat core_output/chromid/Photobacterium_genus/Photobacterium_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/chromid/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt
cat core_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt
cat core_output/chromid/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/chromid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt

# megaplasmid
cat core_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt
cat core_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt
cat core_output/megaplasmid/Vibrio_genus/Vibrio_genus_95.txt | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > core_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt

# extracting eggNOG mapping
#chromosome
python eggnog_annotation_extraction.py core_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/chromosome/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations \
          core_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_annotation.tsv
python eggnog_annotation_extraction.py core_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/chromosome/Photobacterium_genus/Photobacterium_genus.emapper.annotations \
          core_output/chromosome/Photobacterium_genus/Photobacterium_genus_95_gene_annotation.tsv
python eggnog_annotation_extraction.py core_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
          core_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_annotation.tsv
python eggnog_annotation_extraction.py core_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/chromosome/Salinivibrio_genus/Salinivibrio_genus.emapper.annotations \
          core_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_95_gene_annotation.tsv
python eggnog_annotation_extraction.py core_output/chromosome/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/chromosome/Vibrio_genus/Vibrio_genus.emapper.annotations \
          core_output/chromosome/Vibrio_genus/Vibrio_genus_95_gene_annotation.tsv

#chromid
python eggnog_annotation_extraction.py core_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/chromid/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations \
          core_output/chromid/Aliivibrio_genus/Aliivibrio_genus_95_gene_annotation.tsv
python eggnog_annotation_extraction.py core_output/chromid/Photobacterium_genus/Photobacterium_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/chromid/Photobacterium_genus/Photobacterium_genus.emapper.annotations \
          core_output/chromid/Photobacterium_genus/Photobacterium_genus_95_gene_annotation.tsv
python eggnog_annotation_extraction.py core_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
          core_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_annotation.tsv
python eggnog_annotation_extraction.py core_output/chromid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/chromid/Vibrio_genus/Vibrio_genus.emapper.annotations \
          core_output/chromid/Vibrio_genus/Vibrio_genus_95_gene_annotation.tsv

#megaplasmid
python eggnog_annotation_extraction.py core_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
          core_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_annotation.tsv
python eggnog_annotation_extraction.py core_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/megaplasmid/Salinivibrio_genus/Salinivibrio_genus.emapper.annotations \
          core_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_95_gene_annotation.tsv
python eggnog_annotation_extraction.py core_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt  \
          eggnog_mapping/megaplasmid/Vibrio_genus/Vibrio_genus.emapper.annotations \
          core_output/megaplasmid/Vibrio_genus/Vibrio_genus_95_gene_annotation.tsv

#------------------------------------------------------------------------------------------
# CORE EXTRACHROMOSOMAL TOGETHER
# For Aliivibrio genus it will be the same as chromid core (no megaplasmids found)
# For Photobacterium genus it will be the same as chromid core (no megaplasmids found)
# For Salinivibrio genus it will be the same as megaplasmids core (no chromids found)

# For Pseudoalteromonas and Vibrio there is a need to recalculate pangenome for extrachromosomal replicons
# (concatenating input before pangenome calculations). I am doing it with -i 60 - because all others were also made that way

mkdir pangenome_input/extrachromosomal
mkdir pangenome_input/extrachromosomal/Pseudoalteromonas_genus
mkdir pangenome_input/extrachromosomal/Vibrio_genus

cp pangenome_input/chromid/Pseudoalteromonas_genus/*.gff pangenome_input/extrachromosomal/Pseudoalteromonas_genus
cp pangenome_input/megaplasmid/Pseudoalteromonas_genus/*.gff pangenome_input/extrachromosomal/Pseudoalteromonas_genus

cp pangenome_input/chromid/Vibrio_genus/*.gff pangenome_input/extrachromosomal/Vibrio_genus
cp pangenome_input/megaplasmid/Vibrio_genus/*.gff pangenome_input/extrachromosomal/Vibrio_genus

# check
ls pangenome_input/chromid/Pseudoalteromonas_genus/*.gff | wc -l
ls pangenome_input/megaplasmid/Pseudoalteromonas_genus/*.gff | wc -l
ls pangenome_input/extrachromosomal/Pseudoalteromonas_genus/*.gff | wc -l

ls pangenome_input/chromid/Vibrio_genus/*.gff | wc -l
ls pangenome_input/megaplasmid/Vibrio_genus/*.gff | wc -l
ls pangenome_input/extrachromosomal/Vibrio_genus/*.gff | wc -l


roary -e -n -i 60 \
      -g 100000 -p 12 -v \
      -f $DYSK/gamma_multipartite/pangenome_output/extrachromosomal/Pseudoalteromonas_genus_60/ \
      $DYSK/gamma_multipartite/pangenome_input/extrachromosomal/Pseudoalteromonas_genus/*.gff

roary -e -n -i 60 \
      -g 100000 -p 12 -v \
      -f $DYSK/gamma_multipartite/pangenome_output/extrachromosomal/Vibrio_genus_60/ \
      $DYSK/gamma_multipartite/pangenome_input/extrachromosomal/Vibrio_genus/*.gff

#querying core genomes
query_pan_genome -a intersection \
                 -c 95 \
                 -o $DYSK/gamma_multipartite/core_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt \
                 -g $DYSK/gamma_multipartite/pangenome_output/extrachromosomal/Pseudoalteromonas_genus_60/clustered_proteins \
                 $DYSK/gamma_multipartite/pangenome_input/extrachromosomal/Pseudoalteromonas_genus/*.gff

query_pan_genome -a intersection \
                 -c 95 \
                 -o $DYSK/gamma_multipartite/core_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95.txt \
                 -g $DYSK/gamma_multipartite/pangenome_output/extrachromosomal/Vibrio_genus_60/clustered_proteins \
                 $DYSK/gamma_multipartite/pangenome_input/extrachromosomal/Vibrio_genus/*.gff

# extracting gene_list from core_output files
cat $DYSK/gamma_multipartite/core_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt \
    | cut -d':' -f1 > $DYSK/gamma_multipartite/core_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list.txt

cat $DYSK/gamma_multipartite/core_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95.txt \
    | cut -d':' -f1 > $DYSK/gamma_multipartite/core_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95_gene_list.txt


# extracting representative CDS names from core_output files for annotation extraction
cat $DYSK/gamma_multipartite/core_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt \
    | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > $DYSK/gamma_multipartite/core_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt

cat $DYSK/gamma_multipartite/core_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95.txt \
    | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > $DYSK/gamma_multipartite/core_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt

# extracting eggNOG annotation for core genes
python eggnog_annotation_extraction.py \
          $DYSK/gamma_multipartite/core_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt  \
          $DYSK/gamma_multipartite/eggnog_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus.emapper.annotations \
          $DYSK/gamma_multipartite/core_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_annotation.tsv

python eggnog_annotation_extraction.py \
          $DYSK/gamma_multipartite/core_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt  \
          $DYSK/gamma_multipartite/eggnog_mapping/extrachromosomal/Vibrio_genus/Vibrio_genus.emapper.annotations \
          $DYSK/gamma_multipartite/core_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95_gene_annotation.tsv

# -------------------------------------------------------------------------------
# ACCESSORY EXTRACHROMOSOMAL TOGETHER

query_pan_genome -a complement \
                 -c 95 \
                 -o $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt \
                 -g $DYSK/gamma_multipartite/pangenome_output/extrachromosomal/Pseudoalteromonas_genus_60/clustered_proteins \
                 $DYSK/gamma_multipartite/pangenome_input/extrachromosomal/Pseudoalteromonas_genus/*.gff

query_pan_genome -a complement \
                 -c 95 \
                 -o $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95.txt \
                 -g $DYSK/gamma_multipartite/pangenome_output/extrachromosomal/Vibrio_genus_60/clustered_proteins \
                 $DYSK/gamma_multipartite/pangenome_input/extrachromosomal/Vibrio_genus/*.gff

# extracting gene_list from extrachromosomal accessory_output files
cat $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt \
    | cut -d':' -f1 > $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list.txt

cat $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95.txt \
    | cut -d':' -f1 > $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95_gene_list.txt

# extracting representative CDS names from accessory_output files for annotation extraction
cat $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95.txt \
    | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_95_gene_list_represenative.txt

cat $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95.txt \
    | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Vibrio_genus/Vibrio_genus_95_gene_list_represenative.txt


#--------------------------------------------------------------------------------------------------
# Calculating global pangenome for all chromosomes and all megaplasmids + chromids together (v3)

roary -e -n -i 60 \
      -g 100000 -p 12 -v \
      -f $DYSK/gamma_multipartite/pangenome_output/chromosome/All_genus_60/ \
      $DYSK/gamma_multipartite/pangenome_input/chromosome/All_genus/*.gff

nohup sh -c 'roary -e -n -i 60 -g 100000 -p 12 -v -f $DYSK/gamma_multipartite/pangenome_output/chromosome/All_genus_60/ $DYSK/gamma_multipartite/pangenome_input/chromosome/All_genus/*.gff' &

roary -e -n -i 60 \
      -g 100000 -p 12 -v \
      -f $DYSK/gamma_multipartite/pangenome_output/extrachromosomal/All_genus_60/ \
      $DYSK/gamma_multipartite/pangenome_input/extrachromosomal/All_genus/*.gff

nohup sh -c 'roary -e -n -i 60 -g 100000 -p 12 -v -f $DYSK/gamma_multipartite/pangenome_output/extrachromosomal/All_genus_60/ $DYSK/gamma_multipartite/pangenome_input/extrachromosomal/All_genus/*.gff' &

# querying accessory pangenome
query_pan_genome -a complement \
                 -c 95 \
                 -o $DYSK/gamma_multipartite/accessory_output/chromosome/All_genus/All_genus_95.txt \
                 -g $DYSK/gamma_multipartite/pangenome_output/chromosome/All_genus_60/clustered_proteins \
                 $DYSK/gamma_multipartite/pangenome_input/chromosome/All_genus/*.gff

query_pan_genome -a complement \
                 -c 95 \
                 -o $DYSK/gamma_multipartite/accessory_output/extrachromosomal/All_genus/All_genus_95.txt \
                 -g $DYSK/gamma_multipartite/pangenome_output/extrachromosomal/All_genus_60/clustered_proteins \
                 $DYSK/gamma_multipartite/pangenome_input/extrachromosomal/All_genus/*.gff
                 
# extracting gene_list accessory from all_genus pangenome (chromosome and extrachromosomal)
cat $DYSK/gamma_multipartite/accessory_output/chromosome/All_genus/All_genus_95.txt \
    | cut -d':' -f1 > $DYSK/gamma_multipartite/accessory_output/chromosome/All_genus/All_genus_95_gene_list.txt

cat $DYSK/gamma_multipartite/accessory_output/extrachromosomal/All_genus/All_genus_95.txt \
    | cut -d':' -f1 > $DYSK/gamma_multipartite/accessory_output/extrachromosomal/All_genus/All_genus_95_gene_list.txt
    
# extracting representative CDS names from accessory_output files for annotation extraction
cat $DYSK/gamma_multipartite/accessory_output/chromosome/All_genus/All_genus_95.txt \
    | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > $DYSK/gamma_multipartite/accessory_output/chromosome/All_genus/All_genus_95_gene_list_represenative.txt

cat $DYSK/gamma_multipartite/accessory_output/extrachromosomal/All_genus/All_genus_95.txt \
    | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > $DYSK/gamma_multipartite/accessory_output/extrachromosomal/All_genus/All_genus_95_gene_list_represenative.txt