#!/bin/bash
# Copy one game from the Obsidian vault (the source of truth, edited on desktop and phone)
# into games/<slug>/. Only .ink and .md files are copied; files removed in the vault are removed here.
# Usage: scripts/sync-from-vault.sh <slug>     (the vault folder comes from games.json)
set -euo pipefail
VAULT="${INK_VAULT:-$HOME/Library/Mobile Documents/iCloud~md~obsidian/Documents/ink-games}"
slug="$1"
folder=$(node -e 'const g=require("./games.json").find(g=>g.slug===process.argv[1]); if(!g) process.exit(1); console.log(g.vault)' "$slug") \
  || { echo "no game with slug '$slug' in games.json" >&2; exit 1; }
mkdir -p "games/$slug"
rsync -a --delete --include='*/' --include='*.ink' --include='*.md' --exclude='*' "$VAULT/$folder/" "games/$slug/"
echo "synced $VAULT/$folder -> games/$slug"
