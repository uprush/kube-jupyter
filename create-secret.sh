#!/bin/bash

# Store S3 access key in secret
kubectl -n bds create secret generic bds-s3 \
	--from-literal=access-key='xxxxxxxxx' \
	--from-literal=secret-key='mmmmmmmm'

# OpenAI Key
kubectl -n bds create secret generic openai-yijiang \
	--from-literal=api-key='xxxxx'
