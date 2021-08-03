import subprocess as sub
import os
from Bio import SeqIO
import pandas as pd

pd.options.display.max_columns = None
pd.options.display.width = None

# parsing mutipartite_vibrio_pseudo.xls as data frame
# xl_file = pd.read_excel('mutipartite_vibrio_pseudo.xls', sheet_name='Foglio1')
xl_file = pd.read_excel(
    '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/mutipartite_vibrio_pseudo.xls',
    sheet_name='Foglio1')

# renaming columns to meet criteria
xl_file = xl_file.rename(columns={
    'Organism name': 'org_name',
    'Genome length': 'genome_len',
    'Chromosome length': 'chromosome_len',
    'Chromid length': 'chromid_len',
    'Megaplasmid length': 'megaplasmid_len',
    'secundary Megaplasmid length': 'sec_megaplasmid_len'
})

# changing all numerical types to float, and object into string
xl_file['org_name'] = xl_file['org_name'].astype('string')
xl_file['genome_len'] = xl_file['genome_len'].astype('float64')
xl_file['chromosome_len'] = xl_file['chromosome_len'].astype('float64')

# parsing prokka output
try:
    # prokka_results_dir = sys.argv[1]
    prokka_results_dir = '/home/user/PycharmProjects/gamma_proteo_multipartite/prokka_annotation/prokka_results'
except:
    print('No directory name passed')

# adding columns for accession strings
xl_file['chromosome_acc'] = ''
xl_file['chromid_acc'] = ''
xl_file['megaplasmid_acc'] = ''
xl_file['sec_megaplasmid_acc'] = ''


def add_accession_to_replicon_type(prokka_results_dir):
    replicon_len_acc_mapper = {
        'chromosome_len': 'chromosome_acc',
        'chromid_len': 'chromid_acc',
        'megaplasmid_len': 'megaplasmid_acc',
        'sec_megaplasmid_len': 'sec_megaplasmid_acc'
    }
    for dirpath, dirnames, files in os.walk(prokka_results_dir):
        for filename in files:
            if filename.endswith(".fna"):
                noext_name = os.path.splitext(filename)[0]
                if noext_name in xl_file['org_name'].values:
                    strain_replicons_data = xl_file[xl_file['org_name'] == noext_name].iloc[0]
                    in_handle = open(os.path.join(dirpath, filename))
                    for rec in SeqIO.parse(in_handle, 'fasta'):
                        rec_present = strain_replicons_data == len(rec)
                        if rec_present.any():
                            replicon_len_ind = list(strain_replicons_data[rec_present].to_dict().keys())[0]
                            replicon_acc = rec.id
                            replicon_acc_ind = replicon_len_acc_mapper[replicon_len_ind]
                            org_ind = xl_file.index[xl_file['org_name'] == noext_name]
                            xl_file.at[org_ind, replicon_acc_ind] = replicon_acc
                    in_handle.close()

    return xl_file


def split_gff_by_replicon_type(prokka_results_dir):
    for dirpath, dirnames, files in os.walk(prokka_results_dir):
        for filename in files:
            if filename.endswith(".gff"):
                noext_name = os.path.splitext(filename)[0]
                if noext_name in xl_file['org_name'].values:
                    gff_in_file = os.path.join(dirpath, filename)
                    for replicon_type, acc in xl_file.loc[xl_file['org_name'] == noext_name].iloc[0].iloc[6:].items():
                        if acc:
                            gff_out_file = os.path.join(dirpath, noext_name) + '_' + replicon_type + '.gff'
                            subprocess_command = 'grep ^' + acc + ' ' + gff_in_file + '>' + gff_out_file
                            p1 = sub.Popen(subprocess_command, shell=True)
                            os.waitpid(p1.pid, 0)

                            fasta_in_file = os.path.join(dirpath, noext_name) + '.fna'
                            for rec in SeqIO.parse(fasta_in_file, 'fasta'):
                                fasta_out_file = os.path.join(dirpath, noext_name) + '_' + acc + '.fna'
                                if rec.id == acc:
                                    SeqIO.write(rec, fasta_out_file, 'fasta')
                                    concat_command = 'cat ' + fasta_out_file + '>> ' + gff_out_file
                                    p2 = sub.Popen(concat_command, shell=True)
                                    os.waitpid(p2.pid, 0)


xl_file = add_accession_to_replicon_type(prokka_results_dir)

split_gff_by_replicon_type(prokka_results_dir)
