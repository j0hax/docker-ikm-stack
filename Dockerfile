FROM jupyter/datascience-notebook

# JupyterHub erforderlich
RUN pip install jupyterhub

# Julia-Abhängigkeiten Installieren
RUN julia -e 'import Pkg; Pkg.add("Plots")'

# Zusatz-Features aktivieren
RUN pip install ipyparallel
RUN pip install jupyter_contrib_nbextensions
RUN jupyter contrib nbextension install --user
RUN pip install jupyterlab_latex
