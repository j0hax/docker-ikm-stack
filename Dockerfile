FROM jupyter/datascience-notebook

# Neues Lab-Interface aktivieren
ENV JUPYTER_ENABLE_LAB=yes

COPY overrides.json /opt/conda/share/jupyter/lab/settings/

# Installiere zusätzliche Pakete
USER root
RUN apt-get -y update && apt-get -y install octave
USER jovyan

# Julia-Abhängigkeiten Installieren
COPY packages.jl /tmp/packages.jl
RUN julia /tmp/packages.jl

# Zusatz-Features aktivieren
COPY plugins.txt /tmp/plugins.txt
RUN pip install --no-cache-dir -r /tmp/plugins.txt
COPY logo /etc/motd
RUN echo "cat /etc/motd" >> .profile

WORKDIR $HOME/work
