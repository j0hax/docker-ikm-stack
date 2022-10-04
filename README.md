# docker-ikm-stack

![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/j0hax/docker-ikm-stack) ![Docker Pulls](https://img.shields.io/docker/pulls/j0hax/docker-ikm-stack)

Betriebsbereites Docker-Image für Jupyter-Anwendungen innerhalb des IKMs. Hauptsächlich auf [jupyter/datascience-notebook](https://jupyter-docker-stacks.readthedocs.io/en/latest/using/selecting.html#jupyter-datascience-notebook) basierend.

## Software

Folgendes Software wird unterstützt:

- Programmiersprachen *Julia*, *Python*, *R* sowie *GNU Octave* und *Fortran*
- LaTeX Bearbeitung

### Sprachen

Das Image kommt mit Deutschen und Englischen sprachpaketen.

## Inbetriebname

Dieses Projekt wird in erster Linie als Benutzerumgebung für eine vom IKM maßgenscheiderte, dockerizierte JupyterHub-Instanz verwendet.

Es kann jedoch auch für einen einzelnen Benutzer verwendet werden, indem man das Image baut und mit Docker (oder Podman) ausführt und den Link verwendet:

```console
docker run -p 8888:8888 $(docker build -q .)
Entered start.sh with args: jupyter lab
Executing the command: jupyter lab
...
    To access the server, open this file in a browser:
    ...
     or http://127.0.0.1:8888/lab?token=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

```
