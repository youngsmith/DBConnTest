#!/bin/bash
ip=${1}
OUTPUT_FILE_NAME=output.txt

echo "${ip} : hi start!"
rm ${OUTPUT_FILE_NAME}

echo "[${ip}]" > ${OUTPUT_FILE_NAME}  
