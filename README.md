Jupyter Notebook
====
Jupyter notebook on k8s.

# Enable S3 browser in JupyterLab.
[JupyterLab S3 Brower](https://www.npmjs.com/package/jupyterlab-s3-browser) is a JupyterLab extension for browsing S3-compatible object storage.

Enable - rebuild - refresh S3 browser.
```bash
kubectl -n bds exec -it jupyter-tf-d564894cb-62lsw -- bash
jupyter serverextension enable --py jupyterlab_s3_browser
jupyter lab build
```

Go to JupyterLab UI, Extension - Enable third party extension.
