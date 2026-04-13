# 06 — Black Holes and Horizons

## 6.1 Core idea

Black holes are where holography stops being a metaphor and becomes a hard limit.

The key fact is the Bekenstein–Hawking area law:

S_BH = A_hor / (4 G_N)

Entropy is proportional to the area of the horizon, not the volume hidden behind it.
That is the original shockwave behind holography:
the horizon acts like an information membrane.

For shader art, this gives the master rule:

horizon area = information budget

not:
interior volume = information budget

## 6.2 Why black holes matter for the repo

Black holes are not just one scene type.
They are the prototype for:
- surface-dominant encoding
- trapped visibility
- thermalized local information
- boundary readout limits
- horizon membranes
- reconstruction failure in hidden regions

This is where the repo learns how to make information disappear locally while remaining globally constrained.

## 6.3 Bekenstein–Hawking entropy

The basic formula is

S_BH = A_hor / (4 G_N)

The source material emphasizes that Bekenstein proposed black holes carry entropy to preserve the generalized second law, and Hawking’s discovery of black-hole radiation made them genuine thermodynamic systems with both temperature and entropy. :contentReference[oaicite:0]{index=0} :contentReference[oaicite:1]{index=1} :contentReference[oaicite:2]{index=2}

Repo translation:
- the horizon is an information-dense shell
- increasing horizon area increases allowed complexity
- the interior may be visually large, but the controlling data budget lives on the horizon

## 6.4 Generalized second law

A useful conceptual law is:

S_total = S_matter + S_BH

and this total should not decrease.

That is the conceptual machine behind the original entropy argument:
if an object with too much entropy could fit inside a region without violating area scaling, one could collapse it into a black hole and make entropy decrease, which is forbidden. This is part of the argument that the maximum entropy in a gravitating region is set by the entropy of the largest black hole that fits. :contentReference[oaicite:3]{index=3} :contentReference[oaicite:4]{index=4} :contentReference[oaicite:5]{index=5}

Visual translation:
- if a region gets “too information dense,” it should undergo horizon formation
- compression should produce a shell event, not infinitely increasing interior detail
- collapse scenes should increase shell dominance

## 6.5 Schwarzschild baseline

A standard Schwarzschild metric is

ds^2 = (1 - 2MG/r) dt^2 - (1 - 2MG/r)^(-1) dr^2 - r^2 dOmega^2

with horizon at

r_s = 2 M G

This is the cleanest baseline for black-hole scene logic: a spherical causal membrane dividing readable exterior from hidden interior. :contentReference[oaicite:6]{index=6}

## 6.6 Horizon as membrane

The horizon should not be rendered as a mere outline.
In holographic and membrane-paradigm language, it behaves like an information-bearing surface with thermodynamic properties. The complementarity literature explicitly ties this to the stretched horizon. :contentReference[oaicite:7]{index=7}

Repo rule:
- horizon = active shell
- shell stores heat, noise, glyphs, scrambling patterns, and readout artifacts
- the horizon is where infalling structure becomes thermally encoded from the outside point of view

## 6.7 Stretched horizon

The stretched horizon is an effective membrane placed just outside the true event horizon.
It is not the exact geometric horizon; it is the operational surface where an outside observer can attribute dynamics, temperature, and information processing.

This is one of the best visual devices in the whole repo:
- the true horizon is the ideal causal boundary
- the stretched horizon is the visible glowing skin your renderer actually works with

The source material explicitly references “the stretched horizon and black hole complementarity,” and Susskind’s earlier discussion describes the local state near the stretched horizon as thermal and largely insensitive to details of the infalling matter. :contentReference[oaicite:8]{index=8} :contentReference[oaicite:9]{index=9}

## 6.8 Black hole complementarity

The black-hole information puzzle led to black-hole complementarity:
preserve quantum unitarity, but give up naive assumptions about a single observer-independent local story for all events across the horizon.

For the repo, complementarity means:
- outside view: information appears processed, scrambled, and thermalized on or near the horizon
- infalling view: crossing may appear smooth or at least differently organized
- do not try to show both viewpoints as one naive Euclidean object

