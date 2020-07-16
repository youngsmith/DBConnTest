#!/bin/bash
ip=${1}
OUTPUT_FILE_NAME=output.txt

echo "${ip} : hi start!"
rm ${OUTPUT_FILE_NAME}

echo "[${ip}]" > ${OUTPUT_FILE_NAME}  

echo "couponredisperf00-0001-001.kitlrm.0001.apn2.cache.amazonaws.com 6379" >> ${OUTPUT_FILE_NAME}
sleep 1 | telnet couponredisperf00-0001-001.kitlrm.0001.apn2.cache.amazonaws.com 6379 >> ${OUTPUT_FILE_NAME}  

echo "couponredisperf00-0001-002.kitlrm.0001.apn2.cache.amazonaws.com 6379"  >> ${OUTPUT_FILE_NAME}  
sleep 1 | telnet couponredisperf00-0001-002.kitlrm.0001.apn2.cache.amazonaws.com 6379 >> ${OUTPUT_FILE_NAME}  

echo "couponredisperf00-0002-001.kitlrm.0001.apn2.cache.amazonaws.com 6379" >> ${OUTPUT_FILE_NAME}
sleep 1 | telnet couponredisperf00-0002-001.kitlrm.0001.apn2.cache.amazonaws.com 6379 >> ${OUTPUT_FILE_NAME}  

echo "couponredisperf00-0002-002.kitlrm.0001.apn2.cache.amazonaws.com 6379" >> ${OUTPUT_FILE_NAME}
sleep 1 | telnet couponredisperf00-0002-002.kitlrm.0001.apn2.cache.amazonaws.com 6379 >> ${OUTPUT_FILE_NAME}