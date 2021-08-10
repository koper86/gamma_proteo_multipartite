import sys
import os
import shutil
import pandas as pd

pd.options.display.max_columns = None
pd.options.display.width = None

try:
    prokka_results_dir = sys.argv[1]
    xl_file_path = sys.argv[2]
    roary_input_dir = sys.argv[3]
except:
    print('No directory name passed')

# prokka_results_dir = '/home/user/PycharmProjects/gamma_proteo_multipartite/prokka_annotation/prokka_results'
# roary_input_dir = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/pangenome_input'

# parsing mutipartite_vibrio_pseudo.xls as data frame
xl_file = pd.read_excel(xl_file_path, sheet_name='Foglio1')
# xl_file = pd.read_excel(
#     '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/mutipartite_vibrio_pseudo.xls',
#     sheet_name='Foglio1')

# renaming columns to meet criteria
xl_file = xl_file.rename(columns={
    'Organism name': 'org_name',
})

# object into string
xl_file['org_name'] = xl_file['org_name'].astype('string')

organism_names = xl_file['org_name'].tolist()

# getting unique list of genus and species
unique_genus_names = list(set([i.split('_')[0] for i in organism_names]))
unique_species_names = list(set([i.split('_')[0] + '_' + i.split('_')[1] for i in organism_names]))

set_types = ['entire_genome', 'chromosome', 'chromid', 'megaplasmid']

# creating folder structure for roary input
for genus in unique_genus_names:
    for set_type in set_types:
        path = os.path.join(roary_input_dir, set_type, genus + '_genus')
        os.makedirs(path, exist_ok=True)

for species in unique_species_names:
    for set_type in set_types:
        path = os.path.join(roary_input_dir, set_type, species)
        os.makedirs(path, exist_ok=True)

# moving files according to genus, species, replicon_type for roary input
for dirpath, dirnames, files in os.walk(prokka_results_dir):
    for filename in files:
        filename_fullpath = os.path.join(dirpath, filename)
        filename_no_ext = os.path.splitext(filename)[0]
        if filename.endswith(".gff"):
            org_name_parts = filename_no_ext.split('_')
            replicon_name = org_name_parts[-2]
            genus = org_name_parts[0]
            species = org_name_parts[0] + '_' + org_name_parts[1]
            if replicon_name in set_types:
                genus_dst_path = os.path.join(roary_input_dir, replicon_name, genus + '_genus')
                if os.path.exists(genus_dst_path):
                    shutil.copy(filename_fullpath, genus_dst_path)
                species_dst_path = os.path.join(roary_input_dir, replicon_name, species)
                if os.path.exists(genus_dst_path):
                    shutil.copy(filename_fullpath, species_dst_path)
            else:
                ent_genome_genus_dst_path = os.path.join(roary_input_dir, 'entire_genome', genus + '_genus')
                if os.path.exists(ent_genome_genus_dst_path) and filename_no_ext in xl_file['org_name'].values:
                    shutil.copy(filename_fullpath, ent_genome_genus_dst_path)
                ent_genome_species_dst_path = os.path.join(roary_input_dir, 'entire_genome', species)
                if os.path.exists(ent_genome_species_dst_path) and filename_no_ext in xl_file['org_name'].values:
                    shutil.copy(filename_fullpath, ent_genome_species_dst_path)

