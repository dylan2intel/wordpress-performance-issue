#!/bin/bash

function usage() {
  echo "Usage: $0 <apply|delete|destory>"
  exit 1
}

NC='\033[0m' # No Color
RED='\033[0;31m'
GREEN='\033[0;32m'

NAMESPACE=${NAMESPACE:-wordpress}
WORDPRESS_SVC_NAME=${WORDPRESS_SVC_NAME:-wordpress}
MYSQL_HOST_DIR=${MYSQL_HOST_DIR:-/mnt/data/mysql}
WORDPRESS_HOST_DIR=${WORDPRESS_HOST_DIR:-/mnt/data/wordpress}

function apply() {
  if [ ! -d $MYSQL_HOST_DIR ]; then
    sudo mkdir -p $MYSQL_HOST_DIR
  fi

  if [ ! -d $WORDPRESS_HOST_DIR ]; then
    sudo mkdir -p $WORDPRESS_HOST_DIR
  fi

  kubectl create namespace $NAMESPACE
  kubectl apply -k ./ -n $NAMESPACE
  kubectl get all -n $NAMESPACE
  rc=$?
  if [ "$rc" -eq 0 ]; then
    echo
    NODE_IP=$(kubectl get node -o=jsonpath='{.items[*].status.addresses[?(@.type=="InternalIP")].address}')
    NODE_PORT=$(kubectl get svc -n $NAMESPACE $WORDPRESS_SVC_NAME -o=jsonpath='{.spec.ports[].nodePort}')
    echo
    echo -e "${GREEN}Deploy successfully, open browser to visit this url to finish wordpress installation: \e[4mhttp://${NODE_IP}:${NODE_PORT}\e[0m ${NC}"
    echo
  fi
}

function delete() {
  if kubectl get namespace $NAMESPACE > /dev/null; then
    kubectl delete -k ./ -n $NAMESPACE
    if [ "$NAMESPACE" != "kube-system" ]; then # security delete namespace avoid deleting kube-system
        kubectl delete namespace $NAMESPACE --force --wait
    fi
  else
    echo "Namespace $NAMESPACE not found, skip to delete"
  fi
}

function destory() {
  read -r -p "${RED}!!!This option will destory all data, are you sure to continue? ${NC} [Y/n] " choice
  case $choice in 
    [yY][eE][sS]|[yY]) 
      delete
      set -x
      sudo rm -rf "${MYSQL_HOST_DIR:?}/" # security rm avoid removing /
      sudo rm -rf "${WORDPRESS_HOST_DIR:?}/"
      set +x
    ;;
    *)
      exit 1
    ;;
  esac
}

if [ $# -lt 1 ]; then
  usage
fi

option=$1
case $option in
  apply)
    apply
  ;;
  delete)
    delete
  ;;
  destory)
    destory
  ;;
  *)
    echo -e "${RED}unknown option $option ${NC}"; usage
esac
