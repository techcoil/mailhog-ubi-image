#!/usr/bin/env bash

# Create Auth file user/pass provided"

if [ -z "$MH_UI_USERNAME" ] || [ -z "$MH_UI_PASSWORD" ]; then
  echo "[WARNING] No credentials provided - Pass MH_UI_USERNAME and MH_UI_PASSWORD to configure credentials"
else
  export MH_AUTH_FILE=$(mktemp)
  htpasswd -bcB "${MH_AUTH_FILE}" "$MH_UI_USERNAME" "$MH_UI_PASSWORD"
fi


MailHog
