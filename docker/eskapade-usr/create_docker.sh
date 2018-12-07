#! /bin/bash

echo 'Building docker image'
docker build -t kave/eskapade-usr:0.9.0 .
docker tag kave/eskapade-usr:0.9.0 kave/eskapade-usr:latest

