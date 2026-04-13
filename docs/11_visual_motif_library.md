
## 11.1 What this file is

This is the reusable lookbook for the repo.

Not “style” in the empty moodboard sense.
These motifs are scene archetypes tied to actual holographic structures:
- area-law shells
- AdS scale gradients
- bulk-from-boundary emergence
- RT membranes
- preferred screens
- stretched horizons
- precursor ghosts
- evanescent blur
- future-horizon cosmology

The goal is simple:
take one motif,
plug it into JS + GLSL + raymarching,
and get a scene that still feels mathematically governed.

The source spine for this motif library is clear:
surface-first encoding and radial resolution gradients are already the right visual translation of the holographic principle and AdS scale logic. Entanglement naturally becomes filaments, tunnels, and minimal membranes. Preferred screens arise where null expansion vanishes. The de Sitter observer horizon is a preferred screen of constant area. And stretched horizons plus light-sheets provide the right logic for shell, screen, and horizon aesthetics. :contentReference[oaicite:0]{index=0} :contentReference[oaicite:1]{index=1} :contentReference[oaicite:2]{index=2} :contentReference[oaicite:3]{index=3} :contentReference[oaicite:4]{index=4}

---

## 11.2 How to use the library

Each motif has:

- **Core principle**
- **Visual DNA**
- **Scene role**
- **Shader strategy**
- **Parameter cluster**
- **Prompt tokens**
- **Failure mode**

You should be able to combine 2–4 motifs per scene without collapsing into nonsense.

Rule:
one motif usually controls **geometry**, one controls **information flow**, one controls **illumination**, and one controls **failure/degradation**.

---

## 11.3 Motif 01 — Surface Glyphshell

### Core principle
Information lives on the boundary, not in the volume.

### Visual DNA
- glowing shell
- hollow or refractive interior
- encoded glyph skin
- pulsation on boundary
- shell cracks, maps, logic scars

### Scene role
Best as:
- character body
- planet-like object
- mask
- chamber wall
- seed object for null projection

### Shader strategy
- shell-weighted emission
- UV-driven glyph atlas
- transparent interior
- weak interior refractive haze
- optional local smear into bulk

### Parameter cluster
```json
{
  "shellGlow": 1.4,
  "glyphDensity": 18.0,
  "interiorOpacity": 0.15,
  "surfacePulse": 0.35,
  "logicCrackGain": 0.22
}
````

### Prompt tokens

* `surface-encoded`
* `glyphshell`
* `hollow interior`
* `logic skin`
* `boundary pulse`

### Failure mode

Making the interior equally detailed as the shell.

This motif is directly supported by the visual-translation rules in your holographic art source, which explicitly says to prioritize surface detail, make interiors hollow/refractive, and let boundaries glow with encoded logic.  

---

## 11.4 Motif 02 — AdS Edge Saturation

### Core principle

Outer / near-boundary regions carry finer resolution than deeper bulk regions.

### Visual DNA

* ultradetailed edges
* recursive outer ornament
* softened deep center
* depth-gradient detail loss
* concentric or radial recursion

### Scene role

Best as:

* tunnels
* cathedral halls
* infinite zoom spaces
* boundary-ring chambers
* camera-depth worlds

### Shader strategy

* coordinate warp with depth
* frequency redshift by depth
* boundary cutoff
* finer noise bands near UV edge
* smoother interior macro fields

### Parameter cluster

```json
{
  "boundaryDepth": 0.03,
  "warpIntensity": 1.15,
  "uvIrMix": 0.8,
  "boundaryDetailGain": 1.8,
  "deepBulkSoftness": 0.55
}
