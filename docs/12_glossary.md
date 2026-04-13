# 12 — Glossary

## 12.1 How to read this glossary

This glossary is not written like a pure physics textbook.
Each term has three layers:

- **Physics meaning** — what it means in holography/math
- **Repo meaning** — how we use it in this project
- **Code meaning** — what it tends to become in JS / GLSL / raymarching

The aim is to make every important word in the repo executable.

---

## AdS (Anti-de Sitter space)

**Physics meaning**  
A spacetime with negative cosmological constant, used as the canonical bulk geometry in AdS/CFT.

**Repo meaning**  
The default warped bulk space where radial depth behaves like scale.

**Code meaning**  
Usually a depth warp, metric-inspired scaling field, or coordinate remap.

**Related**  
UV/IR, boundary, bulk, Fefferman–Graham, holographic renormalization

---

## AdS/CFT

**Physics meaning**  
A holographic duality relating gravity in AdS to a conformal field theory on its boundary.

**Repo meaning**  
The master blueprint for “boundary data generates bulk structure.”

**Code meaning**  
The architecture rule: source maps on a lower-dimensional surface control higher-dimensional render behavior.

---

## anomaly

**Physics meaning**  
A symmetry-related leftover that survives renormalization, often appearing through logarithmic terms in near-boundary expansions.

**Repo meaning**  
A residual visual trace that should remain after subtracting local divergences.

**Code meaning**  
Thin chromatic scars, interference bands, or log-sensitive shell glows.

---

## apparent horizon

**Physics meaning**  
A surface where at least one orthogonal null expansion vanishes. In many constructions it separates normal, trapped, and anti-trapped regions.

**Repo meaning**  
A pivot surface where projection behavior changes.

**Code meaning**  
A mask or surface where beam direction, screen logic, or readout confidence flips.

---

## area law

**Physics meaning**  
The idea that entropy in gravitational systems scales with area rather than volume, especially in black-hole entropy.

**Repo meaning**  
Complexity budget should often scale with visible or effective surface area.

**Code meaning**  
Detail budget, symbol count, or sample density driven by shell area instead of object volume.

---

## asymptotic expansion

**Physics meaning**  
A near-boundary series expansion of bulk fields or metrics, with leading source terms and subleading response terms.

**Repo meaning**  
The rule that the boundary tells you how the deep bulk should begin to unfold.

**Code meaning**  
A layered field like `source + rho*response + rho^2*... + log(rho)*anomaly`.

The near-boundary Fefferman–Graham setup, source/response split, and log-term anomaly structure are core parts of holographic renormalization, while AdS/CFT itself provides the bulk/boundary framework that makes this split meaningful. :contentReference[oaicite:0]{index=0} :contentReference[oaicite:1]{index=1}

---

## beam fan

**Physics meaning**  
Not a formal term, but a useful visual name for a family of null rays or light-sheet generators.

**Repo meaning**  
A visible projection family used to reconstruct bulk form from a surface.

**Code meaning**  
A set of directional density lobes or converging ray bundles.

---

## Bekenstein–Hawking entropy

**Physics meaning**  
The entropy of a black hole, proportional to one quarter of the horizon area in Planck units.

**Repo meaning**  
The reason horizons should be treated as information membranes.

**Code meaning**  
Horizon area sets shell complexity, glyph count, photon-ring richness, or thermal texture budget.

---

## bit thread

**Physics meaning**  
A flow-based reformulation of holographic entanglement where flux lines represent entanglement structure.

**Repo meaning**  
A good mental model for entanglement filaments and relation flows.

**Code meaning**  
Directed strand fields, flux curves, or graph-to-line render systems.

---

## black-hole complementarity

**Physics meaning**  
A principle proposed to preserve quantum mechanics in black-hole physics while giving up naive observer-independent locality across the horizon.

**Repo meaning**  
Outside and infalling viewpoints should not be rendered as one naive unified visual story.

**Code meaning**  
Observer-mode switch, horizon-shell logic, and different readout rules inside vs outside.

---

## boundary

**Physics meaning**  
The lower-dimensional surface or asymptotic region on which dual data lives.

**Repo meaning**  
The control surface for bulk generation.

**Code meaning**  
A UV map, shell surface, screen, horizon skin, or explicit operator texture domain.

---

## boundary operator

**Physics meaning**  
An operator in the boundary theory dual to a bulk field or excitation.

