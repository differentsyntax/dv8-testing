#/bin/bash

for file in ~/Research/depends/batch/depends_files/*.json
do
	f="$(basename "$file" .json)"
	java -jar depends-compare-0.9.2.jar $file ~/Research/understand/understand_files/"$f".json "$f"_compare
done

mv *_compare.json ~/Research/depends/batch/compare_files/
