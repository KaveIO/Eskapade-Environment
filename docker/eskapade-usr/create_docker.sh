#! /bin/bash

echo 'Building docker image'
docker build -t kave/eskapade-usr:0.9.1 .
docker tag kave/eskapade-usr:0.9.1 kave/eskapade-usr:latest

