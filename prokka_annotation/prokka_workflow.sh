# all the analysis were conducted using conda env 'bioinfo'. .yml env file is present

#extracting Multipartite.tar
tar -xvf Multipartite.tar
tar -zxvf Alteromonadales.tar.gz
tar -zxvf Vibrionales.tar.gz

# running prokka_annotation.py, input_data and prokka_results parameters are relative or absolute paths
nohup python prokka_annotation.py  Multipartite/ prokka_results > prokka_annotation.log &

# checking script running
cat prokka_annotation.log | grep successfully | wc -l

# do powtórki, to są w wiekszości te genomy, ktore nie maja nazwy gatunkowej - zmienisz nazwę
# tu są genomy, ktore sa w excelu a nie ma ich w odpowedniej nazwie w prokka annotation
csvcut -c 1 mutipartite_vibrio_pseudo.csv  | sort > excel_sorted.txt

find . -type f -iname '*.gff' -exec basename {} .gff \; > prokka_done.txt
prokka_done.txt | sort > prokka_done_sorted.txt
comm -23 excel_sorted.txt prokka_done_sorted.txt > to_repeat

# tu sa genomy, którym nie poszla adnotacja, bo cos sie zacielo wzgledem oryginalnych plikow faa
find . -type f -iname '*.fna' -exec basename {} .fna \; > prokka_input.txt
cat prokka_input.txt | sort | uniq | sort > prokka_input_sorted.txt
comm -23 prokka_input_sorted.txt prokka_done_sorted.txt

#tylko jeden
#Pseudomonas_marina

