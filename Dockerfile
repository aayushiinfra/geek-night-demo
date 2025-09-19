FROM ubuntu:20.04

# Install Snapcraft and ROS tools
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    python3 \
    python3-pip \
    jq \
    curl \
    ca-certificates

RUN rm -rf /var/lib/apt/lists/*
