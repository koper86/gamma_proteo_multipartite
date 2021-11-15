import sys
import pandas as pd


gene_list_to_extract_path = sys.argv[1]
eggnog_mapper_annotation_pan_genome_path = sys.argv[2]
output_csv_path = sys.argv[3]

# gene_list_to_extract_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt'
# eggnog_mapper_annotation_pan_genome_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/eggnog/eggnog_mapping/chromosome/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations'
# output_csv_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/core_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_core.csv'

# parsing gene list from a valid percent of pangenome
gene_list_to_extract_file = open(
    gene_list_to_extract_path,
    'r')
gene_list_to_extract = gene_list_to_extract_file.read().splitlines()
# adding dummy suffix made by emapper to match emapper results
gene_list_to_extract = [s + '_1' for s in gene_list_to_extract]

# parsing emapper result as dataframe, only ID and COG
eggNOG_mapping = pd.read_csv(
    eggnog_mapper_annotation_pan_genome_path,
    sep='\t', skiprows=[0, 1, 2, 3], skipfooter=3)

filtered_eggNOG_mapping = eggNOG_mapping[eggNOG_mapping['#query'].isin(gene_list_to_extract)]
filtered_eggNOG_mapping.to_csv(output_csv_path, index=False)
