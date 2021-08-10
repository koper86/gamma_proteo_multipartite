# all the analysis were conducted using conda env 'bioinfo'. .yml env file is present

#extracting Multipartite.tar
tar -xvf Multipartite.tar
tar -zxvf Alteromonadales.tar.gz
tar -zxvf Vibrionales.tar.gz

# running prokka_annotation.py, input_data and prokka_results parameters are relative or absolute paths
nohup python prokka_annotation.py  Multipartite/ prokka_results > prokka_annotation.log &

# checking script running
cat prokka_annotation.log | grep successfully | wc -l

# some filenames lack strain name
# genomes present in excel file, but absent in prokka results
libreoffice --headless --convert-to csv --outdir . mutipartite_vibrio_pseudo.xls
csvcut -c 1 mutipartite_vibrio_pseudo.csv  | sort > excel_sorted.txt

find . -type f -iname '*.gff' -exec basename {} .gff \; > prokka_done.txt
cat prokka_done.txt | sort > prokka_done_sorted.txt
comm -23 excel_sorted.txt prokka_done_sorted.txt

# custom script for files basename change in given prokka output directory
./basename_change.sh prokka_results/Genomes_Vibrionales/Aliivibrio_salmonicida/ "_VS224."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Catenovulum_sediminis/ "_WS1-A."
./basename_change.sh prokka_results/Genomes_Vibrionales/Grimontia_hollisae/ "_F9489."
./basename_change.sh prokka_results/Genomes_Vibrionales/Paraphotobacterium_marinum/ "_NSCS20N07D."
./basename_change.sh prokka_results/Genomes_Vibrionales/Photobacterium_damselae/ "_9046-81."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_agarivorans/ "_Hao_2018."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_carrageenovora/ "_KCTC_22325."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_donghaensis/ "_HJ51."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_issachenkonii/ "_KMM_3549."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_luteoviolacea/ "_S40542."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_nigrifaciens/ "_KMM_661."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_phenolica/ "_KCTC_12086."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_piscicida/ "_DE2-A."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_rubra/ "_SCSIO_6842."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_ruthenica/ "_LMG_19699."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_spongiae/ "_SAO4-4."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_tetraodonis/ "_GFC."
./basename_change.sh prokka_results/Genomes_Alteromonadales/Pseudoalteromonas_tunicata/ "_D2."
./basename_change.sh prokka_results/Genomes_Vibrionales/Salinivibrio_costicola/ "_M318."
./basename_change.sh prokka_results/Genomes_Vibrionales/Salinivibrio_kushneri/ "_AL184."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_alfacsensis/ "_CAIM_1831."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_alginolyticus/ "_Vb1833."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_anguillarum/ "_MHK3."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_aphrogenes/ "_CA-1004."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_astriarenae/ "_HN897."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_breoganii/ "_FF50."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_campbellii/ "_170502."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_casei/ "_DSM_22364."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_chagasii/ "_ECSMB14107."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_cholerae/ "_NCTC_30."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_cidicii/ "_2756-81."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_cincinnatiensis/ "_F8054."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_coralliilyticus/ "_RE22."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_cyclitrophicus/ "_ECSMB14105."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_diabolicus/ "_FA3."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_europaeus/ "_NPI-1."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_fluvialis/ "_A8."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_furnissii/ "_2012V-1225."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_harveyi/ "_2011V-1164."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_hyugaensis/ "_090810a."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_mediterranei/ "_117-T6."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_metoecus/ "_2011V-1015."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_metschnikovii/ "_07-2421."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_mimicus/ "_F9458."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_natriegens/ "_CCUG_16374."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_navarrensis/ "_2462-79."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_neocaledonicus/ "_CGJ02-2."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_owensii/ "_20160513VC2W."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_panuliri/ "_JCM_19500."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_parahaemolyticus/ "_TJA114."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_ponticus/ "_DSM_16217."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_qinghaiensis/ "_Q67."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_rotiferianus/ "_AM7."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_rumoiensis/ "_FERM_P-14531."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_scophthalmi/ "_VS-05."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_spartinae/ "_3.6."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_splendidus/ "_Vibrio_sp."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_taketomensis/ "_C4III291."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_tritonius/ "_AM2."
./basename_change.sh prokka_results/Genomes_Vibrionales/Vibrio_vulnificus/ "_2497-87."





