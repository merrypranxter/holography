# 02 — AdS Geometry and Scale

## 2.1 Core idea

Anti-de Sitter space (AdS) is the canonical holographic bulk geometry.
Its extra radial direction is not just “another axis” — it encodes scale.
Near the boundary, you are in the ultraviolet: fine detail, short-distance structure, source data.
Deeper into the bulk, you move toward infrared structure: coarse behavior, emergent organization, larger-scale response.

For shader art, this is one of the most useful ideas in the entire repo:

radial depth = scale
boundary proximity = high-frequency control
bulk depth = low-frequency emergence

This is the engine for recursive zoom worlds, cathedral-like tunnels, warped raymarch depth, and scale-aware procedural structure.

## 2.2 Basic AdS metrics

### Global AdS

A standard global form is

ds^2 = (L^2 / cos^2 rho) [ -d tau^2 + d rho^2 + sin^2 rho dOmega^2_(d-1) ]

with
0 <= rho < pi/2

The boundary is at rho -> pi/2.

### Static radial form

Another useful form is

ds^2 = -(1 + r^2 / L^2) d tau^2 + dr^2 / (1 + r^2 / L^2) + r^2 dOmega^2_(d-1)

with boundary at r -> infinity.

### Poincare patch / near-boundary workhorse

The most programmable form is

ds^2 = (L^2 / z^2) [ dz^2 + dx_mu dx^mu ]

or in Euclidean signature

ds^2 = (L^2 / z^2) [ dz^2 + dx^2 ]

Boundary:
z -> 0

Deep bulk:
larger z

This is the version you want for most shader logic.
It is conformally flat, but with a diverging scale factor L^2 / z^2.
So the same coordinate step means something wildly different depending on depth.

## 2.3 The real visual gold: scale as geometry

The rescaling symmetry of the Poincare patch is

(t, x, z) -> (lambda t, lambda x, lambda z)

So scaling x and scaling z go together.
That is the origin of the famous “scale/radius” intuition:
smaller boundary scales are associated with near-boundary structure;
larger scales correlate with deeper bulk organization.

For art, that gives you a powerful rule:

- high-frequency glyphs should live near z ~ 0
- broad smooth fields should dominate at large z
- moving radially should feel like changing observational scale, not just moving through space

## 2.4 Important warning

Do not turn “scale/radius” into a fake absolute law.

The source material makes this subtle:
the rescaling isometry strongly motivates scale/radius,
but it is not generally valid as a full dynamical statement for every bulk process.
It is useful as a design principle and local heuristic, not a universal truth-condition for your renderer.

So in the repo:
- use scale/radius aesthetically and structurally
- do not oversell it as an exact theorem for every scene

## 2.5 UV / IR

A central AdS/CFT lesson:

bulk IR divergences near the boundary correspond to UV divergences in the boundary theory.

That means:
- near the boundary, the bulk metric blows up
- naive quantities diverge there
- near-boundary structure is where source data and renormalization live

For rendering, reinterpret this as:

- near-boundary regions are detail-heavy and unstable
- deep bulk regions are smoother and more collective
- a radial cutoff is not just clipping geometry; it is choosing a resolution regime

So your engine should support:
- boundary cutoff
- radial fade
- scale-aware sampling
- depth-dependent frequency filtering

## 2.6 Fefferman–Graham coordinates

For asymptotically AdS spaces, a standard near-boundary form is

ds^2 = d rho^2 / (4 rho^2) + (1/rho) g_ij(x, rho) dx^i dx^j

with expansion

g(x, rho) = g_(0) + rho g_(2) + ... + rho^(d/2) g_(d) + rho^(d/2) log(rho) h_(d) + ...

Interpretation:
- g_(0): boundary geometry / source data
- subleading terms: bulk response
- deeper coefficients encode expectation values, anomalies, and state data

For code, this is insanely useful:
treat bulk appearance as an expansion from boundary data, not as independent interior paint.

## 2.7 Coding translation

### Rule A — Radial coordinate is a control channel
Every field should be allowed to vary with z or rho.

### Rule B — Frequency should redshift with depth
As z increases, suppress high frequencies and widen structures.

### Rule C — Boundary conditions matter
The look of the deep bulk should inherit from near-boundary source maps.

### Rule D — Cutoffs are meaningful
A z_min or rho_max cutoff is not arbitrary; it chooses what level of detail / source access is allowed.

## 2.8 Shader abstractions

Represent AdS-inspired space as

world_point p
-> warp into ads coordinates
-> evaluate depth z
-> modulate scale/frequency/opacity by z
-> raymarch in warped metric or metric-inspired fake distance

There are two levels of implementation:

### Cheap implementation
Fake AdS with a radial warp field.
Fast, art-friendly, stable.

### Serious implementation
Modify ray step size, normals, and sampling density using the AdS conformal factor.
Better for convincing depth logic.

## 2.9 Practical fake AdS warp

Let y be your “radial” or “holographic depth” coordinate.
Define

z = max(epsilon, depthMap(p))

Then use

warpScale = L / z

to control:
- local frequency
- symbol density
- glow sharpness
- ray step size
- refractive intensity

Near boundary:
z small -> warpScale huge

Deeper bulk:
z larger -> warpScale softer

## 2.10 Visual motifs from AdS

1. Infinite zoom cathedrals
2. Boundary-bright tunnels fading into low-frequency interior fog
3. Nested shells whose apparent spacing changes with radial depth
4. Coordinate grids that stretch hyperbolically near edges
5. Objects whose texture resolution depends on how close they are to the boundary
6. Scale recursion: one motif repeated at larger and larger wavelengths as depth increases

## 2.11 What to avoid

- uniform frequency across all depth
- Euclidean tunnel with no scale logic
- “deep bulk” that is more high-frequency than the boundary unless deliberately inverted
- radial motion that feels like plain translation instead of change of descriptive scale