**Repo meaning**  
An encoded source unit on the shell or screen.

**Code meaning**  
A source texture, symbolic activation patch, graph node, or time-varying control cell.

---

## bulk

**Physics meaning**  
The higher-dimensional spacetime region dual to the boundary theory.

**Repo meaning**  
The interior generated from boundary logic.

**Code meaning**  
The 3D or 4D field domain your shaders raymarch through.

The boundary/bulk relation, the extrapolate dictionary, and local-vs-nonlocal reconstruction all come from the holographic duality framework and its reconstruction machinery. :contentReference[oaicite:2]{index=2} :contentReference[oaicite:3]{index=3}

---

## bulk reconstruction

**Physics meaning**  
The attempt to recover bulk operators or fields from boundary data.

**Repo meaning**  
The process that turns shell data into interior form.

**Code meaning**  
A smearing kernel, nonlocal support cloud, precursor path, or coarse-grained recovery function.

---

## bulk-to-boundary propagator

**Physics meaning**  
A kernel used to connect bulk fields to boundary source behavior, especially in Euclidean/source contexts.

**Repo meaning**  
A source-injection map, not always the same as a Lorentzian smearing map.

**Code meaning**  
A source transfer operator, usually distinct from the reconstruction kernel used for state data.

---

## caustic

**Physics meaning**  
A focusing region where nearby null generators intersect or become singular as a congruence.

**Repo meaning**  
A projection termination membrane or compression zone.

**Code meaning**  
A bright shell, focal band, or stopping surface where beams collapse.

---

## causal wedge / causally connected region

**Physics meaning**  
The bulk region causally accessible from a given boundary region.

**Repo meaning**  
The admissible bulk territory owned by a boundary patch.

**Code meaning**  
A domain mask limiting which points a boundary segment can validly influence.

---

## coarse graining

**Physics meaning**  
A lower-resolution description that smooths over fine detail.

**Repo meaning**  
The correct fallback when sharp reconstruction is impossible.

**Code meaning**  
Blur, mip selection, low-pass filtering, reduced harmonic recovery, or reduced sample depth.

---

## congruence

**Physics meaning**  
A family of curves, often geodesics; in this repo, usually null geodesics.

**Repo meaning**  
A projection family.

**Code meaning**  
A set of beam directions or ray generators.

---

## conformal boundary

**Physics meaning**  
The boundary obtained after conformal compactification, often where the boundary theory is defined.

**Repo meaning**  
The ideal outer encoding surface of AdS-like scenes.

**Code meaning**  
The `z -> 0` side of the scene or the outer cutoff shell of an AdS warp.

---

## counterterm

**Physics meaning**  
A local covariant subtraction term added at a cutoff surface to remove divergences and define finite observables.

**Repo meaning**  
A structured subtraction layer, not a random fade or clip.

**Code meaning**  
A local shell function depending on cutoff, field value, and derivatives.

---

## covariant entropy bound

**Physics meaning**  
The statement that entropy on an allowed light-sheet is bounded by one quarter of the area of the generating surface.

**Repo meaning**  
The reason projection must be null, directional, and expansion-aware.

**Code meaning**  
A rule that only certain beam families are valid, and that their information budget is area-controlled.

The covariant bound uses null congruences with nonpositive expansion, and Bousso’s screen construction builds preferred screens by projecting along directions of nonnegative expansion until the sign flips. :contentReference[oaicite:4]{index=4} :contentReference[oaicite:5]{index=5}

---

## de Sitter space

**Physics meaning**  
A spacetime with positive cosmological constant, central to cosmology and horizon thermodynamics.

**Repo meaning**  
The main cosmological holography lab.

**Code meaning**  
Either an observer-patch dome scene or a global paired-screen cosmology scene.

---

## detail budget

**Physics meaning**  
Not a formal physics term.

**Repo meaning**  
How much visible complexity a surface or region is allowed to carry.

**Code meaning**  
Noise octaves, symbol count, ray steps, line density, or microstructure frequency.

---

## dual theory

**Physics meaning**  
A lower-dimensional nongravitational theory equivalent to a gravitational bulk description, such as the CFT in AdS/CFT.

**Repo meaning**  
The readable surface-side description of a bulk scene.

**Code meaning**  
The API/control/schema layer that defines source-side logic.

---

## entanglement entropy

**Physics meaning**  
The entropy associated with tracing out part of a quantum system.

