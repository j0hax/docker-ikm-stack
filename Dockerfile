FROM jupyter/datascience-notebook:latest

USER root

# Neues Lab-Interface aktivieren
ENV JUPYTER_ENABLE_LAB=yes

COPY overrides.json /opt/conda/share/jupyter/lab/settings/

# Uni Hannover Mirror verwenden
RUN sed -i 's/http:\/\/archive.ubuntu.com\/ubuntu\//https:\/\/ftp.uni-hannover.de\/ubuntu\//g' /etc/apt/sources.list

# Installiere zusätzliche Pakete
RUN apt-get -y update && apt-get install --no-install-recommends -y octave zsh golang htop locales && apt-get clean && rm -rf /var/lib/apt/lists/*

# System auf Deutsch stellen
RUN echo "Europe/Berlin" > /etc/timezone && \
    echo -e "de_DE.UTF-8 UTF-8\nen_US.UTF-8 UTF-8" > /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales

# Julia-Abhängigkeiten Installieren
COPY packages.jl /tmp/packages.jl
ENV JULIA_NUM_THREADS=auto
RUN julia /tmp/packages.jl

# Zusatz-Features aktivieren
COPY requirements.txt /tmp/requirements.txt
RUN mamba install -y -c conda-forge --file /tmp/requirements.txt && mamba clean -a -y

# Golang installieren
RUN env GO111MODULE=on go get github.com/gopherdata/gophernotes && mkdir -p ~/.local/share/jupyter/kernels/gophernotes && cd ~/.local/share/jupyter/kernels/gophernotes && cp "$(go env GOPATH)"/pkg/mod/github.com/gopherdata/gophernotes@v0.7.4/kernel/*  "." && chmod +w ./kernel.json && sed "s|gophernotes|$(go env GOPATH)/bin/gophernotes|" < kernel.json.in > kernel.json

COPY logos/ikm /etc/motd

COPY logos/lfortran-32.png /opt/conda/share/jupyter/kernels/fortran/logo-32x32.png
COPY logos/lfortran-64.png /opt/conda/share/jupyter/kernels/fortran/logo-64x64.png

USER jovyan
COPY .zshrc $HOME/.zshrc
ENV SHELL=zsh

WORKDIR $HOME/work
