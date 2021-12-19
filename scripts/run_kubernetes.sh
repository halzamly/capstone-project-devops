#!/usr/bin/env bash

# This script run the Docker Hub container with kubernetes

# Docker ID/path
dockerpath="halzamly/springbootdemo"
# for windows
#set dockerpath="halzamly/springbootdemo"

# Run the Docker Hub container with kubernetes
kubectl run capstone --image=$dockerpath --port=80 --labels app=capstone-udacity
# for windows
#kubectl run capstone --image=%dockerpath% --port=80 --labels app=capstone-udacity
#kubectl run capstone --image=halzamly/springbootdemo --port=80 --labels app=capstone-udacity

# List kubernetes pods
kubectl get pods

# Forward the container port to a host
kubectl port-forward capstone 80:80