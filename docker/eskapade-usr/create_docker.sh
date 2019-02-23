#! /bin/bash

echo 'Building docker image'
docker build -t kave/eskapade-usr:1.0.0 .
docker tag kave/eskapade-usr:1.0.0 kave/eskapade-usr:latest

