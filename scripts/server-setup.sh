#!/usr/bin/env bash
# Kali (server): enable IP forwarding, add NAT rule, start the tunnel at boot.
# Usage: sudo ./server-setup.sh <wan-interface>   (e.g. eth0, the NAT adapter)
set -euo pipefail
WAN_IF="${1:?usage: $0 <wan-interface>}"
sysctl -w net.ipv4.ip_forward=1
grep -q '^net.ipv4.ip_forward=1' /etc/sysctl.conf || echo 'net.ipv4.ip_forward=1' >> /etc/sysctl.conf
iptables -t nat -A POSTROUTING -o "$WAN_IF" -j MASQUERADE
systemctl enable --now wg-quick@wg0
wg show
