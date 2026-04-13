export class BoundaryEncoder {
  constructor(params = {}) {
    this.resolution = params.resolution ?? 512;
    this.glyphDensity = params.glyphDensity ?? 18.0;
    this.operatorDensity = params.operatorDensity ?? 1.0;
  }

  injectSource(uv, value) {
    // Write source value at boundary UV coordinate
    return { uv, value, type: "source" };
  }

  sampleSource(uv) {
    // Override with actual texture sampling in GLSL/canvas
    return 0.0;
  }

  glyphCell(uv) {
    const cell = [Math.floor(uv[0] * this.glyphDensity), Math.floor(uv[1] * this.glyphDensity)];
    const id = (cell[0] * 1973 + cell[1] * 9277) % 1000 / 1000.0;
    return { cell, id };
  }
}

export function makeBulkField({ sourceMap, responseSolver, kernel }) {
  return function bulkField(p, t) {
    let acc = 0.0;
    let norm = 0.0;
    const samples = kernel.getBoundarySamples(p, t);
    for (const s of samples) {
      const w = kernel.weight(p, t, s);
      acc += w * sourceMap(s.u, s.v, s.t);
      norm += w;
    }
    const source = norm > 0.0 ? acc / norm : 0.0;
    const response = responseSolver(p, t, source);
    return { source, response, value: source + response };
  };
}

export function precursorSignal(boundaryState, p, t, params) {
  const globalMode = boundaryState.fourierLowModes ? boundaryState.fourierLowModes(p, t) : 0;
  const graphMode = boundaryState.entanglementGraphInfluence ? boundaryState.entanglementGraphInfluence(p) : 0;
  return params.precursorWeight * (0.5 * globalMode + 0.35 * graphMode);
}
