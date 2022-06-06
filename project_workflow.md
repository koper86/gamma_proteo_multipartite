# GAMMA PROTEO BACTERIA MULTIPARTITE GENOMES WORKFLOW
## Downloading data
downloading relevant fasta files with acc number to dir structure

```bash
while read ACC_NUMBER; do
  ncbi-acc-download -m nucleotide \
                    -F fasta \
                    -v \
                    ${ACC_NUMBER}
done < acc_list.txt
```

## Preparing input for pangenome calculations
prokka annotation

```bash
while read ACC_NUMBER; do
  prokka --outdir ${ACC_NUMBER} --prefix ${ACC_NUMBER} --fast --norna --notrna --cpus 12 ${ACC_NUMBER}.fa
done < acc_list.txt
```

## Pangenome calculations
copying relevant files from subdirs
```bash
cp **/*.gff .
```
running pangenome for every genus/replicon combination
```bash
nohup roary -e -n -i 60 -g 100000 -p 12 -v -f pangenome_calc_v2 *.gff &
```
## Accessory and core genomes extraction
### Accessory
extracting accessory genes. Paths and filenames stored in accessory_pangenome_extraction_paths.tsv 
```bash
while read OUTPUT_PATH CLUSTERED_PROTEINS GFF_PATH; do
  query_pan_genome -a complement -c 95 -o $OUTPUT_PATH -g $CLUSTERED_PROTEINS $GFF_PATH
done < accessory_pangenome_extraction_paths.tsv
```

File formatting; extracting gene and representatives names
```bash
while read INPUT_PATH CLUSTERED_PROTEINS GFF_PATH; do
  FILENAME=$(basename ${INPUT_PATH} .txt)
  DIRNAME=$(dirname ${INPUT_PATH})
  cat ${INPUT_PATH} | cut -d':' -f1 > ${DIRNAME}/${FILENAME}_gene_list.txt
  cat ${INPUT_PATH} | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > ${DIRNAME}/${FILENAME}_representative_list.txt
done < accessory_pangenome_extraction_paths.tsv
```
### Core
extracting core genes. Paths and filenames stored in core_pangenome_extraction_paths.tsv
```bash
while read OUTPUT_PATH CLUSTERED_PROTEINS GFF_PATH; do
  query_pan_genome -a intersection -c 95 -o $OUTPUT_PATH -g $CLUSTERED_PROTEINS $GFF_PATH
done < core_pangenome_extraction_paths.tsv
```

File formatting; extracting gene and representatives names
```bash
while read INPUT_PATH CLUSTERED_PROTEINS GFF_PATH; do
  FILENAME=$(basename ${INPUT_PATH} .txt)
  DIRNAME=$(dirname ${INPUT_PATH})
  cat ${INPUT_PATH} | cut -d':' -f1 > ${DIRNAME}/${FILENAME}_gene_list.txt
  cat ${INPUT_PATH} | cut -d':' -f2 | cut -f1 | sed 's/^ *//g' > ${DIRNAME}/${FILENAME}_representative_list.txt
done < core_pangenome_extraction_paths.tsv
```
## Reannotating pangenomes with eggNOG
trancribing pan_genome_reference into multi-fasta aa format
```bash
find . -type f -name '*pan_genome_reference.fa' -exec transeq -sequence {} -outseq {}.protein -trim \;
```
reannotating
```bash
while read INPUT_PATH; do
  DIRNAME=$(dirname ${INPUT_PATH})
  emapper.py --cpu 0 \
             -i ${INPUT_PATH} \
             -o emapper_annot \
             --output_dir ${DIRNAME}\
             -d bact
done < emapper_extraction_paths.tsv

```

## Extracting COG categories from eggNOG annotation and calculating quantity
```bash
while read INPUT_PATH; do
    python COG_calculations.py ${INPUT_PATH}/accessory_95_representative_list.txt \
                               ${INPUT_PATH}/pangenome_calc_v2/emapper_annot.emapper.annotations \
                               ${INPUT_PATH}/calculated_KO.csv
done < COG_calculations_paths.tsv
```
## Calculating COG abundance differences
```bash
while read FIRST_COMP SECOND_COMP OUTPUT_PATH; do
    python COG_fisher_test.py \
        ${FIRST_COMP} \
        ${SECOND_COMP} \
        ${OUTPUT_PATH}
done < COG_comparisons.tsv

```
## Extracting KO categories from eggNOG annotation and calculating quantity
```bash
while read INPUT_PATH; do
    python KO_calculations_v2.py ${INPUT_PATH}/accessory_95_representative_list.txt \
                            ${INPUT_PATH}/pangenome_calc_v2/emapper_annot.emapper.annotations \
                            ${INPUT_PATH}/calculated_KO.csv \
                            ko00001.json
done < COG_KO_calculations_paths.tsv
```
## Calculating KO abundance differences
```bash
while read FIRST_COMP SECOND_COMP OUTPUT_PATH; do
    python KO_fisher_test.py \
        ${FIRST_COMP} \
        ${SECOND_COMP} \
        ${OUTPUT_PATH}
done < KO_comparisons.tsv
```

## Visualizing COG and KO data
```bash
python COG_bar_plot.py
python KO_bar_plot.py
```

