#!/bin/bash

# Store S3 access key in secret
kubectl create secret generic bds-s3 \
	--from-literal=access-key='xxxxxxxxx' \
	--from-literal=secret-key='mmmmmmmm'
