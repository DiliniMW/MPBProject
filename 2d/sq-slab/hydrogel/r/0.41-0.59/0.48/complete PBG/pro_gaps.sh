#!/bin/bash

# Input file
input_file="/home/dona/Documents/project/2d/sq-slab/hydrogel/r/0.41-0.59/0.48/complete PBG/sq-slab.out"

# Function to check if TE or TM is present in the context of the line
check_gap_type(){
local line_number=$1
local gap_type="Unknown"


# Process each line of the file

#Read the previous 20 lines
for i in $(seq 20 -1 1); do
	context_line=$(sed -n "$((line_number -i))p" "$input_file")


if echo " $context_line" | grep -q "tefreqs:";then
	gap_type="te"
	break
elif echo " $context_line" | grep -q "tmfreqs:";then
	gap_type="tm"
	break
elif echo " $context_line" | grep -q "freqs:";then
        gap_type="complete(tm and te)"
        break

fi
done
echo "$gap_type"
}

# Process each line of the file
while IFS= read -r line || [ -n "$line" ]; do

 
 if echo "$line" | grep -q "Gap from"; then 
    # Determine line number for context search
    line_number=$(grep -nF "$line" "$input_file" | cut -d: -f1)
    # Check if the gap is TE or TM
    gap_type=$(check_gap_type "$line_number")

    # Extract the percentage value and remove the percent sign
    percent=$(echo $line | grep -oP '\d+\.\d+%' | grep -oP '\d+\.\d+')
    # Convert the percentage value to a float
    percent_float=$(printf "%.2f" "$percent")
 if (( $(echo "$percent_float > 1" | bc -l) )); then
        # Extract the first and second decimal values
        first_value=$(echo $line | grep -oP 'from band \d+ \(\d+\.\d+|' | grep -oP '\d+\.\d+')
        second_value=$(echo $line | grep -oP 'to band \d+ \(\d+\.\d+' | grep -oP '\d+\.\d+')
	# Extract band information
	band_info=$(echo $line | grep -oP 'from band \d+ \(\d+\.\d+\) to band \d+ \(\d+\.\d+\)')


        # Calculate 1 / first_value and 1 /second_value
        first_result=$(echo "scale=10; 1 / $first_value" | bc -l )
        second_result=$(echo "scale=10; 1 / $second_value" | bc -l )
 

        # Convert the results to micrometers and print
        echo "$gap_type gap: $band_info, $second_result to 10^-7m to $first_result 10^-7m"
      fi
    fi
 done < "$input_file"


