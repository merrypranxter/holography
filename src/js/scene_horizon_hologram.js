export function getHorizonHologramUniforms(time, resolution) {
  return {
    uTime: time,
    uResolution: resolution,

    uCamPos: [0.0, 0.2, -4.2],
    uCamBasis: [
      1, 0, 0,
      0, 1, 0,
      0, 0, 1
    ],

    uHorizonRadius: 0.95,
    uStretchedWidth: 0.065,
    uThermalScramble: 0.95,
    uHawkingGlow: 0.22,
    uPhotonRingGain: 0.55,
    uInteriorReadoutLoss: 0.9,
    uRedshiftStrength: 0.6,
    uShellGlyphDensity: 22.0,
    uPrecursorWeight: 0.28,
    uBoundaryDepth: 0.03,
    uWarpIntensity: 0.15,

    uInfallPos: [1.25 - 0.2 * time, 0.15, 0.0],
    uInfallRadius: 0.26,
    uInfallEnable: 1.0,

    uDebugMode: 0
  };
}
