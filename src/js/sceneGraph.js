export class SceneGraph {
  constructor() {
    this.nodes = new Map();
    this.edges = [];
  }

  addNode(id, data) {
    this.nodes.set(id, { id, ...data });
    return this;
  }

  removeNode(id) {
    this.nodes.delete(id);
    this.edges = this.edges.filter(e => e.from !== id && e.to !== id);
    return this;
  }

  addEdge(from, to, weight = 1.0) {
    this.edges.push({ from, to, weight });
    return this;
  }

  getNeighbors(id) {
    return this.edges.filter(e => e.from === id || e.to === id);
  }
}

export const sceneContract = {
  topology: [],
  fields: [],
  reconstruction: "local_smear",
  renormalization: true,
  cameraModes: ["observer"],
  debugViews: []
};

export const defaultSceneState = {
  mode: "ads_rt_blackhole_hybrid",
  cameraMode: "null_follow",
  reconstructionMode: "precursor_assisted",
  params: {
    boundaryDepth: 0.03,
    warpIntensity: 1.2,
    smearSupportRadius: 0.18,
    precursorWeight: 0.35,
    horizonRadius: 0.9,
    stretchedHorizonWidth: 0.06,
    entanglementWeight: 0.72,
    bridgeThreshold: 0.42,
    cutoffRho: 0.025,
    anomalyMix: 0.15
  },
  debug: {
    showBoundarySupport: false,
    showRTSurface: false,
    showScreens: false,
    showCounterterm: false,
    showRecoverableDepth: false
  }
};
