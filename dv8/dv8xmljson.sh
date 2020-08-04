#/bin/bash
for file in ~/Research/understand/understand_files/*
do
		prj="$(basename "$file" ".xml")"
		./dv8-console cytoscape:convert-matrix -outputFile $prj.dv8-dsm $file
		./dv8-console core:export-matrix -outputFile $prj.json $prj.dv8-dsm
done

mv *.xml ~/Research/understand/understand_files/
mv *.json ~/Research/understand/understand_files/
mv *.dv8-dsm ~/Research/understand/understand_files/
