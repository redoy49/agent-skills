#!/usr/bin/env bash
# Install one skill from this repo into a skills root.
#   ./install.sh skills/web/nextjs-production-stack              # -> ~/.gemini/config/skills
#   ./install.sh skills/web/nextjs-production-stack .agents/skills
set -euo pipefail

SRC="${1:?usage: ./install.sh skills/<category>/<skill-name> [target-skills-root]}"
TARGET="${2:-$HOME/.gemini/config/skills}"
NAME="$(basename "$SRC")"

[ -f "$SRC/SKILL.md" ] || { echo "no SKILL.md in $SRC" >&2; exit 1; }
case "$TARGET" in /*|~*|[A-Za-z]:*) ;; *) TARGET="$PWD/$TARGET" ;; esac   # project-relative ok

mkdir -p "$TARGET/$NAME"
cp -r "$SRC/." "$TARGET/$NAME/"
echo "installed $NAME -> $TARGET/$NAME"
echo "reminder: copy $SRC/templates/* into your project if the README says so"
