import pandas as pd
import sys
import os
import scipy.stats as stats

pd.options.display.max_columns = None
pd.options.display.width = None

replicon_1_subsystems_file = sys.argv[1]
replicon_2_subsystems_file = sys.argv[2]

# replicon_1_subsystems_file = '/home/user/PycharmProjects/gamma_proteo_multipartite/RAST_Subsystem_annotation/Pseudoalteromonas_genus_chromosome_95_pan_genome_subsystems_calc.csv'
# replicon_2_subsystems_file = '/home/user/PycharmProjects/gamma_proteo_multipartite/RAST_Subsystem_annotation/Pseudoalteromonas_genus_chromid_95_pan_genome_subsystems_calc.csv'

replicon_1_df = pd.read_csv(replicon_1_subsystems_file)
replicon_2_df = pd.read_csv(replicon_2_subsystems_file)

replicon_1_df.columns = ['Subsystems_class', 'replicon_1_Ss_count', 'replicon_1_Ss_percent',
                         'replicon_1_total']
replicon_2_df.columns = ['Subsystems_class', 'replicon_2_Ss_count', 'replicon_2_Ss_percent',
                         'replicon_2_total']

replicon_1_2_df = pd.merge(replicon_1_df, replicon_2_df, on='Subsystems_class', how='outer', indicator=True)

replicon_1_2_df = replicon_1_2_df[[
    'Subsystems_class',
    'replicon_1_Ss_count',
    'replicon_1_Ss_percent',
    'replicon_1_total',
    'replicon_2_Ss_count',
    'replicon_2_Ss_percent',
    'replicon_2_total',
    '_merge'
]]
replicon_1_2_df['replicon_1_Ss_count'].fillna(0, inplace=True)
replicon_1_2_df['replicon_1_Ss_percent'].fillna(0, inplace=True)
replicon_1_2_df['replicon_2_Ss_count'].fillna(0, inplace=True)
replicon_1_2_df['replicon_2_Ss_percent'].fillna(0, inplace=True)

replicon_1_2_df['replicon_1_total'].fillna(
    replicon_1_2_df['replicon_1_total'].value_counts().index[0], inplace=True)

replicon_1_2_df['replicon_2_total'].fillna(
    replicon_1_2_df['replicon_2_total'].value_counts().index[0], inplace=True)

replicon_1_2_df['Ss_percentage_change'] = replicon_1_2_df['replicon_2_Ss_percent'] - replicon_1_2_df[
    'replicon_1_Ss_percent']

replicon_1_2_df['Fischers_exact_p_value'] = replicon_1_2_df.apply(
    lambda r: stats.fisher_exact(
        [[r['replicon_1_Ss_count'], r['replicon_2_Ss_count']], [r['replicon_1_total'], r['replicon_2_total']]])[1],
    axis=1
)

# calculating adjusted p_value
number_of_rows = len(replicon_1_2_df.index)
replicon_1_2_df['Fischers_exact_adjusted_p_value'] = replicon_1_2_df['Fischers_exact_p_value'].multiply(number_of_rows)

splitted_basename = os.path.basename(replicon_1_subsystems_file).split('_')
genus_name, replicon_1_name = [splitted_basename[i] for i in [0, 2]]

replicon_2_name = os.path.basename(replicon_2_subsystems_file).split('_')[2]

output_csv_path = os.path.join(os.path.dirname(replicon_1_subsystems_file),
                               f'{genus_name}_{replicon_1_name}_vs_{replicon_2_name}.csv')

replicon_1_2_df.to_csv(output_csv_path, index=False)
