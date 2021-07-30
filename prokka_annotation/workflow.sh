# all the analysis were conducted using conda env 'bioinfo'. .yml env file is present

# catalog structure for prokka results
mkdir prokka_results
mkdir prokka_results/alteromonadales
mkdir prokka_results/vibrionales

# running prokka_annotation.py, input_data and prokka_results parameters are relative or absolute paths
python prokka_annotation.py input_data prokka_results




