#! /usr/bin/bash
#! /data/anaconda/bin
cd /data/job_pro/dataX/yishiyun-spider
rm -rf config.ini
cp /data/job_pro/utils/config.ini .

python3 main.py