import os
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt

pd.options.display.max_columns = None
pd.options.display.width = None

subsystems_output_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/RAST_Subsystem_annotation/RAST_mapping'

union_df = pd.DataFrame(index=None, columns=[
    'Subsystems class', 'Subsystems count', 'Subsystems percent', 'Total', 'Replicon type', 'Genus'])
for dirpath, dirnames, files in os.walk(subsystems_output_path):
    for file in files:
        if 'subsystems_calc' in file:
            replicon_df = pd.read_csv(os.path.join(dirpath, file), header=None, skiprows=1)
            replicon_type = file.split('_')[2]
            genus_name = file.split('_')[0]
            replicon_df.columns = ['Subsystems class', 'Subsystems count', 'Subsystems percent', 'Total']
            replicon_df['Replicon type'] = replicon_type
            replicon_df['Genus'] = genus_name
            union_df = union_df.append(replicon_df)

g = sns.catplot(
    data=union_df[union_df['Replicon type'].isin(['chromosome', 'extrachromosomal'])],
    y="Subsystems class",
    x="Subsystems percent",
    kind="bar",
    hue="Replicon type",
    ci=None,
    aspect=3,
    height=4,
    col="Genus",
    col_wrap=3,
)
# g.fig.autofmt_xdate(rotation=45)
g.fig.suptitle("Comparison of Subsystem enrichment within chromosome and extrachromosomal replicons", y=1.05)
g.set_titles('$\it{col_name}$')
plt.xlim(0, 30)
plt.show()

# sns.catplot(
#     data=union_df[(union_df['replicon type'].isin(['chromosome', 'extrachromosomal']))
#                   &(union_df['genus'] == 'Vibrio')],
#     x="Subsystems class",
#     y="percent",
#     kind="bar",
#     hue="replicon type",
#     hue_order =['chromosome', 'extrachromosomal'],
#     ci=None,
#     aspect=3,
#     height=4,
# )
# plt.xticks(rotation=45, ha='right')
