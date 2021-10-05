import sys
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord

pangenome_reference_file = sys.argv[1]
gene_list_to_extract_file = sys.argv[2]
output_fasta_file = sys.argv[3]


# pangenome_reference_file = "/home/user/PycharmProjects/gamma_proteo_multipartite/RAST_Subsystem_annotation/Aliivibrio_genus_pan_genome_reference.fa"
# gene_list_to_extract_file = '/home/user/PycharmProjects/gamma_proteo_multipartite/RAST_Subsystem_annotation/Aliivibrio_genus_95_gene_list_represenative.txt'
# output_fasta_file = "/home/user/PycharmProjects/gamma_proteo_multipartite/RAST_Subsystem_annotation/pangenome.fasta"

gene_list = open(
    gene_list_to_extract_file,
    'r')
gene_list_to_extract = gene_list.read().splitlines()

pangenome_artificial_genome = ""

for seq_record in SeqIO.parse(
        pangenome_reference_file, "fasta"):
    if seq_record.id in gene_list_to_extract:
        pangenome_artificial_genome = pangenome_artificial_genome + str(seq_record.seq)

record = SeqRecord(Seq(pangenome_artificial_genome), id='contig_1')
SeqIO.write(record, output_fasta_file, "fasta")
