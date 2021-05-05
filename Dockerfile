FROM jupyter/base-notebook

# Add RUN statements to install packages as the $NB_USER defined in the base images.

# Add a "USER root" statement followed by RUN statements to install system packages using apt-get,
# change file permissions, etc. etc.
USER root

RUN apt-get update && \
    apt-get -y install curl

RUN curl --version

# RUN apt-get -y install nodejs npm
# RUN node --version

# Install elm
RUN curl -L -o elm.gz https://github.com/elm/compiler/releases/download/0.19.1/binary-for-linux-64-bit.gz && \
    gunzip elm.gz && \
    chmod +x elm && \
    mv elm /usr/local/bin/

# If you do switch to root, always be sure to add a "USER $NB_USER" command at the end of the
# file to ensure the image runs as a unprivileged user by default.
USER $NB_USER

RUN pip install elm_kernel && \
    python -m elm_kernel.install

RUN curl -L -O elmreplkernel.zip https://github.com/eelcodijkstra/elmreplkernel/archive/refs/heads/master.zip && \
    gunzip elmreplkernel.zip && \
    python elmreplkernel/setup.py install && \
    python -m elmreplkernel.install
