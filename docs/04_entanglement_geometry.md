# 04 — Entanglement Geometry

## 4.1 Core idea

In holography, entanglement is not just a hidden quantum statistic.
It is geometrized.

The Ryu–Takayanagi formula says that for a boundary region A in a static holographic state, the entanglement entropy is given by the area of a bulk minimal surface anchored on the boundary of A:

S(A) = Area(gamma_A) / (4 G_N)

where gamma_A is the bulk minimal surface with boundary
partial gamma_A = partial A.

This is one of the deepest usable ideas in the repo:
connectivity becomes geometry.

For shader art, that means:
- stronger relation -> thicker or broader bridge
- lower entanglement -> thinner membrane or disconnected pieces
- cuts in relational structure -> tears in space
- merged entanglement wedges -> shared interior chambers

## 4.2 Minimal surfaces are not decoration

The minimal surface is not just a visual flourish like a soap film.
It is the actual geometric object that computes the entropy in the holographic description.

So in the engine:
- a membrane can measure relation
- a bridge can represent shared information
- a surface can be both visible object and invisible structural constraint

## 4.3 RT formula

For static situations:

S_A = Area(gamma_A) / (4 G_N)

The bulk surface gamma_A:
- is codimension 2
- is anchored on partial A
- is minimal among surfaces homologous to A

Important repo translation:
entanglement is encoded by tension-minimizing geometry.

## 4.4 Mutual information

For two boundary regions A and B, define

I(A:B) = S_A + S_B - S_(A union B)

This measures how much information they share.

In holographic settings this is especially visual:
- if the entanglement wedge for A union B is connected, mutual information can be positive
- if the preferred surfaces disconnect, mutual information can drop to zero

That gives a powerful scene law:
two objects can appear disconnected until a threshold, then suddenly form a shared bridge.

## 4.5 Phase transitions of connectivity

A major visual gift of holographic entanglement is that the preferred minimal-surface configuration can change discontinuously.

For two separated regions:
- one candidate uses two disconnected surfaces
- another candidate uses a connected bridge-like configuration

Whichever has smaller total area wins.

This gives you:
- abrupt bridge formation
- sudden merge / unmerge behavior
- geometric phase transitions
- topology-feeling changes without changing object count

## 4.6 Entanglement wedge intuition

The surface gamma_A encloses a bulk region naturally associated with A.
For art use, call this the entanglement wedge.

Good engine rule:
- the wedge is the interior volume “owned” by the boundary region
- overlapping or touching wedges imply relation
- wedge separation implies informational disconnection

## 4.7 General entropy constraints

Any entanglement engine worth using should obey basic entropy logic.

### Subadditivity
S(AB) <= S(A) + S(B)

### Strong subadditivity
S(AB) + S(BC) >= S(B) + S(ABC)

These are not optional vibes.
They are part of the geometric consistency of RT.

In holographic theories there are even stronger constraints, such as monogamy of mutual information.

## 4.8 Monogamy of mutual information

Holographic states obey a special inequality often written as

I(A:BC) >= I(A:B) + I(A:C)

This means correlation shared with a union can exceed the pairwise pieces in a way that reflects constrained geometric organization.

For art:
- one entity can be deeply linked to a combined structure without being independently linked strongly to each part
- network geometry should not just be arbitrary spaghetti
- relational intensity should have global consistency

## 4.9 Time dependence warning

RT is for static situations.
If the scene is genuinely time-dependent, the correct geometry is more subtle than a simple spatial minimal surface.

Repo rule:
- use RT mode for frozen or quasi-static scenes
- use “covariant membrane” mode for animated causal scenes
- do not pretend a static soap film is always the correct object in dynamical geometry

## 4.10 Visual laws to extract

### Law A — Relation makes bridges
Shared information should literally create connecting membranes, tunnels, filaments, or chambers.

### Law B — Tension minimizes explanation
The connecting surface should look like the least extravagant geometric way to join regions.

### Law C — Disconnects cause tears
When mutual information falls, bridges thin, snap, or evaporate.

### Law D — Geometry can jump
Bridge formation can be sudden, not gradual.

### Law E — Networks obey consistency
Relational graphics should satisfy some monogamy logic, not all-to-all maximal linking.

## 4.11 API vocabulary

- entanglementWeight
- rtTension
- wedgeDepth
- bridgeThreshold
- mutualInfo
- monogamyBias
- disconnectSharpness
- membraneGlow
- cutSeverity
- sharedInteriorWeight
- covariantMode
- relationGraph

## 4.12 Failure modes to avoid

- random webbing with no metric meaning
- bridges that do not respond to relation strength
- every pair connected equally
- no phase transition between disconnected and connected surface regimes
- static membranes used blindly in fast causal scenes
