#!/usr/bin/env bash

#get nodes status
kubectl get nodes
#pull image from dockerhub
docker pull halzamly/springbootdemo
#create deployments
kubectl apply -f kubernetes/deployment.yaml
#get deployment status
kubectl get deployments