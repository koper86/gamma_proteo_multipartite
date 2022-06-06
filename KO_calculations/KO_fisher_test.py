import pandas as pd
import sys
import os
import scipy.stats as stats

replicon_1_KO_file = sys.argv[1]
replicon_2_KO_file = sys.argv[2]
output_csv_path = sys.argv[3]

# replicon_1_KO_file = '/home/user/PycharmProjects/gamma_proteo_multipartite/KO_calculations/Aliivibrio_chromosome_KO.csv'
# replicon_2_KO_file = '/home/user/PycharmProjects/gamma_proteo_multipartite/KO_calculations/Aliivibrio_chromid_KO.csv'

replicon_1_df = pd.read_csv(replicon_1_KO_file)
replicon_2_df = pd.read_csv(replicon_2_KO_file)

# merging on categories (left join)
replicon_1_2_df = pd.merge(replicon_1_df,
                           replicon_2_df,
                           on='KO category',
                           how='left')

replicon_1_2_df['total_x'] = replicon_1_2_df['total_x'].fillna(replicon_1_2_df['total_x']. value_counts(). index[0])
replicon_1_2_df['total_y'] = replicon_1_2_df['total_y'].fillna(replicon_1_2_df['total_y']. value_counts(). index[0])

replicon_1_2_df.fillna(0, inplace=True)

replicon_1_2_df['KO_percentage_change'] = replicon_1_2_df['percent_x'] - replicon_1_2_df[
    'percent_y']

replicon_1_2_df['Fischers_exact_p_value'] = replicon_1_2_df.apply(
    lambda r: stats.fisher_exact(
        [[r['count_x'], r['count_y']], [r['total_x'], r['total_y']]])[1],
    axis=1
)

# calculating adjusted p_value
replicon_1_2_df['Fischers_exact_adjusted_p_value'] = replicon_1_2_df['Fischers_exact_p_value'].multiply(26)

# getting strings for output filename
genus_name, replicon_1_name = os.path.basename(replicon_1_KO_file).split('_')[0:2]
replicon_2_name = os.path.basename(replicon_2_KO_file).split('_')[1]

# outputing csv with calculations
# output_csv_path = os.path.join(os.path.dirname(replicon_1_KO_file),
#                                f'{genus_name}_{replicon_1_name}_vs_{replicon_2_name}.csv')

replicon_1_2_df.to_csv(output_csv_path, index=False)