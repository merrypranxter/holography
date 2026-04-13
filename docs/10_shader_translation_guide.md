# 10 — Shader Translation Guide

## 10.1 What this file is

This is the implementation bridge.
It turns the repo’s physics concepts into render architecture.

It answers:

- What should live in JavaScript?
- What should live in GLSL?
- What should be an SDF, a scalar field, a mask, or a post-process?
- When do we use local reconstruction, nonlocal reconstruction, or coarse-grained reconstruction?
- How do we debug whether a scene is actually “holographic” instead of just pretty?

The source theory gives a very clear backbone for this guide:

- near-boundary structure carries source data, and UV cutoffs in the boundary correspond to bulk cutoffs near the AdS boundary :contentReference[oaicite:0]{index=0} :contentReference[oaicite:1]{index=1}
- near-boundary fields admit asymptotic expansions with leading source data and subleading response data, with counterterms used to extract finite observables :contentReference[oaicite:2]{index=2} :contentReference[oaicite:3]{index=3}
- RT surfaces geometrize entanglement in static settings through minimal-area bulk surfaces :contentReference[oaicite:4]{index=4}
- screens and preferred screens arise from null projection, with preferred screens sitting where expansion vanishes :contentReference[oaicite:5]{index=5} :contentReference[oaicite:6]{index=6}
- local bulk reconstruction can fail in backgrounds with trapped null geodesics or evanescent modes, forcing either nonlocal or coarse-grained strategies :contentReference[oaicite:7]{index=7} :contentReference[oaicite:8]{index=8}

## 10.2 The golden architectural split

Use four layers.

### Layer A — scene topology
The coarse object structure:
- SDF bodies
- boundaries
- shells
- horizons
- membranes
- wedge volumes
- screens

### Layer B — holographic fields
The invisible logic:
- boundary source fields
- response fields
- entanglement weights
- null-projection density
- renormalization terms
- precursor channels
- cosmological pressure

### Layer C — transport / reconstruction
How information moves:
- local smearing
- nonlocal precursor injection
- light-sheet growth
- coarse-graining
- horizon scrambling
- RG filtering

### Layer D — image formation
How the above becomes visible:
- raymarch shading
- glow
- spectral lensing
- post-process diffusion
- chromatic anomaly bands
- debug overlays

This separation is essential because the physics distinguishes source, response, geometry, and readout. Near-boundary analysis determines divergent/source structure, but full deep-bulk correlation data generally needs more than asymptotics alone. :contentReference[oaicite:9]{index=9} :contentReference[oaicite:10]{index=10}

## 10.3 Repo implementation map

```text
src/
  js/
    sceneGraph.js
    holographyParams.js
    radialFlows.js
    boundaryEncoders.js
    entanglementGraphs.js
    reconstructionModes.js
    cosmologyState.js
    debugViews.js

  glsl/
    common.glsl
    sdf/
      primitives.glsl
      ads_spaces.glsl
      blackhole_sdfs.glsl
      membrane_sdfs.glsl
      screen_sdfs.glsl
    fields/
      source_field.glsl
      response_field.glsl
      entropy_field.glsl
      uv_ir_field.glsl
      light_sheet_field.glsl
      entanglement_field.glsl
      horizon_scramble.glsl
      operator_smear.glsl
      precursor_field.glsl
      renorm_field.glsl
      cosmic_pressure.glsl
    render/
      raymarch.glsl
      normals.glsl
      shading.glsl
      lighting.glsl
      post.glsl
      debug.glsl
    scenes/
      scene_surface_volume.glsl
      scene_ads_tunnel.glsl
      scene_rt_surface.glsl
      scene_horizon_hologram.glsl
      scene_light_sheet_screen.glsl
      scene_precursor_chamber.glsl
      scene_future_horizon_universe.glsl
````

## 10.4 What belongs in JavaScript

JavaScript should hold:

* state
* topology graph data
* long-timescale evolution
* boundary textures / operator maps
* entanglement graphs
* cosmology parameters
* mode switching
* debug panels
* CPU-side precomputation

Do in JS:

* build the boundary sample set
* forecast future-horizon values
* update relation graphs
* choose reconstruction mode
* manage temporal history buffers
* precompute support clouds
* generate screen stacks
* pass uniforms and textures to GLSL

### Example JS scene state

```js
export const sceneState = {
  mode: "ads_rt_blackhole_hybrid",
  cameraMode: "null_follow",
  reconstructionMode: "precursor_assisted",
  params: {
    boundaryDepth: 0.03,
    warpIntensity: 1.2,
    smearSupportRadius: 0.18,
    precursorWeight: 0.35,
    horizonRadius: 0.9,
    stretchedHorizonWidth: 0.06,
    entanglementWeight: 0.72,
    bridgeThreshold: 0.42,
    cutoffRho: 0.025,
    anomalyMix: 0.15
  },
  debug: {
    showBoundarySupport: false,
    showRTSurface: false,
    showScreens: false,
    showCounterterm: false,
    showRecoverableDepth: false
  }
};
```

## 10.5 What belongs in GLSL

GLSL should hold:

* fast local field evaluation
* SDF evaluation
* march loop
* normals
* shell weighting
* glow accumulation
* short-range kernels
* depth-dependent frequency scaling
* caustic/screen emphasis
* post effects

Do in GLSL:

* evaluate warped coordinates
* compute shell and membrane weights
* evaluate source/response fields locally
* integrate short boundary sample kernels
* apply depth-aware ray steps
* accumulate emission
* output debug render targets

Rule of thumb:
if the quantity must be sampled per-fragment or per-step, it belongs in GLSL.

## 10.6 Core data types

Every scene element should be one of these.

### SDF object

Use for:

* bodies
* shells
* horizons
* membranes
* screens
* wedge boundaries

### Scalar field

Use for:

* entropy density
* response amplitude
* coarse-grained visibility
* renormalized finite part
* cosmological pressure
* reconstruction confidence

### Vector field

Use for:

* null congruence direction
* entanglement flow
* radial RG flow
* shell tangent drift
* beam convergence direction

### Graph / relation object

Use for:

* entanglement connectivity
* precursor coupling
* operator-support clouds
* screen-family hierarchy

### Texture / operator map

Use for:

* explicit boundary inscriptions
* source maps
* glyph atlases
* historical buffers
* response caches

## 10.7 The one true render pipeline

A holographic scene should usually render in this order:

### Pass 1 — build boundary state

Generate or update:

* source maps
* operator glyphs
* history buffers
* entanglement graph textures
* cosmology horizon values

### Pass 2 — choose geometry logic

Choose:

* pure AdS
* black hole
* screen stack
* RT membrane
* cosmic screen mode
* hybrid scene mode

### Pass 3 — choose reconstruction mode

Choose one:

* local smear
* precursor assisted
* coarse grained
* failed local readout

This matters because the theory does not support one universal local readout map in all backgrounds. Trapped null geodesics and evanescent modes are real obstructions.  

### Pass 4 — raymarch topology

Raymarch SDFs in warped coordinates.

### Pass 5 — evaluate holographic fields

At each step compute:

* source contribution
* response contribution
* null-sheet density
* entanglement bridge weight
* horizon scrambling
* renormalization layers

### Pass 6 — renormalize visible quantity

Subtract counterterm-like shell artifacts and keep finite response where appropriate. The point is not to “drop infinities by vibe,” but to separate near-boundary divergent structure from meaningful finite structure.  

### Pass 7 — shade and post-process

Add:

* spectral glow
* anomaly bands
* photon-ring accents
* caustic bloom
* debug overlays

## 10.8 Coordinate systems you actually want

Use several coordinate views.

### Euclidean scene coordinates

For easy editing and interaction.

### AdS-inspired warped coordinates

For depth/scale logic.
Near-boundary cutoffs correspond to UV cutoffs, so the boundary side of the scene should be treated as a high-frequency zone with explicit cutoff control. 

### Null coordinates

For light-sheet and screen scenes.

### Boundary UV coordinates

For source/operator textures.

### Relation coordinates

For graph-driven entanglement or precursor control.

Do not force one coordinate system to do every job.

## 10.9 Standard shader skeleton

```glsl
struct Hit {
    float d;
    int materialId;
};

struct FieldData {
    float source;
    float response;
    float entropy;
    float nullSheet;
    float entanglement;
    float scramble;
    float counterterm;
    float finitePart;
};

Hit sceneSDF(vec3 p);
FieldData evalFields(vec3 p, float t);

vec3 render(vec3 ro, vec3 rd, float t) {
    float dist = 0.0;
    vec3 color = vec3(0.0);

    for (int i = 0; i < MAX_STEPS; i++) {
        vec3 p = ro + rd * dist;
        Hit hit = sceneSDF(p);
        FieldData f = evalFields(p, t);

        color += accumulateEmission(p, f, hit);

        if (hit.d < SURF_EPS) {
            color += shadeSurface(p, rd, hit, f);
            break;
        }

        dist += stepRule(p, hit.d, f);
        if (dist > MAX_DIST) break;
    }

    return postColor(color);
}
```

## 10.10 Step rules are physical style

Step size should not be constant.

### Near boundary

Use smaller steps.
The geometry and field structure are more singular and source-heavy there. Near-boundary analysis is exactly where the important divergent/source structure lives. 

### Near horizon

Use smaller steps.
Scrambling shells, photon rings, and redshift features are thin.

### In unresolved evanescent zones

Increase blur, not precision.
The theory says exact sharp reconstruction may require exponential precision, so do not pretend by oversampling indefinitely. Use coarse-graining instead. 

### Sample rule

```glsl
float stepRule(vec3 p, float sdfD, FieldData f) {
    float zScale = clamp(adsDepth(p) * 0.2, 0.03, 0.25);
    float shellPenalty = mix(1.0, 0.35, f.scramble);
    float nullPenalty = mix(1.0, 0.5, f.nullSheet);
    return sdfD * zScale * shellPenalty * nullPenalty;
}
```

## 10.11 Standard field decomposition

Every meaningful scene field should decompose as:

```text
raw field
= source
+ response
+ nonlocal correction
+ anomaly/log residue
```

This mirrors the asymptotic source/response logic and anomaly structure of holographic renormalization. The leading coefficient is the source, subleading coefficients are recursively determined response terms up to a state-dependent slot, and log terms encode anomaly structure.  

### Recommended GLSL struct

```glsl
struct Decomp {
    float source;
    float response;
    float precursor;
    float anomaly;
};
```

## 10.12 Boundary-to-bulk injection pattern

Do not let one UV point own one interior point.

Use:

* local support cloud
* time window
* depth attenuation
* optional precursor correction

```glsl
float localSmear(vec3 p, float t) {
    float acc = 0.0;
    float norm = 0.0;
    for (int i = 0; i < BOUNDARY_SAMPLES; i++) {
        vec3 b = boundaryPos(i);
        float dt = abs(t - boundaryTime(i));
        float dx = length(p.xz - b.xz);
        float w = exp(-dx * SMEAR_K) * exp(-dt * SMEAR_T);
        float src = sourceTexture(boundaryUV(i)).r;
        acc += w * src;
        norm += w;
    }
    return acc / max(norm, 1e-4);
}
```

That is the implementation echo of the smearing-function viewpoint. But the repo must still allow this to fail in hostile geometries. 

## 10.13 Reconstruction mode switch

```js

export function selectReconstructionMode(flags) {
  if (flags.hasTrappedGeodesics || flags.hasStrongEvanescence) {
    return "coarse_grained";
  }
  if (flags.requiresEarlyKnowledge) {
    return "precursor_assisted";
  }
  return "local_smear";
}
```

This is not just engineering convenience.
It is theoretically honest.

## 10.14 How to render entanglement

RT is for static settings and computes entropy through minimal-area surfaces in the bulk. So your entanglement renderer should treat membranes as **structural surfaces**, not decorative wires. 

Implementation pattern:

* JS stores relation graph
* JS decides connected vs disconnected phase
* GLSL renders candidate membrane / bridge field
* scene picks lower-cost phase

### Phase logic

```js
function bridgePhase(weight, threshold) {
  return weight > threshold ? "connected" : "disconnected";
}
```

### Geometry logic

Use:

* saddle membrane
* soap-film bridge
* wedge overlap
* tear field on disconnect

Do not default to cylinders or bezier noodles.

## 10.15 How to render screens and light-sheets

Screens come from null projection.
Preferred screens occur where expansion vanishes; screen-hypersurfaces are families of such surfaces.  

Implementation pattern:

* JS picks null slice family
* JS estimates allowed directions
* GLSL emits beam families
* GLSL terminates at caustics or screen conditions
* preferred-screen regions get higher coherence/brightness

### Screen field

```glsl
float preferredScreenWeight(float theta) {
    return exp(-abs(theta) * 40.0);
}
```

### Light-sheet field

```glsl
float lightSheetDensity(vec3 p, vec3 origin, vec3 dir) {
    vec3 q = p - origin;
    float axial = dot(q, dir);
    float radial = length(q - axial * dir);
    return exp(-radial * 8.0) * exp(-max(axial, 0.0) * 0.9) * step(0.0, axial);
}
```

## 10.16 How to render horizons

Black-hole entropy scales with horizon area, and the stretched horizon is the visible operational membrane where outside-observer dynamics live. The horizon is also a minimal surface in the black-hole case, which is part of why it talks cleanly to RT-style rendering.  

Implementation pattern:

* JS computes area budget from horizon radius
* GLSL renders true horizon logic + stretched horizon shell
* infalling objects lose identity into shell scrambling
* interior readout confidence drops

### Shell rule

```glsl
float stretchedHorizonShell(vec3 p, float rs, float width) {
    return exp(-abs(length(p) - rs * (1.0 + width)) * 60.0);
}
```

## 10.17 How to render renormalization

Near-boundary asymptotic data should be handled explicitly.
Fefferman–Graham form and asymptotic field expansions tell you that the boundary zone is where source and divergence structure live; counterterms give a consistent way to remove local divergences and retain finite response.  

Implementation pattern:

* evaluate raw shell field
* evaluate local counterterm
* subtract to get finite part
* preserve anomaly/glitch residual

### Counterterm pass

```glsl
float countertermLocal(float shellValue, float gradMag, float rho) {
    return 0.7 * shellValue / max(rho, 1e-3)
         + 0.15 * gradMag
         + 0.08 * log(1.0 / max(rho, 1e-3));
}
```

## 10.18 How to render evanescent / unresolved zones

When evanescent modes matter, exact reconstruction requires exponential precision; coarse-graining over a boundary scale can recover information only to a comparable depth scale. 

Implementation pattern:

* compute recoverable depth from sigma
* if depth exceeds sigma, suppress sharp structure
* replace with blurred macro-amplitude
* optionally expose “probe mode” to recover more

### Rule

```js
function recoverableDepth(sigma) {
  return sigma;
}
```

This is one of the most important anti-fake rules in the repo.

## 10.19 Camera logic

You want more than one camera mode.

### Observer-centric

Use for:

* stretched-horizon scenes
* de Sitter observer patch
* screen-facing portraits

### Null-follow

Use for:

* light-sheet scenes
* causal cone scenes
* converging beam cathedrals

### RG descent

Move mostly along the holographic depth axis so motion feels like changing scale, not just translating through room coordinates. The UV/IR guidance from the theory makes this the natural camera for AdS-inspired scenes. 

### Entanglement orbit

Orbit around wedge overlaps and minimal-surface bridges.

## 10.20 Post-processing rules

Post should encode physics layers, not just make things “cool.”

### Bloom

Use for:

* shells
* screens
* caustics
* preferred surfaces

### Chromatic shift

Use for:

* anomaly residues
* horizon redshift
* deep-bulk precursor fog

### Blur

Use for:

* unresolved evanescent regions
* deconfined thermal shell haze
* coarse-grained recovery mode

### Temporal echo

Use for:

* precursor channels
* boundary memory
* delayed Hawking-like emission

## 10.21 Debug views you absolutely want

The repo should ship with these debug passes.

### Boundary source

See the operator/source map directly.

### Response only

See finite interior response without shell blow-up.

### Counterterm

See what gets subtracted.

### Screen map

See preferred screens and null slices.

### RT surface

See minimal/bridge candidates.

### Reconstruction confidence

See local readability vs precursor-only zones.

### Recoverable depth

See where evanescent/coarse-grained constraints cut off detail.

### Horizon area budget

See shell complexity budget.

These are not optional.
Without them the repo will drift into fake mysticism.

## 10.22 Standard scene assembly recipes

### Recipe A — surface-encoded figure

* SDF humanoid or mask
* shell source texture
* inward smear field
* hollow interior
* renorm pass
* shell bloom

### Recipe B — AdS tunnel

* warped coordinates
* hyperbolic grid
* UV-rich boundary
* low-frequency deep bulk
* RG-descent camera

### Recipe C — RT bridge

* two source regions
* relation graph
* wedge overlap
* connected/disconnected phase test
* membrane SDF
* tear post-process

### Recipe D — horizon membrane

* true horizon radius
* stretched horizon shell
* identity-loss melt
* photon-ring accent
* precursor-only interior residue

### Recipe E — screen cathedral

* seed surface
* allowed null directions
* beam fans
* caustic termination
* preferred-screen stack
* transparent membrane shading

### Recipe F — cosmological pressure hall

* expanding screen stack
* future horizon estimate
* holographic matter pressure field
* dark-radiation residue
* observer/global mode switch

## 10.23 Performance rules

Do not waste samples where theory says resolution is fake.

### Good places to spend budget

* shells
* screen surfaces
* near-boundary UV zone
* RT membranes
* photon rings
* caustics

### Good places to save budget

* unresolved deep-bulk evanescent zones
* fully thermalized horizon interiors
* coarse-grained cosmic pressure fog
* precursor-only shadow regions

This is one of the few cases where physics intuition aligns beautifully with GPU optimization.

## 10.24 Parameter naming rules

Keep the parameter names semantically clean.

Use:

* `boundaryDepth`
* `cutoffRho`
* `smearSupportRadius`
* `precursorWeight`
* `recoverableDepth`
* `screenThreshold`
* `horizonRadius`
* `stretchedHorizonWidth`
* `entanglementWeight`
* `bridgeThreshold`
* `futureEventHorizon`
* `darkRadiationMix`

Avoid vague names like:

* `magicGlow`
* `spaceWeirdness`
* `mysticFactor`

## 10.25 A full scene contract

Every scene file should declare:

```js
export const sceneContract = {
  topology: ["sdf_shell", "screen_stack", "membrane"],
  fields: ["source", "response", "null_sheet", "precursor"],
  reconstruction: "precursor_assisted",
  renormalization: true,
  cameraModes: ["observer", "null_follow"],
  debugViews: [
    "source",
    "response",
    "screen_map",
    "reconstruction_confidence"
  ]
};
```

## 10.26 The central anti-fake test

Ask these questions.

1. Is bulk structure caused by a boundary/source/screen law?
2. Does depth change scale or recoverability?
3. Are light-sheet and screen scenes directional and terminating?
4. Are entanglement bridges driven by relation, not ornament?
5. Are black-hole interiors losing readability?
6. Is near-boundary structure separated into source/divergence/finite response?
7. Are hostile geometries allowed to fail clean local reconstruction?

If not, the scene is probably “holography flavored,” not holography translated.

## 10.27 Minimal starter stack

If you want the first working version fast:

* JS:

  * source map
  * scene params
  * reconstruction mode
  * relation graph
* GLSL:

  * one shell SDF
  * one AdS warp
  * one local smear field
  * one precursor field
  * one membrane field
  * one renorm subtraction
  * one debug pass

That is enough to build:

* a surface-encoded figure
* an AdS tunnel
* an RT bridge
* a horizon membrane
* a screen stack scene

