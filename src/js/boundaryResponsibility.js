export class BoundaryResponsibility {
  constructor(params = {}) {
    this.spatialRadius = params.spatialRadius ?? 0.18;
    this.timeWindow = params.timeWindow ?? 0.44;
    this.depthFalloff = params.depthFalloff ?? 1.2;
  }

  weight(p, t, sample) {
    const dx = Math.hypot(p.x - sample.x, p.z - sample.z);
    const dt = Math.abs(t - sample.t);
    const dy = Math.max(p.y, 0.0);
    return (
      Math.exp(-dx / this.spatialRadius) *
      Math.exp(-dt / this.timeWindow) *
      Math.exp(-dy * this.depthFalloff)
    );
  }

  computeResponsibilityRegion(bulkPoint, t, samples) {
    let totalW = 0;
    let cx = 0, cz = 0;
    for (const s of samples) {
      const w = this.weight(bulkPoint, t, s);
      totalW += w;
      cx += w * s.u;
      cz += w * s.v;
    }
    if (totalW < 1e-8) return null;
    return {
      bulkPoint,
      responsibilityRegion: {
        centerUV: [cx / totalW, cz / totalW],
        spatialRadius: this.spatialRadius,
        timeWindow: this.timeWindow,
        confidence: Math.min(totalW, 1.0)
      }
    };
  }
}

export function boundarySmear(p, t, samples, sourceMap, params) {
  let acc = 0.0;
  let norm = 0.0;
  const resp = new BoundaryResponsibility(params);
  for (const s of samples) {
    const w = resp.weight(p, t, s);
    acc += w * sourceMap(s.u, s.v, s.t);
    norm += w;
  }
  return norm > 0.0 ? acc / norm : 0.0;
}
