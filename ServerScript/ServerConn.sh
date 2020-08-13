#!/bin/bash

IFS=,
DB_CONN_TEST_RESULT_FILE_NAME=DBConnTestResult.txt
TEMP_FILE_NAME=output.txt
DB_CONN_SHELL_FILE_NAME=ExecuteCommands.sh
CONN_INFO_FILE_NAME=ConnInfoList.txt

echo "Script is Starting ... : $(date)" 


ID=yyjjang

echo "Hello, ${ID}. Now Start to check DB Connection!"

echo "" > ${DB_CONN_TEST_RESULT_FILE_NAME}

while read server_ip db_ip port sql
do
    if [ "${server_ip}" = "EOF" ]
    then
        exit
    fi

    echo "Trying Connecting to Server [${server_ip}] ..."
    ssh ${ID}@${server_ip} 'bash -s' < ${DB_CONN_SHELL_FILE_NAME}
    echo "Disconnected From [${server_ip}] ..."
done < ${CONN_INFO_FILE_NAME}