**Repo meaning**  
The master relation measure that becomes geometry in holographic scenes.

**Code meaning**  
A graph weight, bridge cost, membrane area proxy, or wedge-overlap strength.

---

## entanglement wedge

**Physics meaning**  
The bulk region naturally associated with a boundary subregion and its extremal surface.

**Repo meaning**  
The interior chamber owned by a boundary patch.

**Code meaning**  
A wedge field, region mask, or interior ownership volume.

---

## evanescent mode

**Physics meaning**  
A mode whose amplitude is exponentially suppressed at the boundary while growing toward the interior.

**Repo meaning**  
A hidden-bulk mode that destroys naive sharp readout.

**Code meaning**  
A field that forces coarse-grained reconstruction, blurred recovery, or probe-only reveal.

Rosenhaus’s reconstruction discussions treat evanescent modes as the reason sharp local reconstruction can require exponential precision, motivating coarse-grained recovery instead. :contentReference[oaicite:6]{index=6}

---

## event horizon

**Physics meaning**  
The causal boundary beyond which signals cannot escape to a given observer.

**Repo meaning**  
A hidden-region threshold and a screen candidate.

**Code meaning**  
A geometric radius or surface where readout confidence collapses.

---

## expansion scalar (theta)

**Physics meaning**  
A measure of whether a congruence is focusing or diverging.

**Repo meaning**  
The validity test for light-sheets and the detector for preferred screens.

**Code meaning**  
A signed field that gates beam families and highlights theta-zero surfaces.

---

## Fefferman–Graham coordinates

**Physics meaning**  
A standard near-boundary coordinate system for asymptotically AdS spacetimes.

**Repo meaning**  
The coordinate language of source/response extraction.

**Code meaning**  
A cutoff-coordinate system using `rho` or similar depth to organize asymptotic terms.

---

## finite part

**Physics meaning**  
The renormalized remainder after divergent terms and counterterms are handled.

**Repo meaning**  
The actually meaningful visible response.

**Code meaning**  
The quantity you usually want to shade after subtracting local shell artifacts.

---

## future event horizon

**Physics meaning**  
A horizon length defined by integrating the future expansion history of the universe.

**Repo meaning**  
The preferred IR scale for holographic dark-energy scenes.

**Code meaning**  
A forecast-driven cosmic control parameter that sets low-frequency pressure fields.

The cosmology notes explicitly use the future event horizon as the IR scale in holographic dark energy, leading to a density of order \(3C^2M_p^2/L^2\), and Bousso shows that de Sitter also has preferred screen structures tied to horizons and infinity. :contentReference[oaicite:7]{index=7} :contentReference[oaicite:8]{index=8}

---

## global screen

**Physics meaning**  
A screen used to encode an entire spacetime or a very large part of it.

**Repo meaning**  
A universe-scale display surface.

**Code meaning**  
A huge wall, infinity surface, or evolving screen-hypersurface stack.

---

## holographic dark energy / holographic matter

**Physics meaning**  
A cosmological energy-density model of order \(3C^2M_p^2/L^2\), often tied to an IR horizon scale.

**Repo meaning**  
A cosmic pressure field linked to screen size or future horizon size.

**Code meaning**  
A low-frequency density field controlling expansive cosmic mood.

---

## holographic principle

**Physics meaning**  
The idea that the information content of a region is bounded by surface area rather than volume, with covariant realization on light-sheets.

**Repo meaning**  
The base rule of the whole project.

**Code meaning**  
Boundary-driven interiors, area-driven detail budgets, and null-projection logic.

---

## holographic renormalization

**Physics meaning**  
The near-boundary regularization and subtraction procedure used to define finite observables in holographic setups.

**Repo meaning**  
How the repo keeps boundary blow-up meaningful instead of messy.

**Code meaning**  
Cutoff control, asymptotic decomposition, counterterm subtraction, and anomaly preservation.

---

## horizon area budget

**Physics meaning**  
A repo phrase derived from the black-hole area law.

**Repo meaning**  
The complexity budget assigned to a horizon shell by its area.

**Code meaning**  
A function of radius used to drive shell detail and emission structure.

---

## light-ray / null geodesic

**Physics meaning**  
A null curve in spacetime.

**Repo meaning**  
The path along which valid holographic projection happens.

**Code meaning**  
A directional ray family or beam trajectory.

---

## light-sheet

