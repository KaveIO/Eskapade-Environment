#! /bin/bash

echo 'Building docker image'
docker build -t kave/eskapade-usr:0.9.2 .
docker tag kave/eskapade-usr:0.9.2 kave/eskapade-usr:latest

