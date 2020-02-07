#/bin/bash

repos=( $(cut -d ',' -f4 <path to csv file with project list> ) )

for i in "${repos[@]:1}"
do
	cd <path to projects directory>
	git clone "$i"
done
