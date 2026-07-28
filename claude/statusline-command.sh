#!/bin/bash
# Claude Code custom status line
# Shows: model name | cwd (abbreviated) | git branch | context remaining %

input=$(cat)

model=$(echo "$input" | jq -r '.model.display_name // "?"')
cwd=$(echo "$input" | jq -r '.workspace.current_dir // .cwd // "?"')

# Abbreviate cwd: replace $HOME with ~
abbrev_cwd="${cwd/#$HOME/~}"

# Git branch (skip optional locks to avoid contention)
branch=""
if git -C "$cwd" --no-optional-locks rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    branch=$(git -C "$cwd" --no-optional-locks branch --show-current 2>/dev/null)
    if [ -z "$branch" ]; then
        branch=$(git -C "$cwd" --no-optional-locks rev-parse --short HEAD 2>/dev/null)
    fi
fi

# Context remaining percentage (if available)
remaining=$(echo "$input" | jq -r '.context_window.remaining_percentage // empty')

# Reasoning effort level (if available)
effort=$(echo "$input" | jq -r '.effort.level // empty')

# Colors (dim-friendly, terminal will already render dimmed)
COLOR_MODEL='\033[36m'   # cyan
COLOR_DIR='\033[33m'     # yellow
COLOR_BRANCH='\033[32m'  # green
COLOR_CTX='\033[35m'     # magenta
COLOR_EFFORT='\033[34m'  # blue
RESET='\033[0m'

out=""
out+=$(printf "${COLOR_MODEL}%s${RESET}" "$model")
out+=$(printf " ${COLOR_DIR}%s${RESET}" "$abbrev_cwd")
if [ -n "$branch" ]; then
    out+=$(printf " ${COLOR_BRANCH}(%s)${RESET}" "$branch")
fi
if [ -n "$effort" ]; then
    out+=$(printf " ${COLOR_EFFORT}⚡%s${RESET}" "$effort")
fi
if [ -n "$remaining" ]; then
    out+=$(printf " ${COLOR_CTX}[ctx:%.0f%%]${RESET}" "$remaining")
fi

printf "%b" "$out"
