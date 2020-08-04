#/bin/bash
for project in ~/Research/projects/c/*
do
	prj="$(basename "$project")"
	#mpstat 1 >> fullstats.txt &
	#free -h -s 1 >> ramstats.txt &
	#start=$SECONDS
	bash ~/Research/depends/batch/depends.sh cpp "$project" $prj --detail --auto-include
	#end=$SECONDS	
	#awk '{print $4}' fullstats.txt > stats.txt
	#awk '{print $3}' ramstats.txt > ram.txt
	#mkdir ~/stats/
	#python3 calccpu.py > ~/stats/"$prj"_cpu.txt
	#python3 calcram.py > ~/stats/"$prj"_ram.txt
	#sec=$(echo "scale=2; var=$end-$start;var/60" | bc -l)
	#echo $sec > ~/stats/"$prj"_time_depends.txt
	#rm *.txt
done

mv ~/Research/depends/batch/*.json ~/Research/depends/batch/depends_files/
