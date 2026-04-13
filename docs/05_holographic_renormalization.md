# 05 — Holographic Renormalization

## 5.1 Core idea

AdS has a boundary at infinity, and near that boundary many bulk quantities diverge.
In the dual picture, these bulk IR divergences match boundary UV divergences.

So holographic renormalization is the procedure that:
- expands fields near the boundary
- isolates divergent terms
- adds local covariant counterterms on the cutoff surface
- removes the cutoff
- extracts finite physical data such as 1-point functions, anomalies, and RG behavior

For this repo, that means:

boundary blow-up -> regulated cutoff -> subtract local artifacts -> keep finite source/response structure

## 5.2 The essential moral

Do not treat the near-boundary singularity as a bug.
It is where the source data lives.

The source material is explicit that holographic renormalization is driven by near-boundary analysis, because the divergent structure is determined there, while exact correlation functions still need full bulk solutions. The same source also stresses that divergences should be removed by covariant counterterms rather than by ad hoc dropping of infinite pieces. :contentReference[oaicite:0]{index=0}

## 5.3 Fefferman–Graham form

A standard asymptotically AdS metric near the boundary is

ds^2 = d rho^2 / (4 rho^2) + (1 / rho) g_ij(x, rho) dx^i dx^j

with rho -> 0 at the boundary.

This is the natural coordinate system for the repo’s “boundary expansion” logic. :contentReference[oaicite:1]{index=1}

## 5.4 Generic near-boundary expansion

Near the boundary, a bulk field has an asymptotic expansion of the form

F(x, rho) = rho^m [ f_(0)(x) + f_(2)(x) rho + ... + rho^n ( f_(2n)(x) + log rho f~_(2n)(x) ) + ... ]

Interpretation:
- f_(0): leading boundary datum, usually the source
- recursively determined subleading coefficients: kinematic response pieces
- deeper undetermined coefficient: state-dependent data
- log terms: anomaly fingerprints, especially in even boundary dimension

That is almost the whole repo in one equation: source first, response later, anomaly if logs appear. :contentReference[oaicite:2]{index=2}

## 5.5 Metric coefficients and stress-tensor data

For asymptotically AdS gravity, the near-boundary analysis determines the lower-order coefficients of the metric expansion, while a higher coefficient remains state-dependent.
Skenderis notes that g_(2), ..., g_(d-2), h_(d), and the trace/divergence constraints are fixed near the boundary, while g_(d) is directly related to the 1-point function of the dual stress tensor. :contentReference[oaicite:3]{index=3}

Repo translation:
- some geometry is universal counterterm structure
- some geometry is actual scene state
- do not confuse the two

## 5.6 Partition-function view

The holographic dictionary packages sources as boundary values of bulk fields:

Z_bulk[phi_(0)] = < exp( - ∫ phi_(0) O ) >

So the leading boundary coefficient is not a decorative shell value.
It is a source coupling into the dual operator algebra. :contentReference[oaicite:4]{index=4}

## 5.7 What renormalization actually does

The method, as summarized by Skenderis, is:

1. solve asymptotically near the boundary
2. regulate at a cutoff surface
3. add local covariant counterterms
4. form the renormalized on-shell action
5. compute finite 1-point functions
6. derive Ward identities and anomalies
7. obtain RG equations
8. compute higher-point functions from renormalized 1-point data in the presence of sources

That is a nearly perfect engineering pipeline for the repo. :contentReference[oaicite:5]{index=5} :contentReference[oaicite:6]{index=6}

## 5.8 Why counterterms matter

Early AdS/CFT computations often just dropped divergences by hand.
Holographic renormalization instead uses covariant counterterms so that the whole subtraction scheme is consistent with symmetries and with the various observables derived from the action. :contentReference[oaicite:7]{index=7} :contentReference[oaicite:8]{index=8}

Repo translation:
- do not hide bad boundary behavior with random fades
- subtract it with structured, local visual counterterms

## 5.9 Ward identities and anomalies

A major point in the source text is that near-boundary analysis is enough to determine the holographic Ward identities and anomalies, because these are controlled by the divergence structure and symmetry properties of the UV/near-boundary sector. :contentReference[oaicite:9]{index=9}

Visual translation:
- some depth-dependent distortions are removable artifacts
- some residual patterns are true anomaly signatures and should remain

## 5.10 RG meaning

The same source emphasizes RG transformations as part of the renormalization method and ties holographic renormalization to holographic RG flow. In the repo, radial evolution is therefore not only a geometric motion, but a flow of effective description across scales. :contentReference[oaicite:10]{index=10} :contentReference[oaicite:11]{index=11}

## 5.11 Shader laws to extract

### Law A — Boundary divergence is structured
Near-boundary excess brightness, frequency, or density should come from known asymptotic terms, not arbitrary chaos.

### Law B — Separate divergent shell from finite body
Your renderer should identify what is “cutoff artifact” and what is “physical response.”

### Law C — Counterterms are local
A visual counterterm should depend only on local cutoff-surface data and its derivatives.

### Law D — Logs are special
Logarithmic terms should create anomaly-like residuals: thin interference bands, irreducible color skew, Weyl-fracture glows.

### Law E — State lives deeper than source
Leading coefficients are source code; deeper coefficients carry scene state.

## 5.12 API vocabulary

- cutoffRho
- sourceFieldWeight
- responseFieldWeight
- countertermStrength
- anomalyMix
- renormFade
- shellDivergenceGain
- finitePartGain
- wardRespect
- logTermGlow
- rgFlowRate
- sourceResponseSplit

## 5.13 Failure modes to avoid

- clipping the boundary with no interpretation
- confusing source divergence with physical response
- removing all near-boundary structure and losing the source layer
- using nonlocal “counterterms” for a local subtraction job
- treating anomaly leftovers as bugs instead of signatures
