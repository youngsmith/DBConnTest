#!/bin/bash
TELNET_SCRIPT="#!/bin/bash
ip=\${1}
OUTPUT_FILE_NAME=output.txt

echo "\${ip} : start!"
rm \${OUTPUT_FILE_NAME}

DB_IP=(61.252.169.31 61.252.169.27)
PORT=(443 443)
idx=0

for dp_ip in "\${DB_IP[@]}"
do
    echo "\${dp_ip} \${PORT[\${idx}]}"
    echo "[Try Connecting To DB Server - \${dp_ip}:\${PORT[\${idx}]}] " >> "\${OUTPUT_FILE_NAME}"
    sleep 1
    timeout --signal=9 1 telnet \${dp_ip} \${PORT[\${idx}]} >> \${OUTPUT_FILE_NAME} 
    idx=\$((idx+1))"
ID=yyjjang
start_server_ip_list=(1.2.1.1 1.2.1.1 1.2.1.1 1.2.1.1)
target_server_ip_list=(1.2.1.1:8080 1.2.1.1:8080 1.2.1.1:8080 1.2.1.1:8080)

# 게이트웨이에서 모든 서버로 접속하여 테스트한 총 결과 파일명
TOTAL_RESULT_FILE_NAME=FirewallTestResult.txt
# 각 서버에서의 테스트 결과 파일명
TEMP_RESULT_FILE_NAME=output.txt
# 각 서버에 주입하여 실행할 파일명
FIREWALL_TEST_SHELL_FILE_NAME=FirewallTest.sh
# 각 서버 접속 정보 파일명
CONN_INFO_FILE_NAME=ConnInfoList.txt

echo "Script Is Starting ... : $(date)" 
echo "Hello, ${ID}. Now Start Firewall Check !"

echo "" > ${TOTAL_RESULT_FILE_NAME}

for start_server_ip in "${start_server_ip_list[@]}"
do
    echo "Trying Connecting To Server [${start_server_ip}] ..."
    echo "[From Instance : ${start_server_ip}]" >> ${TOTAL_RESULT_FILE_NAME}
    ssh ${ID}@${start_server_ip} "${TELNET_SCRIPT}"
    scp ${ID}@${start_server_ip}:~/${TEMP_RESULT_FILE_NAME} ./
    cat ${TEMP_RESULT_FILE_NAME} >> ${TOTAL_RESULT_FILE_NAME}
    echo -e "\n\n\n" >> ${TOTAL_RESULT_FILE_NAME}
    rm ${TEMP_RESULT_FILE_NAME}
    echo "Disconnected From [${start_server_ip}] ..."
done
