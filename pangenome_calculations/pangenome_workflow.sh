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

## extracting sequences for accessory pangenome (95) based on gene_list from query_pan_genome and pan_genome_reference (not necessary)
#python pangenome_gene_list_extraction.py pangenome_output/chromosome/Photobacterium_genus_70/pan_genome_reference.fa accessory_output/chromosome/Photobacterium_genus_95_gene_list.txt accessory_output/chromosome/Photobacterium_genus/Photobacterium_95_accessory_nucl.fa
