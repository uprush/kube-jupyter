FROM harbor.purestorage.int/reddot/python3:3.10

USER root

# Install s5cmd
RUN curl http://nginx.purestorage.int/repo1//s5cmd/2.0/s5cmd_2.1.0_Linux-64bit.tar.gz -O && \
   mkdir s5cmd && tar xv -f s5cmd_2.1.0_Linux-64bit.tar.gz -C ./s5cmd && \
   mv s5cmd/s5cmd /usr/bin && \
   rm -rf ./s5cmd && rm -f s5cmd_2.1.0_Linux-64bit.tar.gz

# Install native package used by Python
RUN apt install -y graphviz

# Install Jupyterlab, S3 and ML packages
RUN python3 -m pip install --no-cache-dir \
	jupyterlab==3.0.12 \
	jupyter-server \
	jupyterlab-s3-browser \
	s3fs \
	scikit-learn \
	seaborn \
	xgboost \
	graphviz \
	pyarrow \
	fastparquet \
	flask

# Install Jupyterlab extensions
RUN jupyter serverextension enable --py --system jupyterlab_s3_browser && \
	jupyter lab build

# Install nodejs as required by jupyterlab extension
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash -
RUN apt-get install -y nodejs

# Install additional ML packages
RUN python3 -m pip install --no-cache-dir \
	category_encoders