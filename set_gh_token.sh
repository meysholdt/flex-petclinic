#!/bin/bash

# Folder to search
folder="/usr/local/gitpod/shared/git-secrets/"

# Patterns to search for
username="username=oauth2"
password_pattern="password="

# Find files containing 'username=oauth2' and extract the password
for file in $(grep -rl "$username" "$folder"); do
  password=$(grep "$password_pattern" "$file" | grep -oP '(?<=password=).*')
  if [ ! -z "$password" ]; then
    export GH_TOKEN="$password"
    echo "GH_TOKEN set to: *****"
    break
  fi
done

if [ -z "$GH_TOKEN" ]; then
  echo "No matching password found."
fi