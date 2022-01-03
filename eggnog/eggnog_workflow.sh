# all the analysis were conducted using conda env 'bioinfo' and 'eggnog'. .yml env file is present

# copy pan_genome_reference.fa from roary results (-i 60 for genus) to appropriate folder for eggnog
# chromosome
cp pangenome_output/chromosome/Aliivibrio_genus_60/pan_genome_reference.fa accessory_output/chromosome/Aliivibrio_genus/Aliivibrio_genus_pan_genome_reference.fa
cp pangenome_output/chromosome/Photobacterium_genus_60/pan_genome_reference.fa accessory_output/chromosome/Photobacterium_genus/Photobacterium_genus_pan_genome_reference.fa
cp pangenome_output/chromosome/Vibrio_genus_60/pan_genome_reference.fa accessory_output/chromosome/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa
cp pangenome_output/chromosome/Salinivibrio_genus_60/pan_genome_reference.fa accessory_output/chromosome/Salinivibrio_genus/Salinivibrio_genus_pan_genome_reference.fa
cp pangenome_output/chromosome/Vibrio_genus_60/pan_genome_reference.fa accessory_output/chromosome/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa

# chromid
cp pangenome_output/chromid/Aliivibrio_genus_60/pan_genome_reference.fa accessory_output/chromid/Aliivibrio_genus/Aliivibrio_genus_pan_genome_reference.fa
cp pangenome_output/chromid/Photobacterium_genus_60/pan_genome_reference.fa accessory_output/chromid/Photobacterium_genus/Photobacterium_genus_pan_genome_reference.fa
cp pangenome_output/chromid/Vibrio_genus_60/pan_genome_reference.fa accessory_output/chromid/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa
cp pangenome_output/chromid/Vibrio_genus_60/pan_genome_reference.fa accessory_output/chromid/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa

# megaplasmid
cp pangenome_output/megaplasmid/Vibrio_genus_60/pan_genome_reference.fa accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa
cp pangenome_output/megaplasmid/Salinivibrio_genus_60/pan_genome_reference.fa accessory_output/megaplasmid/Salinivibrio_genus/Salinivibrio_genus_pan_genome_reference.fa
cp pangenome_output/megaplasmid/Vibrio_genus_60/pan_genome_reference.fa accessory_output/megaplasmid/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa

# extrachromosomal combined
cp pangenome_output/extrachromosomal/Pseudoalteromonas_genus_60/pan_genome_reference.fa accessory_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_pan_genome_reference.fa
cp pangenome_output/extrachromosomal/Vibrio_genus_60/pan_genome_reference.fa accessory_output/extrachromosomal/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa

# All genus chromosome + extrachromosomal (pangenome calculated)
cp pangenome_output/chromosome/All_genus_60/pan_genome_reference.fa \
   accessory_output/chromosome/All_genus/All_genus_pan_genome_reference.fa

cp pangenome_output/extrachromosomal/All_genus_60/pan_genome_reference.fa \
   accessory_output/extrachromosomal/All_genus/All_genus_pan_genome_reference.fa
# convert nucleotide multi-fasta accessory pangenome to protein accessory pangenome for eggnog mapping
find accessory_output/ -type f -name '*pan_genome_reference.fa' -exec transeq -sequence {} -outseq {}.protein -trim \;


# run eggnog-mapper with nohup (eggnog env) trzeba wczesniej stworzyc katalog i nadac mu 777 bo sie pierdzieli
nohup python eggnog_output_prep_and_exe.py accessory_output/ eggnog_mapping/ > eggnog_mapping.log &

# recalculating annotation for extrachromosomal
emapper.py --cpu 0 -i $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Pseudoalteromonas_genus/Pseudoalteromonas_genus_pan_genome_reference.fa.protein \
           --output $DYSK/gamma_multipartite/eggnog_mapping/extrachromosomal/Pseudoalteromonas_genus/ -d bact


emapper.py --cpu 0 -i $DYSK/gamma_multipartite/accessory_output/extrachromosomal/Vibrio_genus/Vibrio_genus_pan_genome_reference.fa.protein \
           --output Vibrio_genus \
           --output_dir $DYSK/gamma_multipartite/eggnog_mapping/extrachromosomal/Vibrio_genus/ -d bact
           
# recalculating annotation for All genus chromosome and extrachromosomal for pangenome of combined replicons
emapper.py --cpu 0 -i $DYSK/gamma_multipartite/accessory_output/chromosome/All_genus/All_genus_pan_genome_reference.fa.protein \
           --output All_genus \
           --output_dir $DYSK/gamma_multipartite/eggnog_mapping/chromosome/All_genus/ -d bact

nohup sh -c 'emapper.py --cpu 0 -i $DYSK/gamma_multipartite/accessory_output/chromosome/All_genus/All_genus_pan_genome_reference.fa.protein --output All_genus --output_dir $DYSK/gamma_multipartite/eggnog_mapping/chromosome/All_genus/ -d bact' &

emapper.py --cpu 0 -i $DYSK/gamma_multipartite/accessory_output/extrachromosomal/All_genus/All_genus_pan_genome_reference.fa.protein \
           --output All_genus \
           --output_dir $DYSK/gamma_multipartite/eggnog_mapping/extrachromosomal/All_genus/ -d bact

nohup sh -c 'emapper.py --cpu 0 -i $DYSK/gamma_multipartite/accessory_output/extrachromosomal/All_genus/All_genus_pan_genome_reference.fa.protein --output All_genus --output_dir $DYSK/gamma_multipartite/eggnog_mapping/extrachromosomal/All_genus/ -d bact' &