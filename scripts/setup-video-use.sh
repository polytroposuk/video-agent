#!/usr/bin/env bash
# Idempotent setup for the video-use AI video editing skill.
# See ../SETUP.md for details and known issues.
set -euo pipefail

VIDEO_USE_DIR="${VIDEO_USE_DIR:-$HOME/Developer/video-use}"

echo "== FFmpeg =="
if ! command -v ffmpeg >/dev/null; then
  if command -v apt-get >/dev/null; then
    apt-get update -qq && apt-get install -y ffmpeg
  else
    echo "No apt-get found; install ffmpeg manually for your platform." >&2
    exit 1
  fi
fi
ffmpeg -version | head -1
ffprobe -version | head -1

echo "== Clone video-use =="
if [ -d "$VIDEO_USE_DIR/.git" ]; then
  git -C "$VIDEO_USE_DIR" pull --ff-only
else
  git clone https://github.com/browser-use/video-use "$VIDEO_USE_DIR"
fi

echo "== Python deps =="
cd "$VIDEO_USE_DIR"
if command -v uv >/dev/null; then
  uv sync
else
  pip install -e .
fi

echo "== Register Claude Code skill =="
mkdir -p ~/.claude/skills
ln -sfn "$VIDEO_USE_DIR" ~/.claude/skills/video-use

echo "== Verify =="
"$VIDEO_USE_DIR/.venv/bin/python" "$VIDEO_USE_DIR/helpers/timeline_view.py" --help >/dev/null && echo "helpers OK"

echo ""
echo "Done. Next: add ELEVENLABS_API_KEY to $VIDEO_USE_DIR/.env (chmod 600)."
echo "See SETUP.md for the network-policy caveat in cloud sandboxes."
