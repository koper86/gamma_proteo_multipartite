# all the analysis were conducted using conda env 'bioinfo'. .yml env file is present

#extracting Multipartite.tar
tar -xvf Multipartite.tar
tar -zxvf Alteromonadales.tar.gz
tar -zxvf Vibrionales.tar.gz

# running prokka_annotation.py, input_data and prokka_results parameters are relative or absolute paths
nohup python prokka_annotation.py  Multipartite/ prokka_results > prokka_annotation.log &

# checking script running
cat prokka_annotation.log | grep successfully | wc -l


