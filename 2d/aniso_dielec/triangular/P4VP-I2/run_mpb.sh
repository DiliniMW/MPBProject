#!/bin/bash

# Check if filename is provided
if [ -z "$1" ]; then
	echo "Usage: $0 filename.ctl"
	exit 1
fi

# Get the bade name without extension
basename=$(basename "$1" .ctl)

# Run mpb with the given file
mpb "$1" >& "${basename}.out"


# Extract freqs data
grep freqs "${basename}.out" > "${basename}.freq.dat"

# Run the prep script
./prep.sh

# Run the processing gap file
./pro_gaps.sh >& wavelength_range

# Run the plotting script file
gnuplot plot_script.gp

# Generate PNG images from HDF5 file
h5topng -S 3 "${basename}-epsilon.h5"

# Process MPB data and generate new data
mpb-data -r -m 3 -n 32 "${basename}-epsilon.h5"

# Generate PNG image from new data
h5topng "${basename}-epsilon.h5:data-new"


echo "script executed"