The TASI lectures directly frame black-hole complementarity as a counterproposal to information loss that preserves quantum mechanics while questioning naive locality and observer-independent spacetime events. :contentReference[oaicite:10]{index=10} :contentReference[oaicite:11]{index=11}

## 6.9 Thermalization and local forgetting

Susskind’s horizon discussion says the local state near the stretched horizon is thermal and has lost almost all detailed information about specific infalling matter, even if the full system is not fundamentally information-destroying. :contentReference[oaicite:12]{index=12}

That is huge for visuals.

It means:
- the horizon should locally erase detail
- fine object identity should smear into thermal texture
- global correlations may remain, but local appearance should look universal

## 6.10 Hawking radiation and horizon glow

Hawking radiation means black holes are thermodynamic emitters, not perfectly black sinks. The uploaded sources describe Hawking’s discovery as turning the thermodynamic analogy into physical reality. :contentReference[oaicite:13]{index=13} :contentReference[oaicite:14]{index=14}

Repo translation:
- the horizon should emit faint structured radiation
- not necessarily literal photons; any sparse flicker, thermal grain, or escaping spectral mist works
- black-hole scenes should breathe outward as well as absorb inward

## 6.11 AdS black holes and deconfinement

In holographic AdS/CFT settings, a high-temperature deconfined phase corresponds to a bulk black hole, while the low-temperature confined phase corresponds to horizonless AdS. The entanglement notes explicitly describe the Hawking–Page transition between global AdS and AdS-Schwarzschild black holes, with the order-\(N^2\) entropy in the deconfined phase accounted for by Bekenstein–Hawking entropy. :contentReference[oaicite:15]{index=15}

That gives the repo a gorgeous phase logic:
- cool phase: cathedral-like empty AdS
- hot phase: bulk horizon appears
- temperature can literally decide whether your scene contains a black hole

## 6.12 Horizon as minimal surface link

The entanglement notes motivate RT by pointing out that a static black-hole horizon is itself a minimal surface, and its area gives the thermal entropy. :contentReference[oaicite:16]{index=16} :contentReference[oaicite:17]{index=17}

Repo translation:
- horizons and entanglement membranes are cousins
- your horizon renderer and your RT-surface renderer should share code patterns
- a horizon can be treated as a special entropy membrane that encloses unreadable bulk

## 6.13 Reconstruction failure behind horizons

From the earlier bulk-reconstruction material:
- trapped null geodesics
- black-hole barriers
- evanescent modes

all degrade simple local boundary reconstruction.

So in black-hole scenes:
- the outside can only access coarse or thermalized information
- local interior readout should become unreliable near or behind the horizon
- hidden zones should feel causally screened, not merely darkened

This ties cleanly to the earlier warning that pure AdS smearing logic does not survive unchanged in black-hole backgrounds. :contentReference[oaicite:18]{index=18} :contentReference[oaicite:19]{index=19} :contentReference[oaicite:20]{index=20}

## 6.14 Visual laws to extract

### Law A — Area controls hidden complexity
Use horizon area to set detail budget.

### Law B — Horizon is an active shell
It glows, scrambles, absorbs, emits, and thermalizes.

### Law C — Exterior view loses local detail
Infalling forms should melt into universal shell texture.

### Law D — Interior readability collapses
Behind the horizon, local reconstruction confidence drops sharply.

### Law E — Emission is sparse but real
A black hole should leak structured thermal light, mist, or quanta.

### Law F — Phase changes matter
Black hole appearance can switch on as a temperature/deconfinement transition.

## 6.15 API vocabulary

- horizonRadius
- horizonAreaBudget
- stretchedHorizonWidth
- complementarityMix
- thermalScramble
- hawkingGlow
- absorptionStrength
- redshiftStrength
- interiorReadoutLoss
- deconfinementThreshold
- trappedModeWeight
- shellTemperature
- photonRingGain
- singularitySuppression

## 6.16 Failure modes to avoid

- black hole = matte black sphere
- no distinction between true horizon and stretched horizon
- interior treated as clearly visible ordinary volume
- infalling object passing through horizon with no scrambling or shell event
- no faint emission or thermal structure
- ignoring horizon-area control of complexity
