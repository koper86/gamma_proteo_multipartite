import sys
import os
import subprocess as sub
import pathlib

try:
    roary_input_dir = sys.argv[1]
    roary_output_dir = sys.argv[2]
except:
    print('No directory name passed')

roary_input_dir = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/pangenome_input'
roary_output_dir = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/pangenome_output'

species_level_identity_treshold = '95'
genus_level_identity_treshold = ['40', '50', '60', '70', '80', '90']


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


def calculate_pangenome(replicon_type):
    root_path = pathlib.Path(roary_input_dir)
    non_empty_dirs = {str(p.parent) for p in root_path.rglob('*') if p.is_file()}
    for dirpath, dirnames, files in os.walk(roary_input_dir):
        splitted_path = splitall(dirpath)
        replicon_calculations_type = splitted_path[-2]
        genus_species_name = splitted_path[-1]
        if (replicon_type in dirpath) and ('genus' in dirpath):
            if files and len(os.listdir(dirpath)) >= 2:
                output_path = os.path.join(roary_output_dir, replicon_calculations_type, genus_species_name)
                # os.makedirs(output_path, exist_ok=True)
                for iden_tresh in genus_level_identity_treshold:
                    roary_command = 'roary -e -n -i {} -g 100000 -v -f {}_{} {}/*.gff'.format(iden_tresh,
                                                                                              output_path, iden_tresh,
                                                                                              dirpath)
                    print(roary_command)
        elif (replicon_type in dirpath) and ('genus' not in dirpath) and dirpath in non_empty_dirs:
            if files and len(os.listdir(dirpath)) >= 2:
                output_path = os.path.join(roary_output_dir, replicon_calculations_type, genus_species_name)
                roary_command = 'roary -e -n -i {} -g 100000 -v -f {} {}/*.gff'.format(species_level_identity_treshold,
                                                                                       output_path,
                                                                                       dirpath)
                print(roary_command)
            # p1 = sub.Popen(roary_command, shell=True)
            # os.waitpid(p1.pid, 0)
            # print('roary completed run')




calculate_pangenome('entire_genome')
calculate_pangenome('chromosome')
calculate_pangenome('chromid')
calculate_pangenome('megaplasmid')


