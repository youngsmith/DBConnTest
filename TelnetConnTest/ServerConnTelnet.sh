#!/bin/bash

IFS=,
DB_CONN_TEST_RESULT_FILE_NAME=DBConnTestResult.txt
TEMP_FILE_NAME=output.txt
TELNET_CONN_SHELL_FILE_NAME=Telnet.sh
CONN_INFO_FILE_NAME=ConnInfoList.txt

echo "Script is Starting ... : $(date)" 

ip=192.168.1.60
ID=yyjjang

echo ${ip} ${ID}


echo "Hello, ${ID}. Now Start to check DB Connection!"

echo "" > ${DB_CONN_TEST_RESULT_FILE_NAME}

while read server_ip
do
    if [ "${server_ip}" = "EOF" ]
    then
        exit
    fi

    echo "Trying Connecting to Server [${server_ip}] ..."
    ssh ${ID}@${server_ip} 'bash -s' < ${TELNET_CONN_SHELL_FILE_NAME} ${server_ip}
    # download result file
    scp ${ID}@${server_ip}:~/${TEMP_FILE_NAME} ./
    
    # append query result to DB_CONN_TEST_RESULT_FILE_NAME 
    cat ${TEMP_FILE_NAME} >> ${DB_CONN_TEST_RESULT_FILE_NAME}
    echo -e "\n\n\n" >> ${DB_CONN_TEST_RESULT_FILE_NAME}
    
    rm ${TEMP_FILE_NAME}

    echo "Disconnected From [${server_ip}] ..."
done < ${CONN_INFO_FILE_NAME}
