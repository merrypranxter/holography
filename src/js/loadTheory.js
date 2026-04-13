export async function loadJson(path) {
  const res = await fetch(path);
  if (!res.ok) throw new Error(`Failed to load ${path}: ${res.status}`);
  return res.json();
}

export async function loadTheoryAssets() {
  const [concepts, visualMappings] = await Promise.all([
    loadJson("/theory/concepts.json"),
    loadJson("/theory/visual_mappings.json")
  ]);

  const conceptMap = new Map(concepts.map((c) => [c.id, c]));
  const motifMap = new Map(visualMappings.map((m) => [m.id, m]));

  return { concepts, visualMappings, conceptMap, motifMap };
}

export function buildScenePreset(motifIds, assets) {
  const modules = new Set();
  const params = {};
  const promptTokens = new Set();
  const conceptIds = new Set();

  for (const motifId of motifIds) {
    const motif = assets.motifMap.get(motifId);
    if (!motif) continue;

    motif.shader_modules.forEach((m) => modules.add(m));
    motif.concepts.forEach((c) => conceptIds.add(c));
    Object.assign(params, motif.preset_params);
    motif.prompt_tokens.forEach((t) => promptTokens.add(t));
  }

  return {
    motifs: motifIds,
    concepts: [...conceptIds],
    modules: [...modules],
    params,
    promptTokens: [...promptTokens]
  };
}
