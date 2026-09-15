#!/usr/bin/env bash
# Builds this repo's history as dated milestones, first demo → docs, one commit per file/milestone.
# The steps inside each milestone are recorded in the commit body (intermediate versions weren't kept).
# Run once from the repo root on a fresh `git init`. Files must already have their final names.
set -euo pipefail
AUTHOR="Jackson F. de A. Mafra <jacksonfdam@users.noreply.github.com>"

c() {  # c "<date>" "<subject>" "<body>" <files...>
  local date="$1" subj="$2" body="$3"; shift 3
  git add -- "$@" 2>/dev/null || true
  if git diff --cached --quiet; then echo "  skip (no change): $subj"; return; fi
  GIT_AUTHOR_DATE="$date" GIT_COMMITTER_DATE="$date" git commit -q --author="$AUTHOR" -m "$subj" -m "$body"
  echo "  ${date%%T*}  $subj"
}

[ -d .git ] || git init -q
git checkout -q -B main 2>/dev/null || true
echo "building history…"

c "2026-09-11T23:10:00+02:00" "ascii sync: strudel → three.js AsciiEffect bridge" \
"- onTrigger(vis(\"name\"), false) → queue {audioTime, name, value} → render loop fires on the same clock
- tunnel of frames, noise-displaced core, point-cloud ground with kick ripples, satellites, debris
- matrix rain with feedback trails, CRT overlay, terminal log, glitch pass, 5 palettes
- tempo (live setcps) + motion sliders; packs: dirt-samples, crate, wax, clean-breaks
- fixes: stop = hush() (never window.stop); drop panic() — 1.1.0 never rebuilds the output chain
- fixes: hap located by shape (1.1.0 passes targetTime first); vis(\"kick\") unwraps the Pattern the transpiler makes" \
  strudel-ascii-three.html

c "2026-09-12T10:45:00+02:00" "hands: mediapipe hand tracking drives sound and scene" \
"- HandLandmarker → live hand {x y pinch fingers spread pinched slide spin tips}
- patterns read it with signal(() => hand.…): height→hpf, pan, pinch→lpf, spin→shape, fist gates voices
- gesture detector: edge-triggered pinch, swipe (≥30% width <400ms), roll → rad/s
- 22 pushable orbs with springs/damping; pinch picks up an orb or drags the core
- cvzone-style skeleton overlay; stop camera restores neutral defaults" \
  strudel-hands-three.html

c "2026-09-12T12:20:00+02:00" "point cloud: body + face clouds in colour, real spectrum, HUD kit" \
"- selfie ImageSegmenter → body point grid (density/depth sliders), FaceLandmarker → 478-point cloud, fingertip particles, UnrealBloom
- AudioNode.connect shim mirrors speaker-bound audio into an AnalyserNode → audio.bass/mid/high for visuals and patterns
- band-weighted palette colours mixed with camera pixels; breathing gradient background follows the head
- HUD-kit mode: meters, spectrum, waveform, level bar, beat counter, palm rings, face brackets" \
  strudel-pointcloud-three.html

c "2026-09-12T15:50:00+02:00" "ascii cam: webcam → glyphs, mic fx chain, bakery playlist" \
"- five brightness tiers with their own glyph sets; bass/highs/voice modulate flicker, warp, scramble
- microphone: hpf → drive → ring mod → pitch (modulated delay) → delay/feedback → lpf; monitor off by default
- mic.level / mic.pitch (autocorrelation) readable from patterns
- playlist: Blue Monday cover (Lewis), tupper class (eddyflux), voice-driven original; Add field decodes strudel.cc/#hash links
- adapt(): strip draw calls, gm_* → basic waveforms, bank aliases → full machine names
- fix: rename voice→mic — strudel copies its controls onto window at init" \
  strudel-ascii-cam.html

c "2026-09-12T22:30:00+02:00" "the corridor: head-steered ascii game with a distorted narrator" \
"- gate asks your name; FaceLandmarker yaw/pitch + eye blendshapes → head.looking, lane with hysteresis
- first-person corridor in ascii, blocks in 3 lanes, arrow to the free lane, look-away pause, 3 lives, glitch on hit
- narrator: speechSynthesis with low pitch/jittered rate/stutter + Web Audio sub-drone stinger; formant-noise whispers
- speaks on warnings, hits, near misses, milestones, speed, lane changes, look-away, idle, game over
- narrator controls: on/off, subtitles, volume, voice picker, test, restart, tts state in HUD
- speech fixes: priority queue, 180ms after cancel(), utterances kept referenced, watchdog, pause/resume heartbeat
- audio fixes: bank alias map; mono ascii / 30fps render / 15fps tracking; SharedWorker clock (sync:true) w/ 350ms latency" \
  strudel-tron-head.html

c "2026-09-15T10:00:00+02:00" "deploy: vendor @strudel/web for static hosts" \
"- loader tries vendor/strudel-web/index.js, then node_modules, then CDN
- worker must live at /assets/ (package requests it from site root); HEAD check before enabling sync
- postinstall copies vendor/ + assets/; both committed so Vercel needs no install step" \
  strudel-tron-head.html package.json .gitignore

c "2026-09-15T10:30:00+02:00" "docs: MIT license and third-party notices" \
"strudel AGPL-3.0 (vendored copy), three.js MIT, mediapipe Apache-2.0, sample packs, bakery pattern authors" \
  LICENSE THIRD_PARTY.md

c "2026-09-15T11:00:00+02:00" "docs: README with demos, codepens, run and deploy notes" \
"plus the long-form series summary used for the announcement post" \
  README.md strudel-visuals-series-summary.md retro-commits.sh

if [ -n "$(git status --porcelain)" ]; then
  git add -A
  GIT_AUTHOR_DATE="2026-09-15T11:20:00+02:00" GIT_COMMITTER_DATE="2026-09-15T11:20:00+02:00" \
    git commit -q --author="$AUTHOR" -m "vendor: committed @strudel/web copy + worker for zero-install deploy" && echo "  2026-09-15  vendor commit"
fi

echo; git log --pretty=format:'%ad  %s' --date=short; echo
echo "done. push with:  git remote add origin git@github.com:jacksonfdam/strudel-visuals.git && git push -u origin main"
