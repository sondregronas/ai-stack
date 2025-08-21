#!/bin/bash

# Get directory of this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

JSON_FILE="$SCRIPT_DIR/flux1dev-workflow.json"
ENV_FILE="$SCRIPT_DIR/../open-webui/comfy-workflow.env"

# Ensure JSON file exists
if [[ ! -f "$JSON_FILE" ]]; then
  echo "Error: $JSON_FILE not found."
  exit 1
fi

# Compact JSON to one line
if ! command -v jq &> /dev/null; then
  echo "Error: jq is required but not installed."
  exit 1
fi

WORKFLOW_JSON=$(jq -c . "$JSON_FILE")

# Escape forward slashes for sed
WORKFLOW_JSON_ESCAPED=$(printf '%s' "$WORKFLOW_JSON" | sed 's/[&/\]/\\&/g')

# Replace COMFYUI_WORKFLOW if it exists, otherwise append it
if [[ -f "$ENV_FILE" && $(grep -c '^COMFYUI_WORKFLOW=' "$ENV_FILE") -gt 0 ]]; then
  sed -i.bak "s/^COMFYUI_WORKFLOW=.*/COMFYUI_WORKFLOW=$WORKFLOW_JSON_ESCAPED/" "$ENV_FILE"
else
  echo "COMFYUI_WORKFLOW=$WORKFLOW_JSON" >> "$ENV_FILE"
fi

echo "COMFYUI_WORKFLOW updated in $ENV_FILE"
