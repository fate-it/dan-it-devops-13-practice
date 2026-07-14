#!/usr/bin/env bash

set -e

echo "Створення локального Kubernetes-кластеру"

minikube start \
  --driver=docker \
  --cpus=2 \
  --memory=2048

echo
echo "Информація про кластер:"
kubectl cluster-info

echo
echo "Список вузлів:"
kubectl get nodes -o wide

echo
echo "Статус Minikube:"
minikube status
