# strudel × computer vision × three.js

Five browser experiments that connect **[Strudel](https://strudel.cc)** — the JavaScript port of TidalCycles, a live-coding music language — to real-time visuals and, eventually, to the body: audio-reactive ASCII graphics, hand tracking, body point clouds, a webcam-to-ASCII renderer with a distorted microphone chain, and a first-person corridor game you steer with your head while a distorted narrator says your name.

Each demo builds on the previous one. No build step: every demo is a single HTML file.

**Live:** `{{VERCEL_URL}}`

## The demos

Open them in order — each one assumes the previous one's engine.

| # | Demo | File | CodePen |
|---|---|---|---|
| 1 | **strudel × three.js — ascii sync** · the bridge | [`strudel-ascii-three.html`](strudel-ascii-three.html) | [open](https://codepen.io/editor/jacksonfdam/pen/01a09251-470c-7551-be0e-26d123661f7b) |
| 2 | **strudel × mediapipe hands × three.js** · the hands come in | [`strudel-hands-three.html`](strudel-hands-three.html) | [open](https://codepen.io/editor/jacksonfdam/pen/01a092a6-716a-72e6-a35a-74572f4de06e) |
| 3 | **strudel × mediapipe × three.js — audio-reactive point cloud** · colour and a real spectrum | [`strudel-pointcloud-three.html`](strudel-pointcloud-three.html) | [open](https://codepen.io/editor/jacksonfdam/pen/01a092e2-a778-7be2-9ee3-36afaeb2c6d6) |
| 4 | **strudel × ascii cam × voice fx** · the webcam becomes text | [`strudel-ascii-cam.html`](strudel-ascii-cam.html) | [open](https://codepen.io/editor/jacksonfdam/pen/01a09520-8c7e-71dc-a99f-99cdd9e30887) |
| 5 | **the corridor** · the game | [`strudel-tron-head.html`](strudel-tron-head.html) | [open](https://codepen.io/editor/jacksonfdam/pen/01a09573-7cc5-75bc-9254-bafd127239ea) |

Demos 2–5 ask for the camera, and 4 and 5 ask for the microphone. Nothing leaves your machine — the tracking and the analysis both run in the tab.

### 1 · the bridge
A three.js scene rendered through `AsciiEffect`, driven by a live-editable Strudel pattern. Every voice is tagged with `.onTrigger(vis("kick"), false)`; events arrive with their exact `AudioContext` timestamp and the visual fires on the same clock, so picture and sound are locked by construction. Matrix rain with feedback trails, CRT overlay, a terminal that logs every hit, a glitch pass, five palettes.

### 2 · the hands come in
MediaPipe `HandLandmarker` writes a live `hand` object — position, pinch, finger count, two-hand spread, swipe, roll. The pattern reads it through `signal(() => hand.pinch)`: hand height sweeps the hats, pinch opens the bass filter, a fist mutes voices, a swipe reverses the snares. Fingertips push a field of floating orbs; pinch to pick one up.

### 3 · colour and a real spectrum
Selfie segmentation turns your body into an audio-reactive point cloud, the face becomes a second cloud, fingertips leave particle trails, all under bloom. A shim on `AudioNode.connect` mirrors everything Strudel sends to the speakers into an analyser, so `audio.bass / mid / high` are available to visuals *and* patterns. Switchable HUD-kit mode: meters, spectrum, level bar, targeting rings around the palms.

### 4 · the webcam becomes text
The classic green ASCII webcam, five brightness tiers with their own glyph sets. Microphone through a Web Audio chain (drive → ring mod → pitch → delay/feedback → filter; monitor off by default). A playlist with Strudel Bakery tracks and an **Add** field that decodes any `strudel.cc/#…` share link. Bakery code is adapted on the fly for `@strudel/web` (bank aliases, soundfont fallbacks, visual calls stripped).

### 5 · the corridor
Type your name. A first-person corridor in ASCII; blocks come at you; an arrow tells you which way to turn your **head**; look away and it pauses. A distorted narrator says your name — on warnings, hits, near misses, milestones, and when you stop looking — over a Web Audio sub-drone, with background whispers made from formant-filtered noise. Playlist, mic FX and ambient-sound → colour carried over. Uses Strudel's SharedWorker clock so heavy frames never drop a note.

## Run locally

```bash
git clone https://github.com/jacksonfdam/strudel-visuals.git
cd strudel-visuals
npm install      # copies @strudel/web into vendor/ and assets/ for demo 5's worker clock
npx serve .
```

Then open `http://localhost:3000/strudel-tron-head.html` (or any of the five). Demos 1–4 also work by opening the file directly; camera and microphone need `localhost` or HTTPS.

## Deploy

Static host, root directory, no build command. `npm install` runs on the host and produces `vendor/` and `assets/`; both are also committed so the deploy works without an install step. Demo 5 checks for `/assets/clockworker-*.js` at startup and falls back to the CDN scheduler when it isn't there.

## Under the hood — things worth knowing before you fork

- `@strudel/web` 1.1.0 calls `onTrigger` as `(targetTime, hap, …)`, not `(hap, …)` as documented. The bridge locates the hap by shape.
- Inside `evaluate()`, every `"double-quoted string"` becomes a mini-notation Pattern. `vis("kick")` unwraps it.
- Strudel copies all its functions onto `window` at init. Never name a page global `voice`, `speed`, `room`, `pan`, `shape`, `n`, `s`…
- `panic()` is broken in 1.1.0 (kills the output chain). Use `hush()` + `AudioContext.suspend()`.
- The default scheduler *skips* queries when a frame exceeds its 200 ms lookahead — that's the stutter. `sync: true` (SharedWorker clock) fixes it but requires Strudel same-origin and its worker at `/assets/`.
- Chrome speech synthesis: never `speak()` right after `cancel()`; keep utterances referenced; heartbeat pause/resume.

## Credits & license

Code by **Jackson F. de A. Mafra** · [@jacksonfdam](https://github.com/jacksonfdam) · MIT (see [LICENSE](LICENSE)).

Strudel is by Alex McLean and Felix Roos and is **AGPL-3.0** — demo 5 ships a copy; see [THIRD_PARTY.md](THIRD_PARTY.md) for every dependency, sample pack and Bakery pattern author.

I hope you enjoy it; all the code is open-source and shareable. Fork it, break it, test it. Just please include credits, give a shout-out, and share your own experiment :)
