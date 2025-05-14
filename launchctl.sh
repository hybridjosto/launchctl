#!/bin/bash

# list all launchctl user agents
labels=$(launchctl list | awk '{print $3}' | grep -v '^com.apple')

# select one
selected=$(echo "$labels" | gum filter)

if [[ -z "$selected" ]]; then
  echo "No selection made. Exiting."
  exit 0
fi

# Get selected label from gum (or hardcode for testing)
# selected="$1"

# Capture and clean raw launchctl output
launchctl list "$selected" |
  sed -E 's/^[[:space:]]*"?([^"=]+)"?[[:space:]]*=[[:space:]]*(.*);[[:space:]]*$/\1:\2/' |
  while IFS=: read -r key value; do
    printf "%s %s\n" \
      "$(gum style --foreground "#00ffff" --bold "$key:")" \
      "$(gum style --foreground "#ffd700" "$value")"
  done
