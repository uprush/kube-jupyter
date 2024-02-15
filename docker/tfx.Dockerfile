FROM tensorflow/tensorflow:2.12.0-jupyter

USER root

# Install s5cmd
RUN curl http://nginx.purestorage.int/repo1//s5cmd/2.0/s5cmd_2.1.0_Linux-64bit.tar.gz -O && \
   mkdir s5cmd && tar xv -f s5cmd_2.1.0_Linux-64bit.tar.gz -C ./s5cmd && \
   mv s5cmd/s5cmd /usr/bin && \
   rm -rf ./s5cmd && rm -f s5cmd_2.1.0_Linux-64bit.tar.gz

# Install Jupyterlab, S3 and mlflow packages
RUN python3 -m pip install --no-cache-dir \
	jupyterlab \
	s3fs \
	jupyterlab-s3-browser

# Install nodejs as required by jupyterlab extension
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Install tfx
RUN python3 -m pip install --no-cache-dir \
	tfx \
	apache-beam[interactive] \
	tensorflow-io \
	scikit-learn \
	seaborn \
	xgboost \
	graphviz
