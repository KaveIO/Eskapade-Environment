#! /bin/bash

echo 'Building docker image'
docker build --no-cache -t kave/eskapade-base:0.9.0 .
docker tag kave/root:0.9.0 kave/eskapade-base:latest

