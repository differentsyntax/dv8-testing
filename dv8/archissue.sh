#/bin/bash
for file in ~/DV8/files/*
do
	prj="$(basename $file .dv8-dsm)"
	echo "$prj"
	#./dv8-console arch-issue:arch-issue -outputFolder ~/DV8/reports/archissue/$prj $file
	#./dv8-console metrics:decoupling-level -outputFile $prj $file
	#./dv8-console arch-root:arch-root -outputFolder ~/DV8/reports/archroot/$prj $file

	echo "## dv8 arch report params file

## Config global inputFolder and outputFolder path applied to arch report params
## Present working directory would be used if this option is empty
## Both absolute and relative path are accepted
## For Windows the format should be like C:/path/to/folder or C:/path/to/folder
inputFolder: /home/ma3388/depends/depends_files/
outputFolder: /home/ma3388/DV8/reports/

## Generate structure dsm, available values: cytoscape:convert-matrix, core:convert-matrix, minos:convert-matrix
## This option is mandatory
dsm.command: core:convert-matrix
dsm.file: /home/ma3388/depends/depends_files/${prj}.json
## Read from xml if dsm.command is core:convert-matrix
#dsm.xml: xml

## Generate change list available values: scm:gentargetlist:gittxt:generate-targetlist, scm:gentargetlist:svn:generate-targetlist
scm.targetList.command: svn-generate-targetlist
scm.targetList.start: 2016-01-01T00:00:00Z
scm.targetList.stop: 2019-01-01T00:00:00Z



#scm.targetList.regex: PiperOrigin-RevId: [0-9]+
scm.targetList.regex: 


scm.targetList.targetissuecsv: /home/ma3388/DV8/target_issue/${prj}.csv

## Compute arch issues
issue.archissue.crossingCochange: 2
issue.archissue.crossingSize: 4
issue.archissue.historyImpact: 10
issue.archissue.modularityViolationCochange: 2
issue.archissue.structImpact: 0.01
issue.archissue.unstableInterfaceCochange: 2
issue.archissue.filteredDepends: call,use
issue.archissue.inheritanceDepends: extend,implement,public,private,virtual public
#issue.archissueCost.bugCover: -1
#issue.archissueCost.changeCover: -1

## Compute arch root
archroot.frequency: 2
archroot.percentage: 0.8
		
		" > ~/DV8/archreport.properties

	cd ~/DV8/bin/
	mpstat 1 >> fullstats.txt &
	free -h -s 1 >> ramstats.txt &
	start=$SECONDS
	./dv8-console arch-report -paramsFile ~/DV8/archreport.properties
	end=$SECONDS
	awk '{print $4}' fullstats.txt > stats.txt
	awk '{print $3}' ramstats.txt > ram.txt
	mkdir ~/stats/
	python3 calccpu.py > ~/stats/"$prj"_cpu_dv8.txt
	python3 calcram.py > ~/stats/"$prj"_ram_dv8.txt
	sec=$(echo "scale=2; var=$end-$start;var/60" | bc -l)
	echo $sec > ~/stats/"$prj"_time_dv8.txt	
	rm *.txt	

	cd ~/DV8/reports/
	mkdir $prj
	mv Architecture-analysis-result $prj/
	rm Architecture-analysis-result.zip 
done
