#/bin/bash
for project in ~/Research/projects/c/*
do
	prj="$(basename "$project")"
	./und create -db $prj.udb -languages c++
	./und -db $prj.udb add $project
	./und analyze $prj.udb
done

rm -r *.udb
mv *.xml ~/Research/understand/understand_files/
