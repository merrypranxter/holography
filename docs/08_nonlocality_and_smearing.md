# 08 — Nonlocality and Smearing

## 8.1 Core idea

A bulk point is not generally controlled by one boundary point.
Even in the nicest cases, a local bulk operator is reconstructed by smearing boundary operators over a region of space and time.

In favorable backgrounds:
bulk point = distributed boundary integral

In hostile backgrounds:
- the smearing kernel may fail to exist
- local boundary data may be insufficient
- deep-bulk events may require nonlocal operators
- exact reconstruction may need exponential precision
- only coarse-grained reconstruction may survive

For the repo, this means:
some interior forms should be driven by local kernels,
some by global hidden modes,
and some only by blurred or approximate readout.

## 8.2 Smearing function as the local reconstruction engine

For a free scalar in the large-N limit, one can expand the bulk field in modes,
identify the asymptotic boundary tail with a local operator O,
and derive

Phi(B) = ∫ db' K(B|b') O(b')

where K is the smearing kernel.

This is the cleanest programmable bulk/boundary map:
- B = bulk point
- b' = boundary points
- K = distributed responsibility profile

## 8.3 What the smearing kernel really means

A smearing kernel is not a blur filter in the graphics sense.
It is a statement that the bulk point can be reconstructed continuously from local boundary data spread over a region.

This region can be:
- large in time
- large in angle/position
- background-dependent
- nonunique in representation

Repo translation:
every reconstructible bulk point should have a "responsibility cloud" on the boundary.

## 8.4 Global AdS is the easy kingdom

In pure global AdS, local boundary operators over sufficient time can reconstruct the bulk.
The source material notes that measuring the local operator over the whole sphere and a long enough time interval lets observers distinguish the mode coefficients and reconstruct the field.

That is your clean local-smear mode:
- stable
- exact in principle
- no hidden global rescue needed

## 8.5 Precursors

If AdS/CFT is complete, there should exist highly nonlocal boundary operators — precursors —
that can determine bulk information at one instant of time even when local one-point data cannot.

The source text is very sharp here:
if two wave packets collide in the center of AdS, causality prevents the result from reaching local boundary readout for a time interval of pi/2.
During that interval, the collision outcome is encoded only in the precursors.

Repo translation:
precursors are hidden global channels that know the bulk too early.

## 8.6 Nonlocal operators and subregions

Rosenhaus emphasizes that the CFT definition of local bulk operators involves nonlocal boundary operators called precursors, and that explicit constructions in global AdS use an entire Cauchy surface of the boundary.

That means:
- local-looking bulk events can require globally spread boundary data
- subregion access is delicate
- restricting the boundary region can force the reconstruction to become ambiguous or impossible

## 8.7 Smearing can fail

The smearing-function approach works in pure global AdS but can fail when there are bulk modes whose boundary imprint is arbitrarily small compared with their interior value.

In those cases:
- a bulk field can be huge at B
- its regulated boundary tail can be exponentially tiny
- the mode sum defining K diverges
- local boundary reconstruction breaks

This is not a small technicality.
It is the moment where the repo must switch from "local smear" to "nonlocal/approximate mode."

## 8.8 Trapped null geodesics

The source gives a powerful geometric diagnostic:
for a large class of static backgrounds, if there are trapped null geodesics, then there is no smearing function for some bulk region.

In pure AdS, null geodesics reach the boundary.
In AdS-Schwarzschild and related backgrounds, some do not.
That is enough to kill the clean smearing map for some points.

Repo law:
if light cannot escape to the boundary, local readout should degrade or fail.

## 8.9 Large-l barriers

The same source explains that in AdS black-hole backgrounds, high angular momentum modes can sit behind a centrifugal barrier.
Their large-r imprint decays exponentially with l, even while they remain legitimate bulk modes.

So:
- small deep barriers can corrupt reconstruction far more than naive distance would suggest
- even a small dense star can obstruct smearing for some region
- the boundary may "see" almost nothing of a real bulk structure

## 8.10 Evanescent modes

Evanescent modes are the real demons here.

In pure AdS, the modes relevant for reconstruction are propagating and exact reconstruction works.
In black-hole or inhomogeneous backgrounds, evanescent modes appear.
These grow exponentially in the interior relative to their boundary imprint.

Then:
- exact reconstruction from boundary data requires exponential precision
- without that precision, you cannot reconstruct sharply
- you may still reconstruct a coarse-grained field

## 8.11 Coarse-graining bound

The source makes the STM analogy explicit:
if evanescent modes are present, reconstruction without exponential precision is possible only after averaging parallel to the boundary over a scale sigma, and then only out to depth z < sigma.

That is one of the most usable coding rules in the whole repo.

Repo translation:
resolution scale on boundary controls recoverable depth in bulk.

## 8.12 STM analogy

The source compares this directly to scanning tunneling microscopy.
You can capture evanescent information only by getting close enough and accepting a finite resolution scale.

For the repo:
- deep bulk hidden detail should require near-screen probes
- a global camera should only recover blurred structure
- near-probe shaders can reveal substructure that distant view cannot

## 8.13 Background dependence

The definition of local bulk operators depends on the background metric.
Rosenhaus explicitly warns that the operator reconstruction story is background-sensitive.

Repo law:
do not assume one universal kernel.
Kernel family should depend on scene geometry:
- pure AdS
- wedge/subregion
- horizon background
- dense star / barrier
- black brane atmosphere

## 8.14 What to do when K fails

When the smearing kernel fails, you still have options:
- approximate smearing with cutoffs
- coarse-grained reconstruction
- nonlocal precursor channels
- complexified-boundary tricks
- state-specific reconstruction instead of universal pointwise recovery

Repo translation:
do not throw the scene away.
Downgrade the readout mode.

## 8.15 Visual laws to extract

### Law A — Bulk responsibility is distributed
One point can depend on a large support set on the boundary.

### Law B — Deep structure may be globally encoded
Use hidden long-range channels, not only local patches.

### Law C — Some scenes should be unrecoverably blurry
That is not failure. That is fidelity.

### Law D — Resolution and depth trade off
Finer bulk readout requires finer or closer boundary measurement.

### Law E — Barriers and horizons kill naive locality
If the geometry traps modes, switch rendering logic.

### Law F — Early bulk knowledge belongs to precursor channels
Let some interior events appear before local boundary evidence catches up.

## 8.16 API vocabulary

- smearKernelType
- smearSupportRadius
- timeSupportWidth
- nonlocalMix
- precursorWeight
- kernelFailureMode
- trappedGeodesicBias
- evanescentWeight
- reconstructionSigma
- recoverableDepth
- boundaryResponsibilityCloud
- coarseGrainMode
- globalHiddenModes
- earlyKnowledgeGain

## 8.17 Failure modes to avoid

- every bulk point controlled by one UV coordinate
- exact crisp readout in black-hole atmospheres
- treating precursors as decorative lore instead of a control path
- no blur/depth tradeoff when evanescent modes are active
- using one universal smearing kernel for all geometries
