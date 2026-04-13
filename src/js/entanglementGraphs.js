export class EntanglementGraph {
  constructor(nodes) {
    this.nodes = nodes;
    this.weights = new Map();
  }

  key(a, b) {
    return a < b ? `${a}:${b}` : `${b}:${a}`;
  }

  setWeight(a, b, w) {
    this.weights.set(this.key(a, b), Math.max(0, w));
  }

  getWeight(a, b) {
    return this.weights.get(this.key(a, b)) ?? 0;
  }
}

export function chooseBridgePhase(w, params) {
  const disconnectedCost = params.baseDisconnectCost - 0.15 * w;
  const connectedCost =
    params.baseConnectCost
    - params.bridgeGain * w
    + params.bridgeLengthPenalty;
  return connectedCost < disconnectedCost ? "connected" : "disconnected";
}

export function mutualInformation(SA, SB, SAB) {
  return Math.max(0, SA + SB - SAB);
}

export function bridgeStrengthFromMI(I, threshold, softness = 0.1) {
  const x = (I - threshold) / Math.max(softness, 1e-4);
  return 1 / (1 + Math.exp(-x));
}

export function applyMonogamyBias(graph, focus, others, strength = 0.35) {
  let total = 0;
  for (const j of others) total += graph.getWeight(focus, j);
  for (const j of others) {
    const w = graph.getWeight(focus, j);
    const suppressed = w / (1 + strength * Math.max(0, total - w));
    graph.setWeight(focus, j, suppressed);
  }
}
