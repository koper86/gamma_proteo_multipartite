import sys
import os
import pandas as pd
import csv
import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

pd.options.display.max_columns = None
pd.options.display.width = None

try:
    roary_output_dir = sys.argv[1]
except:
    print('No directory name passed')

roary_output_dir = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/pangenome_output'


def splitall(path):
    allparts = []
    while 1:
        parts = os.path.split(path)
        if parts[0] == path:
            allparts.insert(0, parts[0])
            break
        elif parts[1] == path:
            allparts.insert(0, parts[1])
            break
        else:
            path = parts[0]
            allparts.insert(0, parts[1])
    return allparts


summary_statistics_df = pd.DataFrame(columns=
                                     ['Genus', 'Identity Treshold', 'Core genes', 'Soft core genes', 'Shell genes',
                                      'Cloud genes', 'Total genes'])

for dirpath, dirnames, files in os.walk(roary_output_dir):
    splitted_path = splitall(dirpath)
    replicon_calculations_type = splitted_path[-2]
    genus_species_name = splitted_path[-1]
    if 'genus' in genus_species_name:
        genus_name = genus_species_name.split('_')[-3]
        iden_tresh = genus_species_name.split('_')[-1]
        with open(os.path.join(dirpath, 'summary_statistics.txt')) as csv_file:
            csv_reader = csv.reader(csv_file, delimiter='\t')
            genes_numbers = []
            for row in csv_reader:
                genes_numbers.append(row[2])
            print(genes_numbers)
            summary_statistics_df = summary_statistics_df.append({
                'Genus': genus_name,
                'Identity Treshold': iden_tresh,
                'Core genes': genes_numbers[0],
                'Soft core genes': genes_numbers[1],
                'Shell genes': genes_numbers[2],
                'Cloud genes': genes_numbers[3],
                'Total genes': genes_numbers[4],
            }, ignore_index=True)



summary_statistics_df[
    ['Identity Treshold', 'Core genes', 'Soft core genes', 'Shell genes', 'Cloud genes', 'Total genes']] = \
    summary_statistics_df[
        ['Identity Treshold', 'Core genes', 'Soft core genes', 'Shell genes', 'Cloud genes', 'Total genes']].apply(
        pd.to_numeric)
summary_statistics_df.sort_values(by=['Identity Treshold'], inplace=True)

print(summary_statistics_df.info())

sns.catplot(data=summary_statistics_df, x='Identity Treshold', y='Core genes', hue='Genus')
sns.catplot(data=summary_statistics_df, x='Identity Treshold', y='Total genes', hue='Genus')
