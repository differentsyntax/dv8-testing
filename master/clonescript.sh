#/bin/bash
cd ~/Research/projects/c
#echo $(curl https://api.github.com/search/repositories?q=language:c&sort=stars&order=desc) > repos.json

#for i in {0..100}
#do

#	repo=$(echo $(jq .items[$i].html_url repos.json))
#	repo=$(echo "${repo//\"}")
#	name=$(echo $(jq .items[$i].name repos.json))
#	name=$(echo "${name//\"}")
#	echo $(jq .items[$i].html_url repos.json) > "$name".txt
# 	git clone $repo

#done

#mv *txt ~/Research/url/
#mv repos.json ~/Research/

git clone git@github.com:wireshark/wireshark.git
