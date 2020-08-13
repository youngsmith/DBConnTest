#!/bin/bash

CONN_INFO_FILE_NAME=ConnInfoList.txt
CORE_SCRIPT_FILE_NAME='./data/Core'
TELNET_SCRIPT_FILE_NAME='./data/Telnet.sh'
EXECUTE_SCRIPT_FILE_NAME=Execute.sh
NL='\n'


function read_conn_info_file() {
    line_num=$(awk "BEGIN {IGNORECASE = 1} /$1/ {print NR}" ${CONN_INFO_FILE_NAME})

    while [ true ] 
    do
        line_num=$((${line_num}+1))
        line=$(awk "NR==${line_num}" ${CONN_INFO_FILE_NAME})
        if [ -z "${line}" ]
        then
            break
        else
            eval "$2+=(${line})"
        fi
    done
}


# ConnInfoList 파일 존재 확인
# 파일 존재
# parsing - id, start-server, target-server
read_conn_info_file 'id' ID
read_conn_info_file 'start-server' start_server_ip_list
read_conn_info_file 'target-server' target_server_ip_list

TELNET_SCRIPT=''
while read line
do 
    TELNET_SCRIPT+=$(echo "${line//\$/\\\$}")
    TELNET_SCRIPT+="${NL}"
done < "${TELNET_SCRIPT_FILE_NAME}"

TELNET_SCRIPT=$(echo -e "${TELNET_SCRIPT}")
echo "${TELNET_SCRIPT}"

#TELNET_SCRIPT 를 나중에 붙이면 생기는 이슈 확인.
read -r -d '' data_template << EOF
#!/bin/bash
TELNET_SCRIPT="${TELNET_SCRIPT}"
ID=${ID}
start_server_ip_list=(${start_server_ip_list[@]})
target_server_ip_list=(${target_server_ip_list[@]})
EOF

echo ${data_template} > ${EXECUTE_SCRIPT_FILE_NAME}
cat "${CORE_SCRIPT_FILE_NAME}" >> ${EXECUTE_SCRIPT_FILE_NAME}

sudo chmod 777 ${EXECUTE_SCRIPT_FILE_NAME}



# make shell script



# 파일 없음
# 빈 템플릿 파일 생성