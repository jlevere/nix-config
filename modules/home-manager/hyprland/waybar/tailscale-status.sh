#!/usr/bin/env bash
# Tailscale status checker for Waybar

# Check if tailscale is running
if ! command -v tailscale &> /dev/null; then
    printf '{"text": "󰿆", "tooltip": "Tailscale not installed", "class": "disconnected"}'
    exit 0
fi

# Check if tailscale is connected
STATUS=$(tailscale status --json 2>/dev/null)

if [ -z "$STATUS" ]; then
    printf '{"text": "󰿆", "tooltip": "Tailscale not running", "class": "disconnected"}'
    exit 0
fi

# Check if jq is available
if ! command -v jq &> /dev/null; then
    printf '{"text": "󰿆", "tooltip": "jq not available", "class": "disconnected"}'
    exit 0
fi

# Check if we're connected to the tailnet
CONNECTED=$(echo "$STATUS" | jq -r '.Self.Online' 2>/dev/null)

if [ "$CONNECTED" != "true" ]; then
    printf '{"text": "󰿆", "tooltip": "Tailscale disconnected", "class": "disconnected"}'
    exit 0
fi

# Get device count (default to 0 if jq fails)
DEVICE_COUNT=$(echo "$STATUS" | jq -r '[.Peer[] | select(.Online == true)] | length' 2>/dev/null)
DEVICE_COUNT=${DEVICE_COUNT:-0}

# Get self IP (default to N/A if jq fails)
SELF_IP=$(echo "$STATUS" | jq -r '.Self.TailscaleIPs[0] // "N/A"' 2>/dev/null)
SELF_IP=${SELF_IP:-N/A}

# Output JSON with tooltip (escape newlines for valid JSON)
printf '{"text": "󰈀", "tooltip": "Tailscale Connected\\nIP: %s\\n\\nOnline devices: %s", "class": "connected"}' \
    "$SELF_IP" \
    "$DEVICE_COUNT"

