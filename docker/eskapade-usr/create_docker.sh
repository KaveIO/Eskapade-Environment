#! /bin/bash

echo 'Building docker image'
docker build -t kave/eskapade-usr:0.8.5 .
docker tag kave/eskapade-usr:0.8.5 kave/eskapade-usr:latest

