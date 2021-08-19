import sys
import string
import pandas as pd

try:
    gene_list_to_extract_path = sys.argv[1]
    eggnog_mapper_annotation_pan_genome_path = sys.argv[2]
    output_csv_path = sys.argv[3]
except:
    print('No folder or file name given')

# gene_list_to_extract_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt'
# eggnog_mapper_annotation_pan_genome_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/eggnog/eggnog_mapping/chromosome/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations'
# output_csv_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/COG_calculations/COG_output/Aliivibrio_chromosome_COG.csv'

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
    sep='\t', skiprows=[0, 1, 2, 3], skipfooter=3, usecols=[0, 6], engine='python')

# filtering dataframe by genes from percent pangenome
filtered_COG_mapping = COG_mapping[COG_mapping['#query'].isin(gene_list_to_extract)]

# splitting multi COG annotation into separate rows and proper naming columns
new_filtered_df = pd.DataFrame(filtered_COG_mapping['COG_category'].apply(list).tolist(),
                               index=filtered_COG_mapping['#query']).stack()
new_filtered_df = new_filtered_df.reset_index([0, '#query'])
new_filtered_df.columns = ['query', 'COG_category']

# getting total number of proteins and COG counts
total_number = new_filtered_df['query'].nunique()
COG_counts = new_filtered_df['COG_category'].value_counts()

# adding missing COG categories with 0
all_COG_categories = list(string.ascii_uppercase)
missing_COG = list(set(all_COG_categories) - set(COG_counts.index))

for categ in missing_COG:
    COG_counts = COG_counts.append(pd.Series([0], index=[categ]))

# calculating COG percents
COG_percent = COG_counts.divide(total_number / 100)

# sorting and concatenating both Series for given replicon
replicon_COG_values = pd.concat([COG_counts, COG_percent], axis=1).reset_index()
replicon_COG_values.columns = ['COG_category', 'count', 'percent']
replicon_COG_values = replicon_COG_values.sort_values('COG_category')

# adding column with total genes at the end of dataframe
replicon_COG_values['total'] = total_number

#  saving file according to declared output path
replicon_COG_values.to_csv(output_csv_path, header=False, index=False)
