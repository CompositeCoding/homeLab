#!/bin/bash

# Talos Common Operations Examples
# Replace 192.168.2.32 with your node IP

export NODE="192.168.2.32"
export TALOSCONFIG="./talos/talosconfig"

# Get Talos version
talosctl -n $NODE --talosconfig $TALOSCONFIG version

# Get node health status
talosctl -n $NODE --talosconfig $TALOSCONFIG health

# Get kubernetes configuration and save to ~/.kube/config
talosctl -n $NODE --talosconfig $TALOSCONFIG kubeconfig

# View system logs (dmesg)
talosctl -n $NODE --talosconfig $TALOSCONFIG dmesg

# View service logs (e.g., kubelet)
talosctl -n $NODE --talosconfig $TALOSCONFIG logs kubelet

# List all services and their status
talosctl -n $NODE --talosconfig $TALOSCONFIG services

# Get detailed service info
talosctl -n $NODE --talosconfig $TALOSCONFIG service kubelet

# Read a file from the node
talosctl -n $NODE --talosconfig $TALOSCONFIG read /proc/cpuinfo

# List files in a directory
talosctl -n $NODE --talosconfig $TALOSCONFIG ls /var/log

# Get CPU and memory usage
talosctl -n $NODE --talosconfig $TALOSCONFIG dashboard

# Get network interfaces
talosctl -n $NODE --talosconfig $TALOSCONFIG get addresses

# Get routing table
talosctl -n $NODE --talosconfig $TALOSCONFIG get routes

# List all running containers
talosctl -n $NODE --talosconfig $TALOSCONFIG containers

# Get etcd members
talosctl -n $NODE --talosconfig $TALOSCONFIG etcd members

# Get machine config
talosctl -n $NODE --talosconfig $TALOSCONFIG get machineconfig -o yaml

# Apply new configuration
# talosctl -n $NODE --talosconfig $TALOSCONFIG apply-config --file ../config/talos/controlplane.yaml

# Upgrade Talos to new version
# talosctl -n $NODE --talosconfig $TALOSCONFIG upgrade --image ghcr.io/siderolabs/installer:v1.11.3

# Reboot the node
# talosctl -n $NODE --talosconfig $TALOSCONFIG reboot

# Shutdown the node
# talosctl -n $NODE --talosconfig $TALOSCONFIG shutdown
 talosctl -n $NODE --talosconfig $TALOSCONFIG get volumestatus u-local-volume

# Get system disks
talosctl -n $NODE --talosconfig $TALOSCONFIG get disks

# Get installed extensions
talosctl -n $NODE --talosconfig $TALOSCONFIG get extensions

# Check loaded kernel modules
talosctl -n $NODE --talosconfig $TALOSCONFIG read /proc/modules

# Interactive shell (not available in Talos by default, use for debugging)
# talosctl -n $NODE --talosconfig $TALOSCONFIG pcap

# Reset node (WARNING: destructive)
# talosctl -n $NODE --talosconfig $TALOSCONFIG reset

# Get cluster members
talosctl -n $NODE --talosconfig $TALOSCONFIG get members
