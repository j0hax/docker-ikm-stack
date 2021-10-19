FROM jupyter/datascience-notebook

# JupyterHub erforderlich
RUN pip3 install jupyterhub

# Julia-Abhängigkeiten Installieren
RUN julia -e 'import Pkg; Pkg.add("Plots")'
