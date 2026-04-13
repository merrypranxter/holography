export function getLightSheetScreenUniforms(time, resolution) {
  return {
    uTime: time,
    uResolution: resolution,

    uCamPos: [0.0, 0.1, -4.8],
    uCamBasis: [
      1, 0, 0,
      0, 1, 0,
      0, 0, 1
    ],

    uSeedCenter: [0.0, -0.2, -0.8],
    uSeedRadius: 0.85,
    uSeedThickness: 0.06,

    uBeamFocus: 7.5,
    uBeamFalloff: 0.95,
    uNullDirectionality: 0.88,
    uAperture: 0.82,
    uCausticGain: 1.2,

    uScreenThreshold: 0.08,
    uPreferredScreenBias: 1.35,
    uScreenLayerSpacing: 0.42,
    uScreenLayerCount: 5.0,
    uScreenOpacity: 0.24,
    uScreenWarp: 0.35,

    uBoundaryDepth: 0.03,
    uWarpIntensity: 0.1,

    uDebugMode: 0
  };
