FROM jupyter/datascience-notebook

# Neues Lab-Interface aktivieren
ENV JUPYTER_ENABLE_LAB=yes

COPY overrides.json /opt/conda/share/jupyter/lab/settings/

# Installiere zusätzliche Pakete
USER root
RUN apt update
RUN apt-get -y install octave
RUN wget https://github.com/sharkdp/hyperfine/releases/download/v1.12.0/hyperfine_1.12.0_amd64.deb -O /tmp/hyperfine.deb
RUN dpkg -i /tmp/hyperfine.deb
USER jovyan

# Julia-Abhängigkeiten Installieren
RUN julia -e 'import Pkg; Pkg.add("Plots")'
RUN julia -e 'import Pkg; Pkg.add("PlotlyJS")'
RUN julia -e 'import Pkg; Pkg.add("GenericLinearAlgebra")'
RUN julia -e 'import Pkg; Pkg.add("WriteVTK")'
RUN julia -e 'using Pkg; Pkg.add("LanguageServer")'

# Zusatz-Features aktivieren
COPY plugins.txt /tmp
RUN pip install --no-cache-dir -r /tmp/plugins.txt
COPY logo /etc/motd
RUN echo "cat /etc/motd" >> .profile

WORKDIR $HOME/work
