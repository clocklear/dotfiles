#!/bin/sh
set -eu

# Only relevant if git exists
command -v git >/dev/null 2>&1 || exit 0
command -v ssh-add >/dev/null 2>&1 || exit 0

# Skip WSL (optional). Remove this block if you *want* it to run on WSL.
if [ -r /proc/sys/kernel/osrelease ] && grep -qi microsoft /proc/sys/kernel/osrelease; then
  exit 0
fi

# If already configured, do nothing
if git config --global --get user.signingkey >/dev/null 2>&1; then
  exit 0
fi

picker="$HOME/.local/bin/git-pick-signingkey"
if [ -x "$picker" ]; then
  echo "Git SSH signing key not configured; launching picker..."
  "$picker"
fi

