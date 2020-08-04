#/bin/bash

repos=( $(cut -d ',' -f4 ~/projectsPython.csv ) )
c=188
i=${repos[c]}
#for i in "${repos[@]:1}"
#do
	mkdir ~/projects/python/ 
	cd ~/projects/python/
	git clone "$i"
	name=( $(cut -d ',' -f1 ~/projectsPython.csv ) )
	cd ~/scripts/
	echo $i > "${name[c]}".txt
	mv *.txt ~/url/
	
        tmp=$(echo $i | cut -d ':' -f 2)
	echo ${tmp[0]}
	tmpp=$(echo ${tmp[0]} | cut -d '.' -f 1) 
	echo ${tmpp[0]}

	curl https://api.github.com/repos/${tmpp[0]}/commits  -H "Accept: application/vnd.github.v3.full+json" > tmp.json
        echo $(jq .[0].sha tmp.json) > "${name[c]}"_commit_id.txt
        mv *.txt ~/commit_id/

        msg=$(jq -r '.[] | .commit | .message[0:10000]' tmp.json )
        echo $msg

        echo "BugID" > ~/DV8/target_issue/"${name[c]}".csv

        for n in $msg
        do
            #two=$(grep -Eo "^6[0-9]{4}" <<< $n)
	    two=$(grep -Eo "" <<< $n)
	    if [ -z "$two" ]
	    then
		echo " " 
	    else
            	#echo "Fix BZ "$two >> ~/DV8/target_issue/"${name[c]}".csv
		echo $two >> ~/DV8/target_issue/"${name[c]}".csv
	    fi
        done


	./masterscript.sh
	#c=$((c+1))
	rm -f -r ~/depends/depends_files/*
	rm -f -r ~/DV8/files/*
	rm -f -r ~/projects/python/*
	rm -f -r ~/DV8/reports/*
#done
