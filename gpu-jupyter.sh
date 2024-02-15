#!/bin/bash

docker run -d \
  --name jupyter-tf \
  --gpus all \
  --network host \
  -v /fbd/deephub/datasets:/tf/datasets \
  -v /fbd/jupyter:/tf/workspace \
  harbor.purestorage.int/reddot/tensorflow:22.08-tf2-py3
