#!/usr/bin/env bash

echo "Current folder:"
pwd

echo "Memory:"
free -h

echo "Windows C drive:"
df -h | grep "/mnt/c"

echo "SSH service:"
systemctl is-active ssh