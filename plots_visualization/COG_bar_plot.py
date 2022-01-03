import os
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

pd.options.display.max_columns = None
pd.options.display.width = None

# try:
#     COG_output_path = sys.argv[1]
# except:
#     print('No folders or files names provided')

COG_output_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/COG_calculations/COG_output'

union_df = pd.DataFrame(index=None, columns=[
    'COG category', 'COG count', 'COG percent', 'Total number of proteins', 'Replicon type', 'Genus'])
for dirpath, dirnames, files in os.walk(COG_output_path):
    for file in files:
        if 'COG' in file:
            replicon_df = pd.read_csv(os.path.join(dirpath, file), header=None)
            replicon_type = file.split('_')[1]
            genus_name = file.split('_')[0]
            replicon_df.columns = ['COG category', 'COG count', 'COG percent', 'Total number of proteins']
            replicon_df['Replicon type'] = replicon_type
            replicon_df['Genus'] = genus_name
            union_df = union_df.append(replicon_df)

union_df.loc[union_df['Genus'].isin(['All']), ['Genus']] = 'Al'

union_df = union_df.sort_values(['COG category', 'Genus'])
# deleting 0 rows for COG counts
union_df = union_df[union_df['COG count'] != 0]

# deleting non-assigned proteins count and Z, A, B, W categories with very low percentage
union_df = union_df[~union_df['COG category'].isin(['-'])]
union_df = union_df[union_df['COG percent'] >= 0.5]

g = sns.catplot(
    data=union_df[union_df['Replicon type'].isin(['chromosome', 'extrachromosomal'])],
    y="COG category",
    x="COG percent",
    kind="bar",
    hue="Replicon type",
    hue_order=['chromosome', 'extrachromosomal'],
    ci=None,
    aspect=3,
    height=4,
    col="Genus",
    col_wrap=3,
)
g.set_titles('$\it{col_name}$')
g.fig.suptitle("Comparison of COG enrichment within chromosome and extrachromosomal replicons", y=1.05)

# sns.catplot(
#     data=union_df[union_df['Replicon type'].isin(['chromosome', 'extrachromosomal'])],
#     x="COG category",
#     y="COG percent",
#     kind="bar",
#     hue="Replicon type",
#     hue_order =['chromosome', 'extrachromosomal'],
#     ci=None,
#     aspect=3,
#     height=4,
# )
