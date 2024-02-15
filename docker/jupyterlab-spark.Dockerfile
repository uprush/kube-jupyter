FROM 730335570797.dkr.ecr.ap-southeast-1.amazonaws.com/apache-spark:3.4.1-py

USER root

# See http://bugs.python.org/issue19846
# ENV LANG C.UTF-8

# Install dependencies
RUN apt update && apt install -y curl 

# Install s5cmd
RUN mkdir -p /opt/s5cmd && \
	curl http://nginx.purestorage.int/repo1/s5cmd/2.2/s5cmd_2.2.2_Linux-64bit.tar.gz \
	| tar xvz -C /opt/s5cmd  \
	&& ln -s /opt/s5cmd/s5cmd /usr/local/bin/s5cmd

# Install nodejs as required by jupyterlab extension
RUN curl -sL https://deb.nodesource.com/setup_18.x | bash -
RUN apt update && apt install -y nodejs

# Install Jupyterlab, S3 and other useful packages
RUN pip3 install --no-cache-dir \
	s3fs \
	jupyterlab==3.6.6 \
	jupyterlab-s3-browser==0.12.0 \
	trino \
	sparkmonitor==2.1.1 \
	matplotlib \
	pandas \
	scikit-learn \
	scipy \
	seaborn \
	sqlalchemy \
	panel \
	hvplot

# Install Jupyterlab extensions
# See also: https://pypi.org/project/sparkmonitor/
RUN ipython profile create && \
	echo "c.InteractiveShellApp.extensions.append('sparkmonitor.kernelextension')" >>  $(ipython profile locate default)/ipython_kernel_config.py

RUN jupyter nbextension install sparkmonitor --py && \
	jupyter nbextension enable  sparkmonitor --py && \
	jupyter serverextension enable --py --system jupyterlab_s3_browser && \
	jupyter lab build


RUN ln -s /usr/local/lib/python3.8/site-packages/sparkmonitor/listener_2.12.jar /opt/spark/jars/listener_2.12.jar

WORKDIR /ws
