import sys
import string
import pandas as pd

gene_list_to_extract_path = sys.argv[1]
eggnog_mapper_annotation_pan_genome_path = sys.argv[2]
output_csv_path = sys.argv[3]

# gene_list_to_extract_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt'
# eggnog_mapper_annotation_pan_genome_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/eggnog/eggnog_mapping/chromosome/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations'
# output_csv_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/COG_diversity/COG_diversity_output/Aliivibrio_chromosome_COG_diversity.csv'

# parsing gene list from a valid percent of pangenome
gene_list_to_extract_file = open(
    gene_list_to_extract_path,
    'r')
gene_list_to_extract = gene_list_to_extract_file.read().splitlines()

# adding dummy suffix made by emapper to match emapper results
gene_list_to_extract = [s + '_1' for s in gene_list_to_extract]

# parsing emapper result as dataframe, only ID and COG
COG_mapping = pd.read_csv(
    eggnog_mapper_annotation_pan_genome_path,
    sep='\t', skiprows=[0, 1, 2, 3], skipfooter=3, engine='python')

# filtering dataframe by genes from percent pangenome
filtered_COG_mapping = COG_mapping[COG_mapping['#query'].isin(gene_list_to_extract)]

# getting total number of proteins and COG counts
total_number = filtered_COG_mapping['#query'].nunique()

# calculating COG diversity for parcicular COG categories
all_COG_category_df = pd.DataFrame(columns=['COG_category', 'unique_OGs'])

for COG_category in list(string.ascii_uppercase):
    COG_category_df = filtered_COG_mapping[filtered_COG_mapping['COG_category'].str.contains(COG_category)]
    nunique_OG_in_COG = COG_category_df['eggNOG_OGs'].nunique()
    all_COG_category_df = all_COG_category_df.append({'COG_category': COG_category, 'unique_OGs': nunique_OG_in_COG},
                                                     ignore_index=True)

all_COG_category_df['OGs_percent'] = all_COG_category_df['unique_OGs'].divide(total_number/100)
all_COG_category_df['total'] = total_number

all_COG_category_df.to_csv(output_csv_path, index=False)