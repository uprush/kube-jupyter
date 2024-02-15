FROM harbor.purestorage.int/reddot/apache-spark:3.2.1-py

USER root

# See http://bugs.python.org/issue19846
ENV LANG C.UTF-8

# Install dependencies
RUN apt update && apt install -y curl 

# Install s5cmd
RUN mkdir -p /opt/s5cmd && \
	curl http://nginx.purestorage.int/repo1/s5cmd/v1.4.0/s5cmd_1.4.0_Linux-64bit.tar.gz \
	| tar xvz -C /opt/s5cmd  \
	&& ln -s /opt/s5cmd/s5cmd /usr/local/bin/s5cmd

# Install nodejs as required by jupyterlab extension
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get update && apt-get install -y nodejs

# Install Jupyterlab, S3 and other useful packages
RUN python3 -m pip install --no-cache-dir \
	s3fs \
	jupyterlab==3.0.12 \
	jupyterlab-s3-browser \
	trino \
	sparkmonitor \
	matplotlib \
	pandas \
	scikit-learn \
	scipy \
	seaborn \
	sqlalchemy

# Install Jupyterlab extensions
RUN jupyter nbextension install sparkmonitor --py && \
	jupyter nbextension enable  sparkmonitor --py && \
	jupyter serverextension enable --py --system jupyterlab_s3_browser && \
	jupyter lab build

RUN ipython profile create && \
	echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >>  $(ipython profile locate default)/ipython_kernel_config.py

RUN ln -s /usr/local/lib/python3.9/site-packages/sparkmonitor/listener_2.12.jar /opt/spark/jars/listener_2.12.jar

WORKDIR /ws
