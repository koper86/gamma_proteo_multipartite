import sys
import os
from Bio import SeqIO
from BCBio import GFF
import pandas as pd

pd.options.display.max_columns = None
pd.options.display.width = None

# parsing mutipartite_vibrio_pseudo.xls as data frame
# xl_file = pd.read_excel('mutipartite_vibrio_pseudo.xls', sheet_name='Foglio1')
xl_file = pd.read_excel('/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/mutipartite_vibrio_pseudo.xls', sheet_name='Foglio1')

# changing all numerical types to float, and object into string
xl_file['Organism name'] = xl_file['Organism name'].astype('string')
xl_file['Genome length'] = xl_file['Genome length'].astype('float64')
xl_file['Chromosome length'] = xl_file['Chromosome length'].astype('float64')

# parsing prokka output
try:
    # prokka_results_dir = sys.argv[1]
    prokka_results_dir = '/home/user/PycharmProjects/gamma_proteo_multipartite/prokka_annotation/prokka_results'
except:
    print('No directory name passed')

for dirpath, dirnames, files in os.walk(prokka_results_dir):
    for filename in files:
        if filename.endswith(".fna"):
            noext_name = os.path.splitext(filename)[0]
            if noext_name in xl_file['Organism name'].values:
                replicons_data = xl_file[xl_file['Organism name'] == noext_name].iloc[0]
                replicon_name_acc = {}
                for rec in SeqIO.parse(open(os.path.join(dirpath, filename)), 'fasta'):
                    replicon_name = replicons_data[replicons_data == len(rec)]
                    print(replicon_name)

                    replicon_name_acc[rec.id] = len(rec)










