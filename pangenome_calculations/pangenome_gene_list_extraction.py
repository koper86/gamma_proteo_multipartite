import os
import sys
from Bio import SeqIO

try:
    input_fasta_file = sys.argv[1]
    gene_list_to_extract_path = sys.argv[2]
    output_fasta_file = sys.argv[3]
except:
    print('No directory name passed')
# input_fasta_file
# output_fasta_file = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/accessory_output/chromosome/Photobacterium_genus_95_accessory_pangenome.fa'

pan_genome_reference_fasta_file = SeqIO.parse(
    input_fasta_file,
    'fasta')
gene_list_to_extract_file = open(
    gene_list_to_extract_path,
    'r')
gene_list_to_extract = gene_list_to_extract_file.read().splitlines()
output = []
for seq_record in pan_genome_reference_fasta_file:
    gene_cluster_name = ' '.join(seq_record.description.split(' ')[1:])
    print(gene_cluster_name)
    if gene_cluster_name in gene_list_to_extract:
        output.append(seq_record)

print("Found {} criteria-meeting record".format(len(output)))
SeqIO.write(output, output_fasta_file, "fasta")