**Physics meaning**  
A null hypersurface generated from a surface along an orthogonal congruence with nonpositive expansion.

**Repo meaning**  
The valid projection manifold for holographic information flow.

**Code meaning**  
A converging beam density field with termination rules.

---

## membrane

**Physics meaning**  
A general geometric surface. In this repo it often means an RT-like bridge, screen, or horizon skin.

**Repo meaning**  
A visible information-bearing surface.

**Code meaning**  
A thin SDF shell or tensioned sheet field.

---

## minimal surface

**Physics meaning**  
A surface of extremal/minimal area, central to the Ryu–Takayanagi prescription in static cases.

**Repo meaning**  
The geometric form of shared information.

**Code meaning**  
A bridge membrane, saddle field, or tension-minimized sheet.

Headrick’s notes motivate RT by the black-hole horizon and then state the general area formula for entanglement in static holographic settings. :contentReference[oaicite:9]{index=9} :contentReference[oaicite:10]{index=10}

---

## mutual information

**Physics meaning**  
A measure of shared information between two subsystems.

**Repo meaning**  
A threshold-control quantity for deciding whether bridges or shared chambers should appear.

**Code meaning**  
A graph weight or phase variable controlling connected vs disconnected geometry.

---

## null projection

**Physics meaning**  
Projection of information along null hypersurfaces.

**Repo meaning**  
The correct holographic projection logic.

**Code meaning**  
Beam-march or screen-construction logic based on null directions.

---

## observer patch

**Physics meaning**  
The causally accessible region for a given observer, especially in de Sitter.

**Repo meaning**  
The finite visible universe mode.

**Code meaning**  
A dome-like horizon-bounded scene with beyond-horizon suppression.

---

## operator support cloud

**Physics meaning**  
Not a standard formal term; a repo phrase for the distributed boundary support controlling a bulk point.

**Repo meaning**  
A visualization of smearing support.

**Code meaning**  
A weighted set of boundary samples or a debug overlay.

---

## photon ring

**Physics meaning**  
A thin optical ring associated with strongly lensed null trajectories near a compact object.

**Repo meaning**  
A horizon-adjacent visual accent.

**Code meaning**  
A thin bright band around a black-hole shell.

---

## precursor

**Physics meaning**  
A highly nonlocal boundary operator encoding bulk information before local boundary observables can cleanly reveal it.

**Repo meaning**  
The hidden global channel for early or unreachable bulk knowledge.

**Code meaning**  
A global low-frequency field, graph mode, or distributed latent control path.

---

## preferred screen

**Physics meaning**  
A screen on which the expansion vanishes.

**Repo meaning**  
A specially efficient display membrane.

**Code meaning**  
A theta-zero emphasis surface with extra coherence, brightness, or legibility.

---

## radial depth

**Physics meaning**  
In AdS-like settings, the extra coordinate organizing scale.

**Repo meaning**  
Depth is not just distance; it is descriptive scale.

**Code meaning**  
A coordinate controlling frequency, warp strength, blur, and RG behavior.

Bousso’s preferred-screen logic, de Sitter/FRW screen examples, and AdS boundary/cutoff intuition all feed this repo notion that geometry uses special surfaces and special depth, not plain Euclidean distance. :contentReference[oaicite:11]{index=11} :contentReference[oaicite:12]{index=12} :contentReference[oaicite:13]{index=13}

---

## recoverable depth

**Physics meaning**  
A repo phrase inspired by evanescent-mode limits: how deep sharp reconstruction can go at a given resolution.

**Repo meaning**  
The maximum depth where your current readout can still be trusted.

**Code meaning**  
A scalar threshold tied to coarse-graining scale.

---

## reconstruction confidence

**Physics meaning**  
Not a standard formal term.

**Repo meaning**  
A numerical estimate of how valid local bulk readout is.

**Code meaning**  
A mask combining trapped-geodesic, horizon, support, and evanescence tests.

---

## Rényi entropy

**Physics meaning**  
A family of entropies generalizing von Neumann entropy.

**Repo meaning**  
Useful when you want multiple relation scales rather than one single entanglement number.

**Code meaning**  
Alternative graph-weight channels or multi-order relation metrics.

---

## response field

**Physics meaning**  
The subleading or state-dependent bulk reaction to a source.

**Repo meaning**  
What the interior does because of the boundary, not what the boundary explicitly writes.

**Code meaning**  
A derived field layered on top of source data.

---

## RG flow / renormalization-group flow

