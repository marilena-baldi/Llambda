FROM ubuntu:22.04
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
  apt-get install -y \
  g++ \
  make \
  cmake \
  unzip \
  libcurl4-openssl-dev \
  python3 \
  python3-pip \
  python3-dev

ARG PROJECT_DIR="/app"
WORKDIR $PROJECT_DIR

COPY modelfile.gguf /opt/modelfile.gguf

COPY requirements.txt .
RUN pip3 install -r requirements.txt

COPY main.py .

ENTRYPOINT [ "/usr/bin/python3", "-m", "awslambdaric" ]
CMD [ "main.handler" ]