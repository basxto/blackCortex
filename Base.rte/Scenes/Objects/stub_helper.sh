#!/bin/sh
plants=2
plantsmax=23
gold=1
goldmax=26
fossils=3
fossilsmax=30
boulders=2
bouldersmax=103

for i in $(seq ${plants} $((${plantsmax}-1))); do
	# remove existing files
	rm Plants/Plant$(printf "%03d" $i).bmp
	# place symlinks
	ln -s Plant$(printf "%03d" $(($i % ${plants}))).bmp Plants/Plant$(printf "%03d" $i).bmp
	# add to repository
	git add Plants/Plant$(printf "%03d" $i).bmp
done


for i in $(seq ${gold} $((${goldmax}-1))); do
	# remove existing files
	rm Gold/Gold$(printf "%03d" $i).bmp
	# place symlinks
	ln -s Gold$(printf "%03d" $(($i % ${gold}))).bmp Gold/Gold$(printf "%03d" $i).bmp
	# add to repository
	git add Gold/Gold$(printf "%03d" $i).bmp
done


for i in $(seq ${fossils} $((${fossilsmax}-1))); do
	# remove existing files
	rm Fossils/Fossil$(printf "%03d" $i).bmp
	# place symlinks
	ln -s Fossil$(printf "%03d" $(($i % ${fossils}))).bmp Fossils/Fossil$(printf "%03d" $i).bmp
	# add to repository
	git add Fossils/Fossil$(printf "%03d" $i).bmp
done


for i in $(seq ${boulders} $((${bouldersmax}-1))); do
	# remove existing files
	rm Boulders/Boulder$(printf "%03d" $i).bmp
	# place symlinks
	ln -s Boulder$(printf "%03d" $(($i % ${boulders}))).bmp Boulders/Boulder$(printf "%03d" $i).bmp
	# add to repository
	git add Boulders/Boulder$(printf "%03d" $i).bmp
done

