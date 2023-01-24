#!/bin/sh
# Installs all idp helm charts
## Usage: ./install.sh [kubeconfig]

if [ $# -ge 1 ] ; then
  export KUBECONFIG=$1
fi

NS=idp1201
CHART_VERSION=0.9.0

echo Create $NS namespace
kubectl create ns $NS

echo Istio label
kubectl label ns $NS istio-injection=disabled --overwrite
helm repo update

echo Copy configmaps
./copy_cm.sh

echo "Create configmaps mockida, delete if exists"
kubectl -n $NS  --ignore-not-found=true delete cm mock-auth-data
kubectl -n $NS create cm mock-auth-data --from-file=./mock-auth-data/

echo Installing IDP
helm dep up
helm -n $NS install idp . --version $CHART_VERSION


kubectl -n $NS  get deploy -o name |  xargs -n1 -t  kubectl -n $NS rollout status

echo Installed IDP service
