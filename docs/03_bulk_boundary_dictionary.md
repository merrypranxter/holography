# 03 — Bulk / Boundary Dictionary

## 3.1 Core idea

In holography, the bulk is not independently authored.
Bulk fields are encoded by boundary data.

At the simplest level, a bulk field near the boundary determines a boundary operator.
More ambitiously, a bulk operator at finite depth can sometimes be reconstructed by smearing boundary operators over a region of space and time.

For shader art, this becomes the core computational law:

boundary signal -> reconstruction kernel -> bulk event

Do not think "texture wrapping."
Think:
- source inscription
- nonlocal projection
- interior emergence
- delayed or smeared causation
- partial reconstruction when visibility is obstructed

## 3.2 The extrapolate dictionary

A canonical leading statement is:

lim_{z -> 0} z^{-Delta} Phi(x,t,z) = O(x,t)

This says:
- Phi is a bulk field
- O is the dual local boundary operator
- Delta is the scaling dimension

So the near-boundary tail of the bulk field is what the boundary theory reads as the operator.

In repo language:
- the boundary is not just where the object ends
- it is where the bulk field exposes its readable code

## 3.3 Smearing: finite-depth bulk from boundary data

In favorable cases, the bulk operator can be reconstructed as:

Phi(B) = ∫ db' K(B|b') O(b') + ...

where:
- B is the bulk point
- b' are boundary points
- K is the smearing kernel
- the ellipsis means interactions / nonlinear corrections

This is the useful programmable version of holography.

The kernel K tells you:
- which boundary region contributes to a bulk point
- how strongly
- with what temporal lag / spatial spread
- whether the reconstruction is local-ish or violently nonlocal

## 3.4 Source versus response

Holographic renormalization makes the boundary/bulk relation more precise.

Near the boundary, bulk fields admit asymptotic expansions of the form:

F(x, rho) = rho^m [ f_(0)(x) + f_(2)(x) rho + ... + rho^n ( f_(2n)(x) + log(rho) f~_(2n)(x) ) + ... ]

The leading coefficient f_(0) is interpreted as the source for the dual boundary operator.
Subleading coefficients are fixed recursively by the bulk equations up to a certain order, while a deeper coefficient remains state-dependent.

In repo language:
- source = what you write on the boundary
- response = what the bulk gives back
- not every interior feature is directly painted; some are dynamically induced

## 3.5 Partition function view

The source/operator relation can be stated as:

Z_bulk[phi_(0)] = < exp( - ∫ boundary phi_(0) O ) >_QFT

This means the boundary values of bulk fields act as sources coupled to operators in the boundary theory.

Visual translation:
- boundary maps are not passive textures
- they are control voltages
- they inject deformations into the whole interior logic

## 3.6 Local operators are sometimes enough — and sometimes not

In global AdS, local boundary operators can be sufficient to reconstruct the bulk field in the classical limit.
But this fails in more complicated settings.

Important failures:
- certain subregions
- AdS-Rindler wedges
- black-hole backgrounds
- configurations with trapped null geodesics
- geometries supporting evanescent modes

In those cases, local boundary data is not enough for stable reconstruction.
The missing information lives in more nonlocal boundary structures.

This is where "precursors" enter:
highly nonlocal boundary operators that encode deep-bulk events before ordinary local boundary observables can register them.

## 3.7 Null geodesics as visibility law

A strong geometric rule from the literature:

continuous local reconstruction is expected only when null geodesics from the relevant bulk region reach the corresponding boundary region.

Translation for art/code:
- if a bulk event has light-like access to the boundary, it can be rendered as boundary-readable
- if it is trapped, shadowed, or geometrically screened, the reconstruction should become unstable, blurred, delayed, or impossible

## 3.8 Smearing function support

The smearing kernel is not just a blur.
It has support over regions of the boundary that are "responsible" for the bulk point.

This support may be:
- broad in space and time
- spacelike
- subregion-limited
- nonlocal in shape
- state-dependent in pathological backgrounds

Therefore:
a deep bulk event should often be controlled by a distributed boundary pattern, not one pixel or one UV point.

## 3.9 Precursors

A precursor is a nonlocal boundary operator that already encodes a deep-bulk event before local boundary operators can detect it causally.

In art-engine terms:
- precursors are hidden global control channels
- they should be able to affect bulk structure "too early"
- they are ideal for delayed revelation visuals, ghost geometry, and bulk events appearing before their surface evidence

## 3.10 Black holes, barriers, and failure of simple smearing

Pure AdS allows clean smearing reconstruction.
AdS black holes generally do not.

Why:
- horizons / barriers allow modes with exponentially small near-boundary imprint
- trapped null geodesics obstruct state-independent smearing kernels
- evanescent modes require exponential precision for local reconstruction

So the repo must not assume every holographic scene supports a nice clean boundary-to-bulk kernel.
Sometimes you only get:
- coarse-grained reconstruction
- approximate reconstruction
- nonlocal precursor channels
- missing or shadowed interior zones

## 3.11 Euclidean propagator is not the same thing

Do not confuse:
- bulk-to-boundary propagator for nonnormalizable/source modes
with
- Lorentzian smearing function for reconstructing normalizable/state modes

These are related but not identical objects.
The repo should keep them separate.

## 3.12 Shader commandments

### Commandment A — Boundary drives interior through kernels
No free interior detail without some boundary channel.

### Commandment B — Reconstruction is often distributed
One bulk point can depend on many boundary points over time.

### Commandment C — Obstruction matters
Black holes, wedges, barriers, and hidden regions should degrade local reconstruction.

### Commandment D — Add a nonlocal channel
To mimic precursors, every scene system should have at least one global/nonlocal control path.

### Commandment E — Distinguish source from response
Some boundary maps are explicit controls; other interior structures are derived reactions.

## 3.13 Minimal API vocabulary

- sourceMap
- operatorDensity
- smearRadius
- smearTimeWindow
- nonlocalMix
- precursorWeight
- visibilityMask
- trappedModeWeight
- responseGain
- boundaryResponsibility
- causalLag
- reconstructionConfidence

## 3.14 Failure modes to avoid

- one-to-one UV mapping from shell to interior point
- assuming all bulk structure is locally reconstructible
- treating black-hole scenes as if pure AdS smearing still works
- confusing source injection with state response
- making nonlocality purely decorative instead of structural
