FROM nvcr.io/nvidia/pytorch:24.02-py3

USER root

# Install Jupyterlab, S3 and mlflow packages
RUN python3 -m pip install --no-cache-dir \
	jupyterlab \
	torchdata \
	scikit-learn \
	seaborn \
	xgboost

# Add 'jupyter' user so that this does not run as root.
RUN groupadd -g 1000 jupyter && \
    useradd -r -m -u 1000 -g jupyter jupyter && \
    mkdir -p /home/jupyter && \
    chown jupyter:jupyter /home/jupyter

USER jupyter
