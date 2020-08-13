#!/bin/bash
target_server_ip_list=${1}
FIREWALL_TEST_RESULT_FILE_NAME=output.txt

echo "Start Firewall Test!"
rm ${FIREWALL_TEST_RESULT_FILE_NAME}

for target_server_ip in "${target_server_ip_list[@]}"
do
    echo "${target_server_ip}"
    echo "[Try Connecting To DB Server - ${target_server_ip}] " >> "${FIREWALL_TEST_RESULT_FILE_NAME}"
    
    ip=
    port=
    sleep 1
    timeout --signal=9 1 telnet ${ip} ${port} >> ${FIREWALL_TEST_RESULT_FILE_NAME} 
    idx=$((idx+1))
done