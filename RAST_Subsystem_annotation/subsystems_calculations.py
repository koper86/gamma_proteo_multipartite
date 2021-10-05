import sys
import os
import pandas as pd

subsystems_annotation_pan_genome_path = sys.argv[1]
# subsystems_annotation_pan_genome_path = '/home/user/PycharmProjects/gamma_proteo_multipartite/RAST_Subsystem_annotation/RAST_mapping/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_extrachromosomal_95_pan_genome_subsystems.csv'


subsystem_mapping_pd = pd.read_csv(
    subsystems_annotation_pan_genome_path, engine='python')

total_number = subsystem_mapping_pd.shape[0]
subsystems_counts = subsystem_mapping_pd['Class'].value_counts()

subsystems_percent = subsystems_counts.divide(total_number / 100)

replicon_subsystems_pd = pd.concat([subsystems_counts, subsystems_percent], axis=1).reset_index()
replicon_subsystems_pd.columns = ['Subsystems class', 'count', 'percent']

replicon_subsystems_pd = replicon_subsystems_pd.sort_values('Subsystems class')

replicon_subsystems_pd['total'] = total_number

output_csv_path = os.path.splitext(subsystems_annotation_pan_genome_path)[0] + '_calc.csv'
replicon_subsystems_pd.to_csv(output_csv_path, index=False)

