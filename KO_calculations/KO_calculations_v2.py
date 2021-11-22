import sys
import pandas as pd

gene_list_to_extract_path = sys.argv[1]
eggnog_annot_path = sys.argv[2]
output_csv_path = sys.argv[3]
kegg_json_path = sys.argv[4]

# gene_list_to_extract_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_95_gene_list_represenative.txt'
# eggnog_annot_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/eggnog/eggnog_mapping/chromosome/Aliivibrio_genus/Aliivibrio_genus.emapper.annotations'
# output_csv_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/KO_calculations/Aliivibrio_chromosome_KO.csv'
# kegg_json_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/KO_calculations/ko00001.json'

# parsing and formatting kegg ko json to dataframe
database = list()
for _, v in pd.read_json(
        kegg_json_path).iterrows():
    d = v["children"]
    cat_1 = d["name"]
    for child_1 in d["children"]:
        cat_2 = child_1["name"]  # Module?
        for child_2 in child_1["children"]:
            cat_3 = child_2["name"]
            if "children" in child_2:
                for child_3 in child_2["children"]:
                    cat_4 = child_3["name"]
                    fields = [cat_1, cat_2, cat_3, cat_4]
                    database.append(fields)
df_kegg = pd.DataFrame(database, columns=["Level_A", "Level_B", "Level_C", "Level_D"])


def parse_ko_identifiers(x):
    x = x.upper()
    kos = list()
    elements = x.split(" ")
    for word in elements:
        if word:

            conditions = [
                word[0] == "K",
                word[1:].isnumeric(),
                len(word) == 6,
            ]
            if all(conditions):
                kos.append(word)
    return set(kos)


# adding column with sole KO numbers
df_kegg["Level_D-KOs"] = df_kegg["Level_D"].map(parse_ko_identifiers)

# expanding database for easier handling
database_expanded = dict()
for i, row in df_kegg.iterrows():
    for id_ko in row["Level_D-KOs"]:
        database_expanded[id_ko] = row
df_kegg_expanded = pd.DataFrame(database_expanded).T
df_kegg_expanded.index.name = "KO"
df_kegg_expanded.columns = df_kegg_expanded.columns.map(lambda x: (x.split("-")[0], x))

for id_cat in ["Level_A", "Level_B", "Level_C"]:
    df_kegg_expanded[(id_cat, "ID")] = df_kegg_expanded[(id_cat, id_cat)].map(lambda x: x.split(" ")[0])
    df_kegg_expanded[(id_cat, "Name")] = df_kegg_expanded[(id_cat, id_cat)].map(lambda x: " ".join(x.split(" ")[1:]))


def f(x):
    if "; " in x:
        return x.split("; ")[1]
    else:
        return x


df_kegg_expanded[("Level_D", "Name")] = df_kegg_expanded[("Level_D", "Level_D")].map(f)
df_kegg_expanded.columns = df_kegg_expanded.columns.map(lambda x: (x[0], "Full") if x[0] == x[1] else x)
# this is a final KEGG KO annotation table
df_kegg_expanded = df_kegg_expanded.sort_index(axis=1)

# getting list of genes from part of pangenome
gene_list_to_extract_file = open(
    gene_list_to_extract_path,
    'r')
gene_list_to_extract = gene_list_to_extract_file.read().splitlines()

# adding dummy suffix made by emapper to match emapper results
gene_list_to_extract = [s + '_1' for s in gene_list_to_extract]

# parsing eggnog annotation for pangenome
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

# filtering replicon pangenome with the gene list
filtered_replicon_df = replicon_df[replicon_df['#query'].isin(gene_list_to_extract)]

# left join with kegg annotation table by index
filtered_replicon_df = filtered_replicon_df.merge(
    df_kegg_expanded,
    left_on='KEGG_ko',
    right_index=True,
    how='left'
)

# total number of unique queries in pd
total_number = filtered_replicon_df['#query'].nunique()

# formatting dataframe with counts from particular categories
KO_general_counts = filtered_replicon_df.iloc[:, [26]].value_counts().to_frame().reset_index()

KO_general_counts = KO_general_counts.rename(columns={list(KO_general_counts)[0]: 'KO category',
                                                              list(KO_general_counts)[1]: 'count'})

KO_general_counts = KO_general_counts.assign(
    percent=KO_general_counts['count'].divide(total_number / 100)
)

KO_general_counts = KO_general_counts.assign(
    total = total_number
)

# saving csv
KO_general_counts.to_csv(output_csv_path, index=False)

