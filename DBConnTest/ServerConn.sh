#!/bin/bash

IFS=,
DB_CONN_TEST_RESULT_FILE_NAME=DBConnTestResult.txt
TEMP_FILE_NAME=output.txt
DB_CONN_SHELL_FILE_NAME=DBConn.sh
CONN_INFO_FILE_NAME=ConnInfoList.txt

echo "Script is Starting ... : $(date)" 

idx=1
# while read ID user password
# do
#     if [ "${idx}" -eq 1 ]
#     then
#         break
#     fi
# done < ${CONN_INFO_FILE_NAME}
ID=yyjjang
user=app_deal
password=DpA#Hq_c_2M-Eh9^


echo "Hello, ${ID}. Now Start to check DB Connection!"

echo "" > ${DB_CONN_TEST_RESULT_FILE_NAME}

while read server_ip db_ip port sql
do
    # if [ "${idx}" -eq 1 ]
    # then
    #     idx=2
    #     continue
    # fi

    if [ "${server_ip}" = "EOF" ]
    then
        exit
    fi

    echo "Trying Connecting to Server [${server_ip}] ..."
    ssh ${ID}@${server_ip} 'bash -s' < ${DB_CONN_SHELL_FILE_NAME} ${db_ip} ${port} ${user} \'${password}\'  \'${sql}\'
    
    # download result file
    scp ${ID}@${server_ip}:~/${TEMP_FILE_NAME} ./

    # append query result to DB_CONN_TEST_RESULT_FILE_NAME 
    echo "[${server_ip} => ${db_ip}:${port}]" >> ${DB_CONN_TEST_RESULT_FILE_NAME} 
    cat ${TEMP_FILE_NAME} >> ${DB_CONN_TEST_RESULT_FILE_NAME}
    echo -e "\n\n\n" >> ${DB_CONN_TEST_RESULT_FILE_NAME}
    
    rm ${TEMP_FILE_NAME}

    echo "Disconnected From [${server_ip}] ..."
done < ${CONN_INFO_FILE_NAME}
