# Edit Style Guide

This is the house style for every edit produced in this workspace (via
video-use / videodb) unless a specific project explicitly overrides it.
Derived from scanning 6 clips in the "Vibe Reels" Google Drive folder
(`165jTTsoDEVb_GvgUNx-wor-F-dBi0M0C`): `date idea?`, `POV you wake up... Titanic`,
`Immersive Atlantis escape room`, `The soft play everyone's been talking
about`, `Venue Overview`, `an hour on the stairmaster`, plus one raw
screen-recording (`ScreenRecording_12-09-2025 12-52-11`).

**Important caveat:** that folder is a moodboard of *other creators'*
published TikTok/Instagram reels (visible watermarks: `@shesspooky`,
`@60outescaperooms`, `@the2ndhouse`, `@babygirl_lba`, plus one literal
screen-recording of someone scrolling Instagram) — not this account's own
raw footage or prior output. Treat everything below as inferred house
style to validate with a human, not an established brand guideline pulled
from your own back catalog. Revise this file once real edits or explicit
feedback exist.

## Format

- **Aspect ratio**: 9:16 vertical. Sources were 576×1024 or 720×1280;
  target **1080×1920** on export regardless of source resolution.
- **Duration**: short-form, 11–30s observed. Default to the low end (10–20s)
  unless the brief calls for a longer walkthrough.
- **Frame rate**: 30fps.
- **Audio**: native ambient/location sound, not a voiceover track. Music bed
  optional, ambient-first.

## Structure: hook-first, no bumper

Cold open directly on the hook — no logo, no intro card, no fade-in.
First frame already has the caption text and the subject in motion.

**Progressive caption reveal** is the dominant pattern: a single hook
sentence is split across 2–4 cuts, each cut advancing the next clause,
rather than showing the full line on frame one. E.g.
`"For anyone in Leeds who"` → `"fancies themselves a good driver..."` →
`"how about a pit stop at Drift Stop?!"`. Use this by default for
multi-clause hooks; a single short line (e.g. `"Date idea?"`) can stay
static across the first few cuts instead.

Optional secondary line: a small location tag under the main hook
(`📍 Venue Name, City`), smaller weight, appears once near the top and
doesn't recur every cut.

## Text treatment

Two caption styles recurred; use the **pill/box background** as default —
it was the most legible and consistent across the higher-production
examples (Venue Overview, Drift Stop):

- **Default**: white text on a semi-opaque dark pill/rounded-rect
  background, bold sans-serif, mixed case (not all-caps), centered
  horizontally, placed in the upper-middle third — never over the subject's
  face or the main action.
- **Alternate** (use for punchy single-line hooks / quote-style beats):
  bold white text with a heavy stroke/drop-shadow, no background chip,
  all-caps or sentence case, centered.

Never let text overlap the primary subject or key action. Keep each caption
on screen long enough to read once at normal pace (~1.5–2s minimum per
clause).

## Pacing and cuts

- Fast cuts: **1–3 seconds per shot** on average, no shot lingers past ~4s.
- **Hard cuts only** — no crossfades, wipes, or transition effects between
  clips. Cut on motion or a beat in the ambient audio, not on a black frame.
- Energy comes from the cut rate and the location's own lighting/movement,
  not from post-added transitions.

## Color

- **Preserve and lean into the venue's native ambient lighting** (neon
  blue/red/green, warm amber) rather than applying a uniform neutral grade.
  None of the source clips look color-corrected toward a flat/neutral
  look — saturation and colored practical lighting are part of the mood.
- If grading is needed for consistency across mixed sources, nudge
  saturation/contrast up slightly rather than normalizing hue — don't
  flatten venues that are lit differently from each other.

## Export target (not copied from the samples)

The sample files themselves are inconsistent (re-compressed downloads):
H.264 sources ran 700–1000kbps at 576×1024 (visibly degraded, platform
re-encodes), HEVC sources ran 10–14Mbps at 720×1280 (closer to original
quality). Don't replicate the degraded bitrates — export at:

- H.264 High Profile, ~8–12Mbps, 1080×1920, 30fps
- AAC audio, 128–192kbps
- No visible platform watermark/UI chrome in the final export (the ones
  present in the samples are artifacts of them being downloaded reposts,
  not something to reproduce)

## Open questions to confirm with the user before treating this as final

- Is there a real house style from this account's own past edits to
  compare against, or is this moodboard genuinely the starting point?
- Music bed: always ambient-only, or should some edits carry a licensed
  track (Epidemic Sound is already wired up in this workspace)?
- Subtitles for spoken dialogue (video-use's default 2-word burned-in
  style) vs. the hook-caption style documented here — these may be two
  different features (dialogue captions vs. marketing hook text), not one.
