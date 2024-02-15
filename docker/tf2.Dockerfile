FROM nvcr.io/nvidia/tensorflow:23.05-tf2-py3

USER root

# Install tfx
RUN python3 -m pip install --no-cache-dir \
	tfx

# Install Pure Rapidfile toolkit
RUN curl http://nginx.purestorage.int/repo1/rapidfile/2.0/rapidfile-toolkit_2.1.0-3_amd64.deb -O
RUN dpkg -i rapidfile-toolkit_2.1.0-3_amd64.deb && \
	rm -f rapidfile-toolkit_2.1.0-3_amd64.deb 

# Install s5cmd
RUN curl http://nginx.purestorage.int/repo1//s5cmd/2.0/s5cmd_2.1.0_Linux-64bit.tar.gz -O && \
   mkdir s5cmd && tar xv -f s5cmd_2.1.0_Linux-64bit.tar.gz -C ./s5cmd && \
   mv s5cmd/s5cmd /usr/bin && \
   rm -rf ./s5cmd && rm -f s5cmd_2.1.0_Linux-64bit.tar.gz

# Install Jupyterlab, S3 and mlflow packages
RUN python3 -m pip install --no-cache-dir \
	s3fs \
	jupyterlab-s3-browser

# Install nodejs as required by jupyterlab extension
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs
