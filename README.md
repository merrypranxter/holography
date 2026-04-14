# Holography Shader Lab

A research-and-implementation repo for translating holography mathematics into procedural visual systems for shader art, raymarching, GLSL, and JavaScript.

## 🚀 Quick Start

```bash
# Clone and explore
git clone https://github.com/merrypranxter/holography.git
cd holography

# Start local server
python3 -m http.server 8000

# Open in browser
# http://localhost:8000           → Interactive Viewer
# http://localhost:8000/docs.html → Theory Browser
```

**Features:**
- ✨ Interactive shader viewer with live parameter controls
- 📚 9 physics concepts (holographic principle, AdS geometry, entanglement, etc.)
- 🎨 3 working shader scenes (horizon hologram, light sheets, RT surfaces)
- 🎛️ Debug visualization modes
- 📖 Complete theory documentation

## Goal
Build computational analogs of holographic principles:
- surface-area encoded complexity
- boundary-to-bulk generation
- AdS radial depth / UV-IR warping
- light-sheet scanning geometries
- entanglement bridges and minimal surfaces
- nonlocal reconstruction fields

## This repo is not
A literal quantum gravity simulator.

## This repo is
A mathematically-informed visual engine that turns holographic ideas into:
- shader parameter systems
- SDF/raymarch spaces
- post-processing motifs
- API-ready concept schemas
- prompt/control vocabularies for generative art systems

## Core rule
When in doubt, convert the physics idea into:
1. geometry
2. field behavior
3. information-density rule
4. rendering consequence
5. controllable parameters

## Structure

```
holography-shader-lab/
  README.md
  docs/
    00_repo_vision.md
    01_holographic_principle.md
    02_ads_geometry_and_scale.md
    03_bulk_boundary_dictionary.md
    04_entanglement_geometry.md
    05_holographic_renormalization.md
    06_black_holes_and_horizons.md
    07_light_sheets_and_screens.md
    08_nonlocality_and_smearing.md
    09_cosmology_and_holographic_matter.md
    10_shader_translation_guide.md
    11_visual_motif_library.md
    12_glossary.md
  theory/
    equations.json
    concepts.json
    visual_mappings.json
    presets.json
  src/
    js/
    glsl/
  examples/
  research/
```

## Docs

- `00_repo_vision.md` — Architecture and philosophy
- `01_holographic_principle.md` — Core statement, visual laws, coding abstractions
- `02_ads_geometry_and_scale.md` — AdS metric, UV/IR, radial depth as scale
- `03_bulk_boundary_dictionary.md` — Boundary drives interior, smearing kernels, precursors
- `04_entanglement_geometry.md` — RT formula, minimal surfaces, phase transitions
- `05_holographic_renormalization.md` — Near-boundary analysis, counterterms, anomalies
- `06_black_holes_and_horizons.md` — Horizon area, stretched horizon, Hawking
- `07_light_sheets_and_screens.md` — Null projection, preferred screens, screen stacks
- `08_nonlocality_and_smearing.md` — Operator support, nonlocal channels, subregion logic
- `09_cosmology_and_holographic_matter.md` — de Sitter, FLRW screens, holographic dark energy
- `10_shader_translation_guide.md` — Full implementation guide for JS + GLSL
- `11_visual_motif_library.md` — 20 reusable scene motifs
- `12_glossary.md` — Every term defined at three levels: physics, repo, code
