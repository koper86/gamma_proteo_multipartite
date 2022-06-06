import os
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

pd.options.display.max_columns = None
pd.options.display.width = None

pangenome_v2_path = '/home/user/mount_cluster_205/media/umcs/edbfa4a4-ad51-4531-a25d-6022dbd3224c/gamma_multipartite/pangenome_input_v2/'

union_df = pd.DataFrame(index=None, columns=[
    'KO category', 'KO count', 'KO percent', 'Total number of proteins', 'Replicon type', 'Genus'])
for dirpath, dirnames, files in os.walk(pangenome_v2_path):
    for file in files:
        if 'calculated_KO' in file:
            replicon_df = pd.read_csv(os.path.join(dirpath, file), header=None, skiprows=[0])
            replicon_type = dirpath.split('/')[-2]
            genus_name = dirpath.split('/')[-1]
            replicon_df.columns = ['KO category', 'KO count', 'KO percent', 'Total number of proteins']
            replicon_df['Replicon type'] = replicon_type
            replicon_df['Genus'] = genus_name
            union_df = union_df.append(replicon_df)

union_df.loc[union_df['Genus'].isin(['All']), ['Genus']] = 'Al'
union_df.loc[union_df['Replicon type'].isin(['secondary_replicon_1']), ['Replicon type']] = 'secondary_replicon'
union_df.loc[union_df['Replicon type'].isin(['secondary_replicon_2']), ['Replicon type']] = 'secondary_replicon'

# deleting 0 rows for KO counts
union_df = union_df[union_df['KO count'] != 0]

# setting percent threshold to show
union_df = union_df[union_df['KO percent'] >= 1]

# sorting values according to KO category
union_df = union_df.sort_values(['KO category', 'Genus'])
union_df = union_df.sort_values(['Genus'])

g = sns.catplot(
    data=union_df[union_df['Replicon type'].isin(['chromosome', 'secondary_replicon'])],
    y="KO category",
    x="KO percent",
    kind="bar",
    hue="Replicon type",
    ci=None,
    aspect=3,
    height=4,
    col="Genus",
    col_wrap=3,
)
g.fig.suptitle("Comparison of KO abundance within chromosome and extrachromosomal replicons", y=1.05)
g.set_titles('$\it{col_name}$')
plt.xlim(0, 25)
plt.show()

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
