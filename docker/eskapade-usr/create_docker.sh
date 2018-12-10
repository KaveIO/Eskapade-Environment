#! /bin/bash

echo 'Building docker image'
docker build -t kave/eskapade-usr:0.9.3 .
docker tag kave/eskapade-usr:0.9.3 kave/eskapade-usr:latest

