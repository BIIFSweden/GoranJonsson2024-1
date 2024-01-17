ARG TENSORFLOW_VERSION=2.15.0.post1
FROM tensorflow/tensorflow:${TENSORFLOW_VERSION}-gpu-jupyter AS jupyter
ARG TENSORFLOW_VERSION

RUN mkdir /data
WORKDIR /data

CMD ["bash", "-c", "source /etc/bash.bashrc && jupyter lab --notebook-dir=/data --ip 0.0.0.0 --no-browser --allow-root"]


FROM jupyter AS qupath
ARG QUPATH_VERSION=0.5.0

RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y wget xauth xorg openbox
    
RUN wget -q https://github.com/qupath/qupath/releases/download/v${QUPATH_VERSION}/QuPath-v${QUPATH_VERSION}-Linux.tar.xz && \
    tar -xf QuPath-v${QUPATH_VERSION}-Linux.tar.xz -C /opt && \
    rm QuPath-v${QUPATH_VERSION}-Linux.tar.xz && \
    chmod +x /opt/QuPath/bin/QuPath && \
    ln -s /opt/QuPath/bin/QuPath /usr/local/bin/QuPath

ENTRYPOINT [ "QuPath" ]
