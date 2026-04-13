export function getRTSurfaceUniforms(time, resolution) {
  return {
    uTime: time,
    uResolution: resolution,

    uCamPos: [0.0, 0.15, -4.4],
    uCamBasis: [
      1, 0, 0,
      0, 1, 0,
      0, 0, 1
    ],

    uAnchorA: [-1.25, 0.0, 0.0],
    uAnchorB: [ 1.25, 0.0, 0.0],
    uAnchorRadius: 0.34,

    uEntanglementWeight: 0.78,
    uBridgeThreshold: 0.44,
    uRTTension: 0.72,
    uSharedInteriorWeight: 0.72,
    uDisconnectSharpness: 0.16,
    uMembraneGlow: 1.3,
    uThreadGain: 0.9,
    uCutSeverity: 0.18,

    uBoundaryDepth: 0.03,
    uWarpIntensity: 0.12,
    uScreenBloom: 0.9,

    uDebugMode: 0
  };
}
