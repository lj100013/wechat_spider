#!/bin/bash
source /etc/profile
cd /data/job_pro/dataX/iot/IOTFlowAPI
git pull
mvn clean install
rm /data/job_pro/dataX/iot/IOTFlowAPI.jar
cp /data/job_pro/dataX/iot/IOTFlowAPI/target/IOTFlowAPI.jar /data/job_pro/dataX/iot 