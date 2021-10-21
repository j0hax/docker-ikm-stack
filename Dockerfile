FROM jupyter/datascience-notebook

# JupyterHub erforderlich
RUN pip install jupyterhub
RUN pip install ipyparallel

# Julia-Abhängigkeiten Installieren
RUN julia -e 'import Pkg; Pkg.add("Plots")'
