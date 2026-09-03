#!/usr/bin/env bash
# Split the focused herdr pane, anchored to the workspace's worktree root.
#
# Why this exists:
#   herdr's [terminal] new_cwd = "follow" inherits the focused pane's *live*
#   cwd, not the directory the pane was spawned in. A long-running agent's cwd
#   can drift out of the worktree during a session: Claude Code's process cwd
#   tracks its persistent shell, so a cd anywhere in the session moves it for
#   good. Splitting from that pane then opens the new pane wherever the process
#   ended up rather than in the worktree you are working in.
#
#   This resolves the *workspace's* worktree checkout_path and passes it as an
#   explicit --cwd, which no built-in new_cwd policy can express.
#
# Falls back to herdr's normal behaviour when the workspace is not a worktree,
# or if anything goes wrong, so a split always happens.
#
# Bound in herdr/config.toml as a [[keys.command]] of type = "shell".
# Usage: split-worktree.sh <right|down>

set -uo pipefail

dir="${1:-right}"
herdr="${HERDR_BIN_PATH:-herdr}"
pane="${HERDR_ACTIVE_PANE_ID:-}"
ws="${HERDR_ACTIVE_WORKSPACE_ID:-}"

# Resolve this workspace's worktree checkout path, if it has one.
target=""
if [ -n "$ws" ]; then
  target=$("$herdr" workspace list 2>/dev/null | HERDR_WS="$ws" python3 -c '
import json, os, sys
ws = os.environ.get("HERDR_WS")
try:
    doc = json.load(sys.stdin)
except Exception:
    sys.exit(0)
for w in doc.get("result", {}).get("workspaces", []):
    if w.get("workspace_id") == ws:
        path = (w.get("worktree") or {}).get("checkout_path")
        if path:
            print(path)
        break
' 2>/dev/null)
fi

# Not a worktree workspace, or lookup failed: use the pane cwd herdr would
# have used anyway.
[ -z "$target" ] && target="${HERDR_ACTIVE_PANE_CWD:-}"

args=(pane split --direction "$dir" --focus)
[ -n "$pane" ] && args+=(--pane "$pane")
[ -n "$target" ] && args+=(--cwd "$target")

if [ -n "${HERDR_SPLIT_DRY_RUN:-}" ]; then
  printf 'would run: %s' "$herdr"
  printf ' %q' "${args[@]}"
  printf '\n'
  exit 0
fi

exec "$herdr" "${args[@]}"
