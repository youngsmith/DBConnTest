#!/bin/bash
ip=${1}
OUTPUT_FILE_NAME=output.txt

echo "${ip} : start!"
rm ${OUTPUT_FILE_NAME}

echo "[From Instance : ${ip}]" > ${OUTPUT_FILE_NAME}  

DB_IP=(61.252.169.31 61.252.169.27)
PORT=(443 443)
idx=0

for dp_ip in "${DB_IP[@]}"
do
    echo "${dp_ip} ${PORT[${idx}]}"
    echo "[Try Connecting To DB Server - ${dp_ip}:${PORT[${idx}]}] " >> "${OUTPUT_FILE_NAME}"
    sleep 1
    timeout --signal=9 1 telnet ${dp_ip} ${PORT[${idx}]} >> ${OUTPUT_FILE_NAME} 
    idx=$((idx+1))
done