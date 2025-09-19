#!/usr/bin/env bash

apt-get update
apt-get install -y jq squashfs-tools snapd
apt-get clean
rm -rf /var/lib/apt/lists/*
