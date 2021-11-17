import json
from flatten_json import flatten
import pandas as pd

# gene_list_to_extract_path = sys.argv[1]
# eggnog_mapper_annotation_pan_genome_path = sys.argv[2]
# output_csv_path = sys.argv[3]
# json_path = sys.argv[4]

gene_list_to_extract_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt'
eggnog_annot_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/eggnog/eggnog_mapping/chromosome/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations'
output_csv_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/KO_calculations/Aliivibrio_chromosome_KO.csv'
json_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/KO_calculations/ko00001.json'


# funtion for getting keys list from values in dict
def get_key(val, my_dict):
    keys = []
    for key, value in my_dict.items():
        if val in value:
            keys.append(key)

    return keys


f = open(json_path)
ko_json = json.load(f)

# flattening kegg json structure - keys are json paths
flatten_json = flatten(ko_json)

# getting list of genes from part of pangenome
gene_list_to_extract_file = open(
    gene_list_to_extract_path,
    'r')
gene_list_to_extract = gene_list_to_extract_file.read().splitlines()

# adding dummy suffix made by emapper to match emapper results
gene_list_to_extract = [s + '_1' for s in gene_list_to_extract]

# parsing eggnog annotation
replicon_df = pd.read_csv(
    eggnog_annot_path,
    sep='\t',
    skiprows=[0, 1, 2, 3],
    skipfooter=3,
)

# splitting multiple ko assigments into seperate rows
replicon_df = replicon_df.assign(
    KEGG_ko=replicon_df['KEGG_ko'].str.split(',')).explode('KEGG_ko')

# getting rid of 'ko' prefix from KO numbers
replicon_df = replicon_df.assign(
    KEGG_ko=replicon_df['KEGG_ko'].str.split(':').str[1]
).fillna('')

# extracting list of unique KO numbers from df
ko_numbers_list = replicon_df['KEGG_ko'].dropna().unique().tolist()

# setting a mapping dictionary KO number - general KEGG categories number (highest hierachy)
ko_cat_numer_mapping = {}
for ko_number in ko_numbers_list:
    if ko_number:
        KO_path = get_key(ko_number, flatten_json)
        unique_cat_numbers = list(set([ele.split('_')[1] for ele in KO_path]))
        ko_cat_numer_mapping[ko_number] = unique_cat_numbers

# creating dataframe for KO number - general category mapping
ko_cat_number_map_df = pd.DataFrame(ko_cat_numer_mapping.items(), columns=['KEGG_ko', 'cat_number'])

# left join for KO number to gen categorie mapping
replicon_df_join = replicon_df.merge(
    ko_cat_number_map_df,
    left_on='KEGG_ko',
    right_on='KEGG_ko',
    how='left'
)

# splitting multi general categorie assigment into separate rows
replicon_df_join = replicon_df_join.explode('cat_number').fillna('')

# category mapping from original json
cat_num_name_mapper = {
    '0': 'Metabolism',
    '1': 'Genetic Information Processing',
    '2': 'Environmental Information Processing',
    '3': 'Cellular Processes',
    '4': 'Organismal Systems',
    '5': 'Human Diseases',
    '6': 'Brite Hierarchies',
    '7': 'Not Included in Pathway or Brite'
}

cat_number_cat_name_df = pd.DataFrame(cat_num_name_mapper.items(), columns=['cat_number', 'cat_name'])
replicon_df_ko_names = replicon_df_join.merge(
    cat_number_cat_name_df,
    left_on='cat_number',
    right_on='cat_number',
    how='left'
)

filtered_replicon_df = replicon_df_ko_names[replicon_df_ko_names['#query'].isin(gene_list_to_extract)]

# total number of unique queries in pd
total_number = filtered_replicon_df['#query'].nunique()

# formatting dataframe with counts from particular categories
KO_general_counts = filtered_replicon_df['cat_name'].value_counts().to_frame().reset_index().rename(columns={'index' : 'KO category', 'cat_name' : 'count'})

# calculating percent for each category
KO_general_counts = KO_general_counts.assign(
    percent=KO_general_counts['count'].divide(total_number / 100)
)

KO_general_counts = KO_general_counts.assign(
    total = total_number
)

# saving csv
KO_general_counts.to_csv(output_csv_path, index=False)

