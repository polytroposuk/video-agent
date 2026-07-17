# AI Video Editing Workspace Setup

This workspace is configured for conversation-driven video editing using
[video-use](https://github.com/browser-use/video-use), a Claude Code skill
built on FFmpeg.

## What's installed

| Component | Status | Notes |
|---|---|---|
| FFmpeg / ffprobe | ✅ installed | `apt-get install ffmpeg` (6.1.1, Ubuntu 24.04 universe) |
| video-use repo | ✅ cloned | `~/Developer/video-use` |
| Python deps (requests, librosa, matplotlib, pillow, numpy) | ✅ installed | via `uv sync` into `~/Developer/video-use/.venv` |
| Claude Code skill registration | ✅ linked | `~/.claude/skills/video-use -> ~/Developer/video-use` |
| ElevenLabs API key | ❌ not configured | required for transcription (Scribe); see "Known issue" below |
| yt-dlp | ⚪ not installed (optional) | only needed to pull sources from URLs |
| Manim / pdflatex | ⚪ not installed (optional) | only needed for Manim-based animation overlays |
| Node.js | ✅ present (v22.22.2) | satisfies HyperFrames' Node 22+ requirement, if used |
| GPU | ❌ none | FFmpeg will use CPU (libx264/libx265) encoding only |

Reproduce with `scripts/setup-video-use.sh`.

## Known issue: ElevenLabs API is network-blocked in this environment

video-use's transcription pipeline calls `api.elevenlabs.io` (ElevenLabs
Scribe) for word-level timestamps and speaker diarization — this is a hard
dependency; nothing gets edited without it. In this Claude Code cloud
sandbox, the outbound proxy's network policy currently **denies** that host
at the policy layer (`CONNECT` returns 403, confirmed via
`$HTTPS_PROXY/__agentproxy/status`), not just an unreachable/slow host.

To fix: widen this environment's network policy to allow
`api.elevenlabs.io` (and `elevenlabs.io` if you fetch keys via browser from
this environment). Network policy is configured per-environment; see
https://code.claude.com/docs/en/claude-code-on-the-web for how policies are
chosen when an environment is created. Once access is allowed, add the key:

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