**Physics meaning**  
Scale evolution of an effective description.

**Repo meaning**  
The reason deeper bulk becomes coarser or more collective.

**Code meaning**  
Depth-dependent filtering, structure merging, or frequency suppression.

---

## Ryu–Takayanagi formula (RT)

**Physics meaning**  
For static holographic states, entanglement entropy of a boundary region equals bulk minimal-surface area divided by \(4G_N\).

**Repo meaning**  
Connectivity becomes membrane geometry.

**Code meaning**  
A bridge-phase engine driven by relation weights and minimal/tension logic.

---

## screen

**Physics meaning**  
A surface obtained by projecting along a null hypersurface in the noncontracting direction and stopping before expansion turns negative.

**Repo meaning**  
A place where the universe “chooses to display itself.”

**Code meaning**  
A projection membrane, display surface, or layered screen stack element.

---

## screen-hypersurface

**Physics meaning**  
A one-parameter family of screens.

**Repo meaning**  
A moving or layered display geometry across spacetime.

**Code meaning**  
An animated stack of screens or membrane sequence.

---

## smearing function / smearing kernel

**Physics meaning**  
A kernel expressing a bulk operator as a distributed integral over boundary operators in favorable settings.

**Repo meaning**  
The main local reconstruction engine.

**Code meaning**  
A weighted sum over boundary samples across space and time.

Bousso’s screen language, RT’s geometry, and Rosenhaus’s reconstruction program all reinforce the repo split between local kernels, preferred surfaces, and nonlocal rescue channels when local readout fails. :contentReference[oaicite:14]{index=14} :contentReference[oaicite:15]{index=15}

---

## source field

**Physics meaning**  
The leading boundary datum acting as a source for a dual operator.

**Repo meaning**  
What you intentionally write on the shell or screen.

**Code meaning**  
A boundary texture, glyph map, operator channel, or explicit control texture.

---

## stretched horizon

**Physics meaning**  
A timelike surface just outside the true event horizon, used as the operational membrane in complementarity-style descriptions.

**Repo meaning**  
The visible horizon skin.

**Code meaning**  
A shell offset from the mathematical horizon where scrambling and glow are rendered.

The cosmology review explicitly describes the stretched horizon as a timelike surface just outside the mathematical lightlike horizon and discusses mapping horizon data onto screens via light-sheets. :contentReference[oaicite:16]{index=16}

---

## theta-zero surface

**Physics meaning**  
A surface where the null expansion vanishes.

**Repo meaning**  
Usually a preferred screen candidate.

**Code meaning**  
A highlight mask for stable membranes or balanced encoding zones.

---

## trapped null geodesic

**Physics meaning**  
A null geodesic that does not escape cleanly to the boundary.

**Repo meaning**  
A warning sign that local reconstruction may fail.

**Code meaning**  
A geometry flag that lowers reconstruction confidence and increases nonlocal/coarse-grained behavior.

---

## UV/IR relation

**Physics meaning**  
The correspondence between ultraviolet structure in the boundary theory and infrared/near-boundary cutoff structure in the bulk.

**Repo meaning**  
Outer depth is high detail; deeper bulk is lower-resolution collective structure.

**Code meaning**  
Depth-based frequency scaling and boundary cutoff logic.

---

## volume illusion

**Physics meaning**  
Not a standard term.

**Repo meaning**  
The sense that a large interior is being reconstructed from a lower-dimensional source.

**Code meaning**  
Hollow interiors, beam-built bodies, or shell-extruded field volumes.

---

## von Neumann entropy

**Physics meaning**  
The entropy \(S = -\mathrm{tr}(\rho \log \rho)\) of a quantum state.

**Repo meaning**  
The baseline notion of entropy beneath entanglement discussions.

**Code meaning**  
Usually an abstract metric rather than a directly rendered field.

---

## wedge

**Physics meaning**  
A region selected by causal or entanglement structure, such as a causal wedge or entanglement wedge.

**Repo meaning**  
A bulk ownership zone.

**Code meaning**  
A region mask, cone, or volume field tied to a boundary patch.

---

## z cutoff / rho cutoff

**Physics meaning**  
A bulk cutoff surface near the AdS boundary used to regulate divergences.

**Repo meaning**  
The place where source-rich shell behavior is sampled and renormalized.

**Code meaning**  
`boundaryDepth`, `cutoffRho`, or `zMin`.
