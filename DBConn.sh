#!/bin/bash

TEMP_FILE_NAME=output.txt
TARGET_OS=Ubuntu

# DB Info
host=$1
port=$2
user=$3
password=$4
unprocessed_sql=$5
ERROR=NONE
DB_CONNECTION_INFO_FILE_NAME=extra_file

# fail process function
function fail_processing() {
    ERROR_MESSAGE="ERROR : $1"
    echo "${ERROR_MESSAGE}"
    echo ${ERROR_MESSAGE} > ${TEMP_FILE_NAME}
    exit
}

# check if OS is unbuntu
OS=$(lsb_release -a | grep 'Distributor ID' | grep ${TARGET_OS})
if [ "${OS}" == *"${TARGET_OS}"* ]
then 
    fail_processing "Current OS is not ${TARGET_OS} !"
else
    echo "Current OS is ${TARGET_OS}"
fi


# check if user has super user auth


# mysql_config_editor set --login-path=test --user=app_dsc_search --password --port=3307 --host=192.168.200.32
# mysql --login-path=test
echo "Successfully Connected At : [$host:$port] !"
cat > ${DB_CONNECTION_INFO_FILE_NAME} << EOF
[client]
host=$host
port=$port
user=$user
password=$password

[mysql]
connect_timeout=3
EOF

if [ -f "${DB_CONNECTION_INFO_FILE_NAME}" ]
then
    echo "Successfully Made ${DB_CONNECTION_INFO_FILE_NAME}!"
    sudo chmod 644 ${DB_CONNECTION_INFO_FILE_NAME}
else
    fail_processing "${DB_CONNECTION_INFO_FILE_NAME} Is Not Made !"
fi


for i in {1..10}
do
    command_mysql_exist=$(command -v mysql)
    if [ -z "${command_mysql_exist}" ]
    then
        if [ "$i" -eq 10 ]
        then 
            fail_processing "Can Not Install mysql!"
        fi

        echo -e "mysql is not installed! \nTrying Installing mysql..."
        sudo apt-get update
        sudo apt-get install mysql-server
    else
        echo "mysql is already installed!"
        break
    fi
done


# Connecting DB Server and Executing Query
echo "Trying Connecting to DB Server [$host:$port] ...!"

# Test Connection
# query_result=$($MYSQL --defaults-extra-file=${DB_CONNECTION_INFO_FILE_NAME} << EOF

echo "${unprocessed_sql} : NOW Executing SQL!"
MYSQL=$(which mysql)

echo "" > ${TEMP_FILE_NAME}
IFS=';' read -ra sql_list <<< "${unprocessed_sql}"
for sql in "${sql_list[@]}"
do
    sql="${sql};"
    echo "${sql}"
    query_result=$($MYSQL --defaults-extra-file=${DB_CONNECTION_INFO_FILE_NAME} << EOF
${sql}
EOF
)
    cat >> ${TEMP_FILE_NAME} << EOF
[${sql}]
${query_result}

EOF

done

echo "Disconnecting From [$host:$port] ...!" 