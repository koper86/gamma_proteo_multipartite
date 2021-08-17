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
nohup python pangenome_calculations.py pangenome_input/ pangenome_output/ > pangenome_output.log &

#make backup for pangenome calc
cp -R pangenome_output/ pangenome_output_backup

# plotting core and total genes for genus level calculations
python pangenome_output_analysis.py

# getting list of genes present in 95 percent of strains (accessory genome)
query_pan_genome -a complement -c 95 -o accessory_output/chromosome/Photobacterium_genus_95.txt -g /media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_output/chromosome/Photobacterium_genus_70/clustered_proteins $DYSK/gamma_multipartite/pangenome_input/chromosome/Photobacterium_genus/*.gff

# extracting gene_list from accessory_output files
cat accessory_output/chromosome/Photobacterium_genus_95.txt | cut -d':' -f1 > Photobacterium_genus_95_gene_list.txt

# extracting sequences for accessory pangenome (95) based on gene_list from query_pan_genome and pan_genome_reference
python pangenome_gene_list_extraction.py pangenome_output/chromosome/Photobacterium_genus_70/pan_genome_reference.fa accessory_output/chromosome/Photobacterium_genus_95_gene_list.txt accessory_output/chromosome/Photobacterium_genus_95_accessory_pangenome.fa


