FROM nvcr.io/nvidia/pytorch:23.10-py3

USER root

# Install s5cmd
RUN curl http://nginx.purestorage.int/repo1//s5cmd/2.0/s5cmd_2.1.0_Linux-64bit.tar.gz -O && \
   mkdir s5cmd && tar xv -f s5cmd_2.1.0_Linux-64bit.tar.gz -C ./s5cmd && \
   mv s5cmd/s5cmd /usr/bin && \
   rm -rf ./s5cmd && rm -f s5cmd_2.1.0_Linux-64bit.tar.gz

# Install native package used by Python
RUN apt update && apt install -y graphviz

# Install Jupyterlab packages
RUN python3 -m pip install --no-cache-dir \
	s3fs \
	jupyterlab \
	jupyterlab-s3-browser \
	ipywidgets

# Install nodejs as required by jupyterlab extension
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash -
RUN apt-get install -y nodejs

# Install torchdata and other ML libraries
RUN python3 -m pip install --no-cache-dir \
	torchdata \
	scikit-learn \
	seaborn \
	xgboost \
	graphviz \
	pyarrow \
	fastparquet \
	flask \
	category_encoders \
	openai \
	transformers==4.43.1 \
	accelerate \
	einops \
	langchain==0.2.5 \
	langchain_community==0.2.5 \
	bitsandbytes==0.43.1 \
	sentence_transformers==3.0.1 \
	chromadb \
	pymilvus==2.4.1 \
	pdfplumber \
	peft \
	trl


# Install Ray
RUN python3 -m pip install --no-cache-dir \
	ray[data,train,tune,serve]
