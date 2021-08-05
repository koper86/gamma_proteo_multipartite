# all the analysis were conducted using conda env 'bioinfo'. .yml env file is present

# running split_and_extract_gff.py script for prokka annotatad genomes to get separate replicon files
nohup python split_and_extract_gff.py prokka_results/ ././mutipartite_vibrio_pseudo.xls split_gff.log &
