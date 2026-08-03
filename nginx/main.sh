#!usr/bin/bash
set -x 
echo "\n Enter the path to ur log file :"
read LOG_FILE



echo "\n Top 5 IP addresses with the most requests are"
#Top 5 IP adresses with most rquests and export results to JSON format
TOP_IPS=$(awk '{print $1}' $LOG_FILE | sort |uniq -c  | sort -rn | head -n 5  | awk '{print $1 "-" $2 " " "requests"}') 
echo $TOP_IPS > report.json
echo "\n Top 5 mosted requsts paths with most requests"
#Top 5 most requested paths
awk 'print{$7}' $LOG_FILE |sort |uniq -c| sort -rn |head -n  5 | awk 'print $1 "-" $2 " " "requests'

#Top 5 responses status codes 
echo "\n Top 5 responses status codes:"
awk '{print $9}' $LOG_FILE | sort |uniq -c |sort -rn| head -n 5 |awk '{print $1 "-" $2 " " "requests"}'

#Security Threat Detection: Top 5 suspicious scanner IPs (404 errors)
awk '$9 == 404 {print $1}' $LOG_FILE | sort |uniq -c |sort -rn| head -n 5 |awk '{print $1 "-" $2 " " "requests"}'
  
