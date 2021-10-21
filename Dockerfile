FROM jupyter/datascience-notebook

# Neues Lab-Interface aktivieren
ENV JUPYTER_ENABLE_LAB=yes

COPY README.md /home/jovyan
COPY overrides.json /opt/conda/share/jupyter/lab/settings/

# Julia-Abhängigkeiten Installieren
RUN julia -e 'import Pkg; Pkg.add("Plots")'

# Zusatz-Features aktivieren
COPY plugins.txt /tmp
RUN pip install -r /tmp/plugins.txt
