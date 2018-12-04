#! /bin/bash

echo 'Building docker image'
docker build --no-cache -t kave/root:6.14.06 .
docker tag kave/root:6.14.06 kave/root:latest

