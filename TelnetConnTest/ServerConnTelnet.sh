#!/bin/bash

# 게이트웨이에서 모든 서버로 접속하여 테스트한 총 결과 파일명
TOTAL_RESULT_FILE_NAME=FirewallTestResult.txt
# 각 서버에서의 테스트 결과 파일명
TEMP_RESULT_FILE_NAME=output.txt
# 각 서버에 주입하여 실행할 파일명
FIREWALL_TEST_SHELL_FILE_NAME=FirewallTest.sh
# 각 서버 접속 정보 파일명
CONN_INFO_FILE_NAME=ConnInfoList.txt

<<<<<<< HEAD
# 수정필요 파일에서 읽는 걸로.
ID=yyjjang
=======
echo "Script is Starting ... : $(date)" 

ip=
ID=
>>>>>>> 626fb88e385f692c551e2f838c1224260a90eae5

echo "Script is Starting ... : $(date)" 
echo "Hello, ${ID}. Now Start to check DB Connection!"

echo "" > ${TOTAL_RESULT_FILE_NAME}

IFS=,
while read server_ip
do
    if [ "${server_ip}" = "EOF" ]
    then
        exit
    fi

    echo "Trying Connecting to Server [${server_ip}] ..."
    ssh ${ID}@${server_ip} 'bash -s' < ${FIREWALL_TEST_SHELL_FILE_NAME} ${server_ip}
    scp ${ID}@${server_ip}:~/${TEMP_RESULT_FILE_NAME} ./
    cat ${TEMP_RESULT_FILE_NAME} >> ${TOTAL_RESULT_FILE_NAME}
    echo -e "\n\n\n" >> ${TOTAL_RESULT_FILE_NAME}
    rm ${TEMP_RESULT_FILE_NAME}
    echo "Disconnected From [${server_ip}] ..."
done < ${CONN_INFO_FILE_NAME}