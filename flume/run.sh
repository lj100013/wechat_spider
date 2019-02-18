#!/bin/bash 
dt=2018-05-22
hive -hiveconf hive.exec.mode.local.auto=true -hivevar dt=$dt -f /data/job_pro/dataX/flume/flume_remove.hql
