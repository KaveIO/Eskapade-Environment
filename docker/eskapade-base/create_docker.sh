#! /bin/bash

echo 'Building docker image'
docker build --no-cache -t kave/eskapade-base:1.0.0 .
docker tag kave/eskapade-base:1.0.0 kave/eskapade-base:latest

# --- to push to dockerhub, type:
# % docker push kave/eskapade-base:1.0.0
# % docker push kave/eskapade-base:latest
