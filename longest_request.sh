#!/usr/bin/awk -f

# Given a multiline log file (multiline_log_file), write a shell script to find the request that take the longest time.
# Run: cat multiline_log_file | ./longest_request.sh

BEGIN {
	maxTime = 0
	maxRequest = ""
}
{
	request = $2 " " $3
	getline
	#print "\n\n---------------------------\n\n"
	if ($2 ~ /200/ || $2 ~ /500/) {
		if ($2 ~ /200/) reqTime = $5 + 0
		if ($2 ~ /500/) reqTime = $7 + 0
		if (reqTime > maxTime) {
			maxTime = reqTime
			maxRequest = request
		}
	}
}
END {
	print "\n** [Longest request]: " maxRequest "\n\n** [Time spent]: " maxTime "ms\n"
}
