# 09 — Cosmology and Holographic Matter

## 9.1 Core idea

In cosmology, holography becomes more subtle than in static AdS.
The universe expands, horizons move, and the allowed holographic screens can be:
- spacelike
- null
- timelike
- or a changing family of embedded screens

This means the repo must support:
- time-dependent screen area
- expanding or contracting information budgets
- future-horizon-driven fields
- cosmological light-sheet truncation
- dynamic activation and deactivation of degrees of freedom

## 9.2 FRW / FLRW as the base cosmology

A Friedmann–Robertson–Walker cosmology can be written as

ds^2 = a^2(η) [ -dη^2 + dχ^2 + f^2(χ) dΩ^2 ]

with
f(χ) = sinh χ, χ, sin χ

for open, flat, and closed universes.

This is the base metric for cosmological holography:
geometry is no longer static,
so screen placement and allowed light-sheets depend on the scale factor.

## 9.3 Why light-sheets matter even more in cosmology

The cosmology sources are explicit:
a spatial region can easily contain entropy that exceeds its area if you count all of it.
The bound works only when you count entropy passing through the appropriate light-sheet, which may be truncated by the big bang or other spacetime boundaries.

Repo law:
cosmological holography must be rendered as
time-limited null capture,
not naive volume encoding.

## 9.4 de Sitter space as the cosmic holography laboratory

A flat slicing of de Sitter can be written as

ds^2 = -dt^2 + e^(2Ht)(dr^2 + r^2 dΩ^2)

with
H = sqrt(Λ/3)

de Sitter is crucial because it gives two major screen ideas:

1. Global null projection:
the full spacetime can be projected using past and future infinity as optimal screens.

2. Observer-horizon projection:
for one observer, the event horizon E is a preferred null screen of constant area

A(E) = 4π H^(-2)

that encodes the observable half of de Sitter space.

## 9.5 Cosmological screens are not always boundary screens

Bousso’s construction shows that cosmological spacetimes may have embedded screens, not just asymptotic boundaries.
Some screens are spacelike, some null, some timelike.
Their area may vary with time.

This is one of the most important repo-level upgrades:
your holographic display surface may move through the scene and change size.

## 9.6 Varying active degrees of freedom

Bousso explicitly argues that in general cosmological situations one should not expect a conventional theory with a fixed number of degrees of freedom.
Instead, the effective number of active degrees of freedom can vary with the screen area.

Repo translation:
screen area should directly modulate:
- visible complexity
- symbol count
- sample count
- entanglement channel count
- ray budget
- procedural layer count

Cosmic scenes should breathe their information capacity.

## 9.7 Holographic matter from the UV/IR bound

The cosmological holographic-matter notes derive a classic bound:
if a region of size L has UV cutoff Λ,
one should require the total vacuum energy not to exceed the mass of a black hole of the same size.

This leads to

ρ ~ M_p^2 L^(-2)

and the standard holographic matter / dark-energy form

ρ_HM = 3 C^2 M_p^2 / L^2

with C of order one.

This is the central field law for cosmic holographic rendering:
energy density is set by an IR length scale.

## 9.8 Future event horizon as the IR scale

A key move in holographic dark energy is to choose

L_f = a(t) ∫_t^∞ dt' / a(t')

as the characteristic length scale.

Then the dark-energy density becomes controlled by the future event horizon rather than the instantaneous Hubble radius.

This is visually extraordinary:
the present field depends on a future-defined screen.

Repo translation:
the scene can be shaped by a horizon that is not merely local,
but teleological / anticipatory in structure.

## 9.9 Why the future horizon matters

The notes emphasize that taking the particle horizon or Hubble scale as L does not correctly produce a cosmological-constant-like equation of state.
A de Sitter solution appears naturally when the future horizon is used, with the special choice corresponding to a de Sitter phase.

Repo law:
if you want genuinely dark-energy-like cosmic expansion aesthetics,
future-horizon logic is the preferred mode.

## 9.10 Holographic dark energy dynamics

In a universe with matter plus holographic dark energy:

3 M_p^2 H^2 = ρ_m + ρ_de

and the fractional dark-energy density obeys

dΩ_de / d ln a = Ω_de (1 - Ω_de) ( 1 + 2 sqrt(Ω_de) / C )

while the equation of state is

w = -1/3 - (2/3) sqrt(Ω_de) / C

This gives the repo an evolving cosmic shader parameter:
the relation between expansion, horizon length, and dark-energy dominance changes over time.

## 9.11 Entanglement-entropy route to holographic matter

The notes also derive holographic matter from horizon entanglement entropy.
If

S_ent ~ β N_dof L_h^2 / l^2

and one uses the Gibbons–Hawking temperature

T = 1 / (2π L_h)

then the associated energy density again gives

ρ_de = 3 M_p^2 C^2 / L_h^2

This is incredibly usable for art:
cosmic energy density can be rendered as horizon entanglement pressure.

## 9.12 Entropic-force route

A separate route uses Verlinde-style entropic force ideas:
the future event horizon carries degrees of freedom and temperature,
leading again to an induced holographic matter component of order

ρ_HM ~ 3 C^2 M_p^2 / L_h^2

Repo translation:
cosmic expansion fields can be treated as horizon-pressure or horizon-tension effects,
not just scalar fog.

## 9.13 Action-principle route and dark radiation

The action-principle derivation introduces a cutoff variable L and a Lagrange multiplier λ.
This yields

L = ∫_t^∞ dt' / a(t')

and an energy density

ρ_HM = M_p^2 [ C / (a^2 L^2) + λ / (2 a^4) ]

The λ(a=0) piece evolves like radiation and is naturally interpreted as dark radiation.

This is amazing for the repo:
you get two visual channels:
- future-horizon energy
- primordial dark-radiation residue

## 9.14 Inflation and holographic matter

The cosmology notes say holographic matter can act either as dark energy or in inflationary scenarios, but not both in the same unconstrained way.
If it contributes during early inflation, it modifies the primordial spectrum and can affect low-l CMB structure.

Repo translation:
use holographic matter during inflation to create:
- suppressed large-angle modes
- horizon-scale cutoff bands
- primordial IR scars
- huge early screen pressure

## 9.15 Visual laws to extract

### Law A — Cosmic information budget changes with time
Let complexity track screen area and horizon size.

### Law B — Future horizons can control present form
Allow anticipatory or teleological field logic.

### Law C — Expanding screens should carry the image
Do not freeze the screen in place.

### Law D — Dark energy is a horizon field
Render it as low-frequency, horizon-linked pressure or glow.

### Law E — Primordial residue matters
A dark-radiation-like channel can carry early-universe memory.

### Law F — de Sitter should feel finite to an observer and infinite globally
Use observer horizon and global screens as distinct rendering modes.

## 9.16 API vocabulary

- scaleFactor
- hubbleRate
- cosmologicalHorizon
- futureEventHorizon
- screenAreaBudget
- activeDof
- holographicMatterDensity
- darkRadiationMix
- deSitterObserverMode
- globalInfinityMode
- teleologicalMix
- cosmicExpansionGain
- inflationCutoff
- cmbSuppressionBias

## 9.17 Failure modes to avoid

- fixed information budget in an expanding universe
- treating cosmological holography as static AdS with stars
- using local-only horizon logic when future horizon is the point
- no distinction between observer patch and global de Sitter
- no primordial residue / dark-radiation channel
