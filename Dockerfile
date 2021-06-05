FROM gitpod/workspace-full-vnc

# Install dependencies
USER root
RUN sudo apt-get update && apt-get install -y apt-transport-https && sudo apt-get clean && rm -rf /var/cache/apt/* && rm -rf /var/lib/apt/lists/* && rm -rf /tmp/*
# RUN sudo apt-get install -y libgtk-3-dev libgtk-3 \
