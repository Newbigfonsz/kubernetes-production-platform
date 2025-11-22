#!/bin/bash
set -e

echo "================================"
echo "Prerequisites Installation"
echo "================================"

# Update system
sudo apt update && sudo apt upgrade -y

# Install required packages
sudo apt install -y curl wget git vim net-tools

# Disable swap
sudo swapoff -a
sudo sed -i '/ swap / s/^/#/' /etc/fstab

# Enable IP forwarding
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "✅ Prerequisites installed!"
