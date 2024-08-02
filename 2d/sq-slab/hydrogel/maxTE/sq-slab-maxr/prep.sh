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
te_file="/home/dona/Documents/project/2d/sq-slab/hydrogel/maxTE/sq-slab-maxr/sq-slab.te.dat"
tm_file="/home/dona/Documents/project/2d/sq-slab/hydrogel/maxTE/sq-slab-maxr/sq-slab.tm.dat"

# Output files
te_output="te_data.dat"
tm_output="tm_data.dat"

#Band column indices for TE and TM bands 
extract_bands "$te_file" 6 13 "$te_output"
extract_bands "$tm_file" 6 13 "$tm_output"

echo "data files prepared: $te_output and $tm_output"
