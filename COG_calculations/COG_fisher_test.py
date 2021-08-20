import pandas as pd
import sys
import os
import scipy.stats as stats

pd.options.display.max_columns = None
pd.options.display.width = None

try:
    replicon_1_COG_file = sys.argv[1]
    replicon_2_COG_file = sys.argv[2]
except:
    print('No folders or files names provided')

# replicon_1_COG_file = '/home/user/PycharmProjects/gamma_proteo_multipartite/COG_calculations/COG_output/Aliivibrio_chromosome_COG.csv'
# replicon_2_COG_file = '/home/user/PycharmProjects/gamma_proteo_multipartite/COG_calculations/COG_output/Aliivibrio_chromid_COG.csv'

# parsing relevant COG counts files for replicons to compare
replicon_1_df = pd.read_csv(replicon_1_COG_file, header=None)
replicon_2_df = pd.read_csv(replicon_2_COG_file, header=None)

# getting the right column names
replicon_1_df.columns = ['COG_category', 'replicon_1_COG_count', 'replicon_1_COG_percent',
                         'replicon_1_total']
replicon_2_df.columns = ['COG_category', 'replicon_2_COG_count', 'replicon_2_COG_percent',
                         'replicon_2_total']

# merging both dataframes on COG categories
replicon_1_2_df = pd.merge(replicon_1_df, replicon_2_df, on='COG_category')

# calculating Fishers exact test unadjusted p_value
replicon_1_2_df['Fischers_exact_p_value'] = replicon_1_2_df.apply(
    lambda r: stats.fisher_exact([[r['replicon_1_COG_count'], r['replicon_2_COG_count']], [r['replicon_1_total'], r['replicon_2_total']]])[1],
    axis=1
)

# calculating adjusted p_value
replicon_1_2_df['Fischers_exact_adjusted_p_value'] = replicon_1_2_df['Fischers_exact_p_value'].multiply(26)

# getting strings for output filename
genus_name, replicon_1_name = os.path.basename(replicon_1_COG_file).split('_')[0:2]
replicon_2_name = os.path.basename(replicon_2_COG_file).split('_')[1]

# outputing csv with calculations
output_csv_path = os.path.join(os.path.dirname(replicon_1_COG_file), f'{genus_name}_{replicon_1_name}_vs_{replicon_2_name}.csv')
replicon_1_2_df.to_csv(output_csv_path, index=False)
