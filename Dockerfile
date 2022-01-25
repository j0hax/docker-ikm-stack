FROM jupyter/datascience-notebook:f51aa480b7b5

# Neues Lab-Interface aktivieren
ENV JUPYTER_ENABLE_LAB=yes

COPY overrides.json /opt/conda/share/jupyter/lab/settings/

USER root

# System auf deutsch stellen
RUN locale-gen de_DE.UTF-8
RUN update-locale LC_ALL=de_DE.UTF-8
ENV LANG=de_DE.UTF-8
ENV LC_ALL=de_DE.UTF-8

# Installiere zusätzliche Pakete
RUN apt-get -y update && apt-get -y install octave
USER jovyan

# Julia-Abhängigkeiten Installieren
COPY packages.jl /tmp/packages.jl
ENV JULIA_NUM_THREADS=auto
RUN julia /tmp/packages.jl

# Zusatz-Features aktivieren
COPY requirements.txt /tmp/requirements.txt
RUN mamba install -c conda-forge --file /tmp/requirements.txt

RUN mamba clean -a -y

COPY logo /etc/motd
RUN echo "cat /etc/motd" >> .profile

COPY profile.local /etc/profile.d/ikm-global.sh

ENV HISTFILE=$HOME/work/.bash_history

WORKDIR $HOME/work
