import sys
import os
import subprocess as sub


try:
    input_data_dir = sys.argv[1]
    output_data_dir = sys.argv[2]
except:
    print('No directory name passed')

for dirpath, dirnames, files in os.walk(input_data_dir):
    for filename in files:
        if filename.endswith(".fna"):
            dirs = os.path.split(dirpath)
            noext_name, ext = os.path.splitext(filename)
            splitted_noext_name = noext_name.split(sep='_')
            genus = splitted_noext_name[0]
            species = splitted_noext_name[1]
            strain = ' '.join(splitted_noext_name[2:])
            print(genus + ' ' + species + ' ' + strain)

            p1 = sub.run([
                'prokka',
                '--prefix', '_'.join([genus, species, strain]),
                '--fast',
                '--norna',
                '--notrna',
                '--outdir', os.path.join(output_data_dir, dirs[-1], '_'.join([genus, species, strain])),
                '--genus', genus,
                '--species', species,
                '--strain', strain,
                os.path.join(dirpath, filename)
            ], stdout=sub.PIPE)
            print(p1.stderr)



