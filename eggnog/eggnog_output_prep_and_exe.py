import os
import sys
import subprocess as sub

try:
    accessory_output = sys.argv[1]
    emapper_output = sys.argv[2]
except:
    print('Folder name not found')

# accessory_output = '/home/user/PycharmProjects/gamma_proteo_multipartite/pangenome_calculations/accessory_output'
# emapper_output = '/home/user/PycharmProjects/gamma_proteo_multipartite/eggnog/emapper_output/'

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


for dirpath, dirnames, files in os.walk(accessory_output):
    splitted_path = splitall(dirpath)
    replicon_type = splitted_path[-2]
    species_genus_name = splitted_path[-1]
    for file in files:
        if 'fa.protein' in file:
            output_path = os.path.join(emapper_output, replicon_type, species_genus_name)
            # print(output_path)
            os.makedirs(output_path, exist_ok=True)
            os.chmod(output_path, 0o777)
            file_fullpath = os.path.join(dirpath, file)
            emapper_command = f'emapper.py --cpu 0 -i {file_fullpath} --output {output_path} -d bact'
            print(emapper_command)
            p1 = sub.Popen(emapper_command, shell=True)
            os.waitpid(p1.pid, 0)
