#/bin/bash
for folder in ~/projects/python/*
do
		project_name="$(basename $folder)"
		project_domain="-"
		language="python"
		cd /home/ma3388/url/
		resource_url=$(cat $project_name.txt)
		resource_url=$(echo ${resource_url//\"})
		rm /home/ma3388/url/$project_name.txt
		resource_type="public_git"
                target_issue_list_file="/home/ma3388/DV8/target_issue/${project_name}.csv"
		target_issue_name_pattern="N/A"

                cd /home/ma3388/commit_id/
		commit_id=$(cat "$project_name"_commit_id.txt)
		commit_id=$(echo ${commit_id//\"})
                rm /home/ma3388/commit_id/"$project_name"_commit_id.txt

		file_count="$(find ~/projects/python/$project_name/ -type f | wc -l)"
		decoupling_level="$(jq '.decouplingLevel' ~/DV8/reports/$project_name/Architecture-analysis-result/metrics/decoupling-level.json)"
		propagation_cost="$(jq '.propagationCost' ~/DV8/reports/$project_name/Architecture-analysis-result/metrics/propagation-cost.json)"
		scan_type="arch_report"
		if [ $decoupling_level == "" ]; then
			scan_status="FAILED"
		else
			scan_status="SUCCESSFUL"	
		fi		
		scan_result_comment="No target issue name pattern"
		depends_scan_duration="$(cat ~/stats/"$project_name"_time_depends.txt)"
		dv8_scan_duration="$(cat ~/stats/"$project_name"_time_dv8.txt)"	
		cpu_usage="$(cat ~/stats/"$project_name"_cpu.txt)"
		IFS=' '
		read -a arr <<< "$cpu_usage"
		depends_min_cpu_utilization="${arr[0]}"	
		depends_max_cpu_utilization="${arr[1]}"	
		depends_avg_cpu_utilization="${arr[2]}"
		ram_usage=$(cat ~/stats/"$project_name"_ram.txt)
		#depends_max_memory_utilization=$ram_usage
		depends_max_memory_utilization=""		
		rm ~/stats/"$project_name"_ram.txt		
		rm ~/stats/"$project_name"_cpu.txt

		cpu_usage="$(cat ~/stats/"$project_name"_cpu_dv8.txt)"
		IFS=' '
		read -a arr <<< "$cpu_usage"
		dv8_min_cpu_utilization="${arr[0]}"	
		dv8_max_cpu_utilization="${arr[1]}"	
		dv8_avg_cpu_utilization="${arr[2]}"
		ram_usage=$(cat ~/stats/"$project_name"_ram_dv8.txt)
		#dv8_max_memory_utilization=$ram_usage
		dv8_max_memory_utilization=""
		rm ~/stats/*.txt

		echo "$project_name	$project_domain	$language	$resource_url	$resource_type	$target_issue_list_file	$target_issue_name_pattern	$commit_id	$file_count	$decoupling_level	$propagation_cost	$scan_type	$scan_status	$scan_result_comment	$depends_scan_duration	$dv8_scan_duration	$depends_min_cpu_utilization	$depends_max_cpu_utilization	$depends_avg_cpu_utilization	$depends_max_memory_utilization	$dv8_min_cpu_utilization	$dv8_max_cpu_utilization	$dv8_avg_cpu_utilization	$dv8_max_memory_utilization" >> ~/scripts/final_report.csv

done
