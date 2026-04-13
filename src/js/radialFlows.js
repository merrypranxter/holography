export const defaultAdsParams = {
  adsRadius: 1.0,
  boundaryDepth: 0.03,
  deepBulkDepth: 2.5,
  warpIntensity: 1.0,
  radialFrequencyBias: 0.85,
  boundaryGlow: 1.4,
  bulkSoftness: 0.6,
  uvIrMix: 0.75,
  cutoffFeather: 0.2,
  renormFade: 0.4
};

export function adsDepthZ(p, epsilon = 0.02) {
  return Math.max(epsilon, p.y + 1.2);
}

export function warpScale(z, L = 1.0) {
  return L / Math.max(z, 1e-4);
}

export function depthBand(z, a, b) {
  const t = Math.max(0, Math.min(1, (z - a) / Math.max(b - a, 1e-6)));
  return t * t * (3 - 2 * t);
}

export function layeredFreq(z) {
  return 18.0 + (2.5 - 18.0) * depthBand(z, 0.05, 2.0);
}

export function stepScaleFromDepth(z, L = 1.0) {
  return Math.max(0.01, Math.min(0.3, 0.15 * z / L));
}

export function adsWarpPoint(p, L = 1.0, warpIntensity = 1.0) {
  const z = adsDepthZ(p);
  const s = 1.0 + (L / z - 1.0) * warpIntensity;
  return { x: p.x * s, y: p.y, z: p.z * s };
}
