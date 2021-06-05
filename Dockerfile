FROM gitpod/workspace-full-vnc

# Install dependencies
USER root
RUN apt-get update \
