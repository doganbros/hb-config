#!/bin/bash

calc(){ awk "BEGIN { print "$*" }"; }
FREE_MEMORY=$(free -m | awk 'FNR == 2 {print $2}')
USED_MEMORY=$(free -m | awk 'FNR == 2 {print $3}')
MEMORY_UTILIZATION=$(calc $USED_MEMORY/$FREE_MEMORY)
CLOUDWATCH_METRIC_NAME="Memory_Utilization"
echo "$USED_MEMORY in use out of $FREE_MEMORY. Memory Util is $MEMORY_UTILIZATION"


report_to_cloudwatch(){
    aws cloudwatch put-metric-data \
        --metric-name  $CLOUDWATCH_METRIC_NAME \
        --dimensions app="EKS-Nodegroups" \
        --namespace "Custom" \
        --value $1 \
        --region eu-central-1
}

report_to_cloudwatch $MEMORY_UTILIZATION
