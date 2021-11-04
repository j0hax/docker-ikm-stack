FROM jupyter/datascience-notebook

# Neues Lab-Interface aktivieren
ENV JUPYTER_ENABLE_LAB=yes

COPY README.md /home/jovyan
COPY overrides.json /opt/conda/share/jupyter/lab/settings/

# Julia-Abhängigkeiten Installieren
RUN julia -e 'import Pkg; Pkg.add("Plots")'
RUN julia -e 'import Pkg; Pkg.add("PlotlyBase")'
RUN julia -e 'import Pkg; Pkg.add("GenericLinearAlgebra")'
RUN julia -e 'import Pkg; Pkg.add("WriteVTK")'
RUN julia -e 'using Pkg; Pkg.add("LanguageServer")'

# Zusatz-Features aktivieren
COPY plugins.txt /tmp
RUN pip install --no-cache-dir -r /tmp/plugins.txt
COPY logo /etc/motd
RUN echo "cat /etc/motd" >> .profile
