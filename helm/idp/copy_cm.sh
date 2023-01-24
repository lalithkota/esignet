#!/bin/sh
# Copy configmaps from other namespaces
# DST_NS: Destination namespace 

COPY_UTIL=../copy_cm_func.sh
DST_NS=idp1201

$COPY_UTIL configmap global config-server1201 $DST_NS 
$COPY_UTIL configmap artifactory-share artifactory1201 $DST_NS 
$COPY_UTIL configmap config-server-share config-server1201 $DST_NS
$COPY_UTIL configmap softhsm-idp-share softhsm1201 $DST_NS
