#!/bin/bash

# Path to the encrypted token file
TOKEN_FILE="$HOME/.secure/token.txt.gpg"

# Check if the token file exists
if [ ! -f "$TOKEN_FILE" ]; then
  echo "Error: Token file not found at $TOKEN_FILE"
  exit 1
fi

# Check if xclip is installed
if ! command -v xclip &> /dev/null; then
  echo "Error: xclip is not installed. Install it with 'sudo apt-get install xclip'."
  exit 1
fi

# Decrypt the token and pipe it directly to the clipboard without displaying it
if gpg --decrypt "$TOKEN_FILE" 2>/dev/null | xclip -selection clipboard; then
  echo "Token copied to clipboard successfully."
else
  echo "Error: Failed to decrypt or copy token. Check your passphrase."
  exit 1
fi
