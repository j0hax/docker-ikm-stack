FROM jupyter/datascience-notebook:f51aa480b7b5

# Neues Lab-Interface aktivieren
ENV JUPYTER_ENABLE_LAB=yes

COPY overrides.json /opt/conda/share/jupyter/lab/settings/

USER root

# Uni Hannover Mirror verwenden
RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//https:\/\/ftp.uni-hannover.de\/ubuntu\//g' /etc/apt/sources.list

# System auf deutsch stellen
RUN locale-gen de_DE.UTF-8
RUN update-locale LC_ALL=de_DE.UTF-8
ENV LANG=de_DE.UTF-8
ENV LC_ALL=de_DE.UTF-8

# Installiere zusätzliche Pakete
RUN apt-get -y update && apt-get install -y octave zsh && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN chsh -s /usr/bin/zsh jovyan
USER jovyan

# Julia-Abhängigkeiten Installieren
COPY packages.jl /tmp/packages.jl
ENV JULIA_NUM_THREADS=auto
RUN julia /tmp/packages.jl

# Zusatz-Features aktivieren
COPY requirements.txt /tmp/requirements.txt
RUN mamba install -c conda-forge --file /tmp/requirements.txt

RUN mamba clean -a -y

COPY logos/ikm /etc/motd
RUN echo "cat /etc/motd" >> .profile
COPY profile.local /etc/profile.d/ikm-global.sh
RUN touch .zshrc

COPY logos/lfortran-32.png /opt/conda/share/jupyter/kernels/fortran/logo-32x32.png
COPY logos/lfortran-64.png /opt/conda/share/jupyter/kernels/fortran/logo-64x64.png

ENV HISTFILE=$HOME/work/.bash_history

WORKDIR $HOME/work
