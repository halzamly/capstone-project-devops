#!/usr/bin/env bash

# Build image and add a descriptive tag
docker build --tag=halzamly/springbootdemo ..

# List docker images
docker image ls

# Run Spring-boot app
docker run -p 80:80 halzamly/springbootdemo

#Run Docket container in interactive mode
#docker run -d -p 80:80 --name springboot halzamly/springbootdemo
#docker exec -it springboot bash