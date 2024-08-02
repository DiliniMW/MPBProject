
set terminal png size 800,600
set output 'band_structure.png'
set title 'Band Structure'
set xlabel 'k index'
set ylabel 'Frequency (c/a)'
set xrange [1:16]
set yrange [0:0.3]
set xtics("Γ" 1, " " 2, " " 3, " " 4, " " 5, "M" 6," " 7," " 8," " 9," " 10, "K" 11," " 12," " 13," " 14," " 15, "Γ" 16)
set ytics 0.05
set grid xtics ytics

# Define colors for TE and TM bands
set style line 1 lc rgb 'purple' lw 2 # complete bands in purple


# Define the style for the shaded area
set style fill solid 0.3 border -1
set object 1 rect from graph 0, first 0.20435288993213466 to graph 1, first 0.21696440865256175 behind fc rgb '#D8BFD8'
set object 2 rect from graph 0, first 0.2827910430813258 to graph 1, first 0.29073137400419 behind fc rgb '#D8BFD8'
set object 3 rect from graph 0, first 0.3662461955209112 to graph 1, first 0.37639385971435213 behind fc rgb '#D8BFD8'
plot 'freq_data.dat' using 1:2 with lines title 'band 1' ls 1,\
	'freq_data.dat' using 1:3 with lines title 'band 2' ls 1,\
	'freq_data.dat' using 1:4 with lines title 'band 3' ls 1,\
	'freq_data.dat' using 1:5 with lines title 'band 4' ls 1,\
	'freq_data.dat' using 1:6 with lines title 'band 5' ls 1,\
	'freq_data.dat' using 1:7 with lines title 'band 6' ls 1,\
	'freq_data.dat' using 1:8 with lines title 'band 7' ls 1,\
	'freq_data.dat' using 1:9 with lines title 'band 8' ls 1,
