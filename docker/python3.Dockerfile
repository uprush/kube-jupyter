FROM ubuntu:22.04

USER root

# Install Python3
RUN apt update && apt install -y curl python3.10 python3-pip
