FROM jupyter/datascience-notebook

ARG proxy=http://secure-proxy.rrzn.uni-hannover.de:3131

# Neues Lab-Interface aktivieren
ENV JUPYTER_ENABLE_LAB=yes

# Julia-Abhängigkeiten Installieren
RUN julia -e 'import Pkg; Pkg.add("Plots")'

# Zusatz-Features aktivieren
COPY plugins.txt /tmp
RUN pip install -r /tmp/plugins.txt

# Proxy-Variablen verwenden
ENV HTTP_PROXY=${proxy}
ENV HTTPS_PROXY=${proxy}


