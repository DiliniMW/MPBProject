#!/bin/bash

# Function to extract band data
extract_bands(){
	input_file="$1"
	start_band="$2"
	end_band="$3"
	output_file="$4"
	
	# Use awk to extract the k index and specified band columns
	awk -v start=$start_band -v end=$end_band 'BEGIN {FS = ","; OFS = " "}
		{
			print $2, $(start+1), $(start+2), $(start+3),$(start+4),$(start+5),$(start+6),$(start+7)$(start+8)}' "$input_file" > "$output_file"
			}
			
# Paths to your raw input files

freq_file="/home/dona/Documents/project/2d/aniso_dielec/triangular/IPV4-I2/tri-ad.freq.dat"

# Output file
freq_output="freq_data.dat"

 
extract_bands "$freq_file" 6 13 "$freq_output"


echo "data file prepared"
