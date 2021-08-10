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




