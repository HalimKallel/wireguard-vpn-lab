#!/usr/bin/env bash
# Generate a WireGuard key pair on the machine that will use it.
# The private key never leaves this machine; only the public key is shared.
# Usage: bash scripts/generate-keys.sh <name>     (e.g. server or client)
set -euo pipefail
command -v wg >/dev/null 2>&1 || { echo "Error: 'wg' not found. Install it: sudo apt install wireguard" >&2; exit 1; }
umask 077
name="${1:-server}"
wg genkey | tee "${name}_private.key" | wg pubkey > "${name}_public.key"
chmod 600 "${name}_private.key"
echo "Created ${name}_private.key (keep secret) and ${name}_public.key (share with the peer)."
