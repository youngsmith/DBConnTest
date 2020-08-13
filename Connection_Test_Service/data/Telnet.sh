#!/bin/bash
target_server_ip_list=${1}
echo "target_server_ip_list : ${target_server_ip_list[@]}"
FIREWALL_TEST_RESULT_FILE_NAME=output.txt

echo "Start Firewall Check!"
rm ${FIREWALL_TEST_RESULT_FILE_NAME}

IFS=": "
for target_server_ip in "${target_server_ip_list[@]}"
do
    echo "${target_server_ip}"
    echo "[Try Connecting To Target Server - ${target_server_ip}] " >> "${FIREWALL_TEST_RESULT_FILE_NAME}"
    read -r -a array <<< ${target_server_ip}
    ip=${array[0]}
    port=${array[1]}
    echo "ip : ${ip} / port : ${port}"
    sleep 1
    timeout --signal=9 1 telnet ${ip} ${port} >> ${FIREWALL_TEST_RESULT_FILE_NAME} 
done
