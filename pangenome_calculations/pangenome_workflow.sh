# all the analysis were conducted using conda env 'bioinfo'. .yml env file is present

# running split_and_extract_gff.py script for prokka annotatad genomes to get separate replicon files
nohup python split_and_extract_gff.py prokka_results/ ./mutipartite_vibrio_pseudo.xls split_gff.log &

# move chromosome, chromid, megaplasmid gff files to separate folders
mkdir chromosome_gff
mkdir chromid_gff
mkdir megaplasmid_gff

find . -type f -iname '*chromosome*.gff' -exec cp {} pangenome_calculations/chromosome_gff/ \;
find . -type f -iname '*chromid*.gff' -exec cp {} pangenome_calculations/chromid_gff/ \;
find . -type f -iname '*megaplasmid*.gff' -exec cp {} pangenome_calculations/megaplasmid_gff/ \;

# species level pangenomes for entire genomes
roary

# genus level pangenomes for the entire genomes

#pangenomy dla replikonów liczone są na poziomie gatunku w pracy diCenzo!!

# chromosome level pangenome (all genomes)
roary -e -n -i 90 -g 100000 -f pangenome_calculations/chromosome_result pangenome_calculations/chromosome_gff/*.gff

# chromid pangenome (all genomes)


# megaplasmid pangenome (all genomes)


# second megaplasmid pangenome

