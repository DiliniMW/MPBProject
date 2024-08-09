
set terminal png size 800,600
set output 'band_structure.png'
set title 'Band Structure'
set xlabel 'k index'
set ylabel 'Frequency (c/a)'
set xrange [1:16]
set yrange [0:1.4]
set xtics("Γ" 1, " " 2, " " 3, " " 4, " " 5, "X" 6," " 7," " 8," " 9," " 10, "M" 11," " 12," " 13," " 14," " 15, "Γ" 16)
set ytics 0.1
set grid xtics ytics

# Define colors for TE and TM bands
set style line 1 lc rgb 'red' lw 2 # TE bands in red
set style line 2 lc rgb 'blue' lw 2 # TM bands in blue

# Define the style for the shaded area
set style fill solid 0.3 border -1
set object 1 rect from graph 0, first 0.12567688320863943 to graph 1, first 0.14887626440774673 behind fc rgb '#FF9999'
set object 2 rect from graph 0, first 0.17212256603223358 to graph 1, first 0.23094743222350303 behind fc rgb '#FF9999'
set object 3 rect from graph 0, first 0.25081905114150327 to graph 1, first 0.28226244091530206 behind fc rgb '#FF9999'
set object 4 rect from graph 0, first 0.28495018520764676 to graph 1, first 0.3101073426036185 behind fc rgb '#FF9999'
set object 5 rect from graph 0, first 0.33700500272342515 to graph 1, first 0.34112393540146174 behind fc rgb '#FF9999'
set object 6 rect from graph 0, first 0.0967838727911574 to graph 1, first 0.10859370557320903 behind fc rgb '#FF9999'

plot 'te_data.dat' using 1:2 with lines title 'TE band 1' ls 1,\
	'te_data.dat' using 1:3 with lines title 'TE band 2' ls 1,\
	'te_data.dat' using 1:4 with lines title 'TE band 3' ls 1,\
	'te_data.dat' using 1:5 with lines title 'TE band 4' ls 1,\
	'te_data.dat' using 1:6 with lines title 'TE band 5' ls 1,\
	'te_data.dat' using 1:7 with lines title 'TE band 6' ls 1,\
	'te_data.dat' using 1:8 with lines title 'TE band 7' ls 1,\
	'te_data.dat' using 1:9 with lines title 'TE band 8' ls 1,\
	'tm_data.dat' using 1:2 with lines title 'TM band 1' ls 2,\
	'tm_data.dat' using 1:3 with lines title 'TM band 2' ls 2,\
	'tm_data.dat' using 1:4 with lines title 'TM band 3' ls 2,\
	'tm_data.dat' using 1:5 with lines title 'TM band 4' ls 2,\
	'tm_data.dat' using 1:6 with lines title 'TM band 5' ls 2,\
	'tm_data.dat' using 1:7 with lines title 'TM band 6' ls 2,\
	'tm_data.dat' using 1:8 with lines title 'TM band 7' ls 2,\
	'tm_data.dat' using 1:9 with lines title 'TM band 8' ls 2,
