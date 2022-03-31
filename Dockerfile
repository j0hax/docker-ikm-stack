FROM jupyter/datascience-notebook:f51aa480b7b5

# Neues Lab-Interface aktivieren
ENV JUPYTER_ENABLE_LAB=yes

COPY overrides.json /opt/conda/share/jupyter/lab/settings/

USER root

# Uni Hannover Mirror verwenden
RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//https:\/\/ftp.uni-hannover.de\/ubuntu\//g' /etc/apt/sources.list

# Installiere zusätzliche Pakete
RUN apt-get -y update && apt-get install --no-install-recommends -y octave zsh htop locales && apt-get clean && rm -rf /var/lib/apt/lists/*

# Setze Sprache auf Deutsch
RUN echo -e "de_DE.UTF-8 UTF-8\nen_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen && update-locale LANG=de_DE.UTF-8
USER jovyan

# Julia-Abhängigkeiten Installieren
COPY packages.jl /tmp/packages.jl
ENV JULIA_NUM_THREADS=auto
RUN julia /tmp/packages.jl

# Zusatz-Features aktivieren
COPY requirements.txt /tmp/requirements.txt
RUN mamba install -y -c conda-forge --file /tmp/requirements.txt && mamba clean -a -y

COPY logos/ikm /etc/motd
COPY .zshrc $HOME/.zshrc

COPY logos/lfortran-32.png /opt/conda/share/jupyter/kernels/fortran/logo-32x32.png
COPY logos/lfortran-64.png /opt/conda/share/jupyter/kernels/fortran/logo-64x64.png

ENV SHELL=zsh

WORKDIR $HOME/work
