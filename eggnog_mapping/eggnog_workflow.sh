# all the analysis were conducted using conda env 'bioinfo' and 'eggnog'. .yml env file is present

# copy pan_genome_reference.fa from roary results (-i 60 for genus) to appropriate folder for eggnog
# chromosome
cp pangenome_output/chromosome/Aliivibrio_genus_60/pan_genome_reference.fa accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_pan_genome_reference.fa
cp pangenome_output/chromosome/Photobacterium_genus_60/pan_genome_reference.fa accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_pan_genome_reference.fa
cp pangenome_output/chromosome/Pseudoalteromonas_genus_60/pan_genome_reference.fa accessory_output/chromosome/Pseudoalteromonas_genus/Pseudoalteromonas_genus_pan_genome_reference.fa
cp pangenome_output/chromosome/Salinivibrio_genus_60/pan_genome_reference.fa accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_pan_genome_reference.fa
cp pangenome_output/chromosome/Vibrio_genus_60/pan_genome_reference.fa accessory_output/chromosome/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa

# chromid
cp pangenome_output/chromid/Aliivibrio_genus_60/pan_genome_reference.fa accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_pan_genome_reference.fa
cp pangenome_output/chromid/Photobacterium_genus_60/pan_genome_reference.fa accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_pan_genome_reference.fa
cp pangenome_output/chromid/Pseudoalteromonas_genus_60/pan_genome_reference.fa accessory_output/chromid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_pan_genome_reference.fa
cp pangenome_output/chromid/Vibrio_genus_60/pan_genome_reference.fa accessory_output/chromid/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa

# megaplasmid
cp pangenome_output/megaplasmid/Pseudoalteromonas_genus_60/pan_genome_reference.fa accessory_output/megaplasmid/Pseudoalteromonas_genus/Pseudoalteromonas_genus_pan_genome_reference.fa
cp pangenome_output/megaplasmid/Salinivibrio_genus_60/pan_genome_reference.fa accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_pan_genome_reference.fa
cp pangenome_output/megaplasmid/Vibrio_genus_60/pan_genome_reference.fa accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa

# convert nucleotide multi-fasta accessory pangenome to protein accessory pangenome for eggnog mapping
find accessory_output/ -type f -name '*pan_genome_reference.fa' -exec transeq -sequence {} -outseq {}.protein -trim \;

# run eggnog-mapper with nohup (eggnog env) trzeba wczesniej stworzyc katalog i nadac mu 777 bo sie pierdzieli
nohup python eggnog_output_prep_and_exe.py accessory_output/ eggnog_mapping/ > eggnog_mapping.log &
