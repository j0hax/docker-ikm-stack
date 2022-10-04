FROM jupyter/datascience-notebook:latest

# Benutzerdefinierte Einstellungen einrichten
COPY overrides.json /opt/conda/share/jupyter/lab/settings/
ENV JULIA_NUM_THREADS=auto

# Installiere Abhängigkeiten
USER root

# Linux bzw. Apt
RUN apt-get update && apt-get install -y octave && rm -rf /var/lib/apt/lists/*

# Julia
RUN julia --project -e "using Pkg; Pkg.add([\"Plots\", \"PlotlyJS\", \"GenericLinearAlgebra\", \"WriteVTK\", \"LanguageServer\"])"

# Python
COPY requirements.txt /tmp/requirements.txt
RUN mamba install -y --file /tmp/requirements.txt && mamba clean -a -y

# Kopiere Logos
COPY logos/lfortran-32.png /opt/conda/share/jupyter/kernels/fortran/logo-32x32.png
COPY logos/lfortran-64.png /opt/conda/share/jupyter/kernels/fortran/logo-64x64.png

USER jovyan

WORKDIR $HOME/work
