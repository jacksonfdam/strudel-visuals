// Shared demo registry. Used by index.html (cards) and demo.html (top nav).
window.DEMOS = [
  {
    id: 'ascii-three',
    n: 1,
    file: 'strudel-ascii-three.html',
    nav: 'the bridge',
    title: 'strudel × three.js — ascii sync',
    tagline: 'the bridge',
    blurb:
      'A three.js scene rendered through AsciiEffect, driven by a live-editable Strudel pattern. Every voice is tagged with .onTrigger(vis("kick"), false) — events arrive with their exact AudioContext timestamp and the visual fires on the same clock, so picture and sound are locked by construction.',
    needs: [],
    pen: 'https://codepen.io/editor/jacksonfdam/pen/01a09251-470c-7551-be0e-26d123661f7b',
  },
  {
    id: 'hands-three',
    n: 2,
    file: 'strudel-hands-three.html',
    nav: 'the hands',
    title: 'strudel × mediapipe hands × three.js',
    tagline: 'the hands come in',
    blurb:
      'MediaPipe HandLandmarker writes a live hand object — position, pinch, finger count, two-hand spread, swipe, roll. Hand height sweeps the hats, pinch opens the bass filter, a fist mutes voices, a swipe reverses the snares. Fingertips push a field of floating orbs.',
    needs: ['camera'],
    pen: 'https://codepen.io/editor/jacksonfdam/pen/01a092a6-716a-72e6-a35a-74572f4de06e',
  },
  {
    id: 'pointcloud-three',
    n: 3,
    file: 'strudel-pointcloud-three.html',
    nav: 'point cloud',
    title: 'strudel × mediapipe × three.js — audio-reactive point cloud',
    tagline: 'colour and a real spectrum',
    blurb:
      'Selfie segmentation turns your body into an audio-reactive point cloud, the face becomes a second cloud, fingertips leave particle trails, all under bloom. A shim on AudioNode.connect mirrors everything Strudel sends to the speakers into an analyser.',
    needs: ['camera'],
    pen: 'https://codepen.io/editor/jacksonfdam/pen/01a092e2-a778-7be2-9ee3-36afaeb2c6d6',
  },
  {
    id: 'ascii-cam',
    n: 4,
    file: 'strudel-ascii-cam.html',
    nav: 'ascii cam',
    title: 'strudel × ascii cam × voice fx',
    tagline: 'the webcam becomes text',
    blurb:
      'The classic green ASCII webcam, five brightness tiers with their own glyph sets. Microphone through a Web Audio chain (drive → ring mod → pitch → delay/feedback → filter). A playlist with Strudel Bakery tracks and an Add field that decodes any strudel.cc share link.',
    needs: ['camera', 'mic'],
    pen: 'https://codepen.io/editor/jacksonfdam/pen/01a09520-8c7e-71dc-a99f-99cdd9e30887',
  },
  {
    id: 'tron-head',
    n: 5,
    file: 'strudel-tron-head.html',
    nav: 'the corridor',
    title: 'the corridor',
    tagline: 'the game',
    blurb:
      'Type your name. A first-person corridor in ASCII; blocks come at you; an arrow tells you which way to turn your head; look away and it pauses. A distorted narrator says your name over a Web Audio sub-drone, with background whispers made from formant-filtered noise.',
    needs: ['camera', 'mic'],
    pen: 'https://codepen.io/editor/jacksonfdam/pen/01a09573-7cc5-75bc-9254-bafd127239ea',
  },
];
