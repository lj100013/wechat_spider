#!/bin/bash
source /etc/profile
cd /data/job_pro/dataX/iot
git pull
mvn clean install
cp /data/job_pro/dataX/iot/target/IOTFlowAPI.jar /data/job_pro/dataX/iot 