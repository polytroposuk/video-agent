# AI Video Editing Workspace Setup

This workspace is configured for conversation-driven video editing using
[video-use](https://github.com/browser-use/video-use) (FFmpeg-based cutting,
grading, subtitles) and the [VideoDB](https://github.com/video-db/skills)
skill (ingest, indexing, search, timeline edits) as Claude Code skills.

## What's installed

| Component | Status | Notes |
|---|---|---|
| FFmpeg / ffprobe | ✅ installed | `apt-get install ffmpeg` (6.1.1, Ubuntu 24.04 universe) |
| video-use repo | ✅ cloned | `~/Developer/video-use` |
| video-use Python deps | ✅ installed | via `uv sync` into `~/Developer/video-use/.venv` |
| video-use skill registration | ✅ linked | `~/.claude/skills/video-use -> ~/Developer/video-use` |
| ElevenLabs API key | ❌ not configured | required for video-use transcription (Scribe); network access now open, key still needed |
| videodb skill | ✅ installed | `.agents/skills/videodb`, symlinked to `.claude/skills/videodb` (via `npx skills add video-db/skills`) |
| videodb Python SDK | ✅ installed | `pip install videodb python-dotenv` (installed without the `[capture]` extra — fails to build here; desktop capture unavailable, file/URL/RTSP ingest unaffected) |
| VIDEO_DB_API_KEY | ✅ configured | stored at `~/.config/videodb/.env` (outside this repo), auth verified live |
| yt-dlp | ⚪ not installed (optional) | only needed to pull sources from URLs |
| Manim / pdflatex | ⚪ not installed (optional) | only needed for Manim-based animation overlays |
| Node.js | ✅ present (v22.22.2) | satisfies HyperFrames' Node 22+ requirement, if used |
| GPU | ❌ none | FFmpeg will use CPU (libx264/libx265) encoding only |

Reproduce video-use with `scripts/setup-video-use.sh`.

## Resolved: environment network policy was blocking ElevenLabs and VideoDB

Both video-use (transcription via `api.elevenlabs.io`) and videodb
(`api.videodb.io`, `console.videodb.io`) require outbound API access. This
sandbox's default network policy denied those hosts at the proxy layer
(`CONNECT` returned 403). Fixed by editing the environment's **Network
access** setting to **Custom** and adding:

```
api.videodb.io
console.videodb.io
api.elevenlabs.io
```

(with "Also include default list of common package managers" left checked).
Confirmed live in this session: `api.videodb.io` / `console.videodb.io`
return 200, `api.elevenlabs.io` returns a proper 401 (reachable, just no key
yet), and the stored `VIDEO_DB_API_KEY` authenticates successfully via the
SDK. Note the change did **not** apply to the already-running session/cache
— it only took effect after this session was retried following the policy
edit, so a running session may need to be refreshed to pick up a network
policy change.

To finish ElevenLabs setup, add the key (never into this repo):

```bash
printf 'ELEVENLABS_API_KEY=%s\n' "<your key>" > ~/Developer/video-use/.env
chmod 600 ~/Developer/video-use/.env
curl -s -o /dev/null -w '%{http_code}\n' \
  -H "xi-api-key: $(sed -n 's/^ELEVENLABS_API_KEY=//p' ~/Developer/video-use/.env)" \
  https://api.elevenlabs.io/v1/user   # expect 200
```

## Other network notes

- `github.com` (plain HTTPS browsing) returns 400 through the proxy, but
  `git clone`/`git pull` over HTTPS to GitHub work fine (confirmed).
- `pypi.org` / `files.pythonhosted.org` and `registry.npmjs.org` bypass the
  proxy entirely (allowlisted), so `pip`/`uv`/`npm` installs are unaffected.
- `ppa.launchpadcontent.net` (some apt PPAs) is also policy-blocked; core
  Ubuntu `apt` repos are not affected, and `ffmpeg` installed fine from
  `universe`.

## Verified working (no video edited)

```bash
ffmpeg -version && ffprobe -version
~/Developer/video-use/.venv/bin/python ~/Developer/video-use/helpers/timeline_view.py --help
```

Both succeed. All six `helpers/*.py` scripts parse and import cleanly under
the venv.

## Usage once the API key is in place

```bash
cd /path/to/your/footage
claude   # video-use is auto-discovered via ~/.claude/skills/video-use
# > edit these into a launch video
```

Outputs land in `<footage_dir>/edit/final.mp4`; the skill directory stays
clean.
