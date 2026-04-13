export const cosmologyModes = {
  DESITTER_OBSERVER_PATCH: "desitter_observer_patch",
  DESITTER_GLOBAL_SCREENS: "desitter_global_screens",
  FLRW_EMBEDDED_SCREENS: "flrw_embedded_screens",
  HDE_UNIVERSE: "hde_universe",
  INFLATIONARY_HM: "inflationary_hm"
};

export const defaultCosmologyState = {
  mode: cosmologyModes.DESITTER_OBSERVER_PATCH,
  scaleFactor: 1.0,
  hubbleRate: 0.85,
  futureEventHorizon: 3.8,
  cosmologicalHorizon: 4.0,
  screenAreaBudget: 1.0,
  holographicMatterDensity: 0.22,
  darkRadiationMix: 0.14,
  teleologicalMix: 0.7,
  cosmicExpansionGain: 0.55,
  inflationCutoff: 0.22,
  cmbSuppressionBias: 0.5
};

export function holographicMatterDensity(Mp, C, L) {
  return 3.0 * C * C * Mp * Mp / Math.max(L * L, 1e-6);
}

export function futureEventHorizonLength(a, getH) {
  // Numeric estimate: L_f ~ 1/H for de Sitter
  return 1.0 / Math.max(getH(a), 1e-6);
}

export function darkRadiationDensity(Mp, lambda0, a) {
  return Mp * Mp * lambda0 / Math.max(2.0 * Math.pow(a, 4.0), 1e-6);
}

export function holographicW(omegaDe, C) {
  return -1.0 / 3.0 - (2.0 / 3.0) * Math.sqrt(Math.max(omegaDe, 0.0)) / Math.max(C, 1e-6);
}

export function primordialSuppression(k, kCut, softness = 0.2) {
  const x = (k - kCut) / Math.max(softness, 1e-6);
  return 1.0 / (1.0 + Math.exp(-x));
}

export function expandingScreenStack(t, count, baseRadius, growthRate) {
  const screens = [];
  for (let i = 0; i < count; i++) {
    screens.push({
      radius: baseRadius * Math.exp(growthRate * t) * (1.0 + 0.12 * i),
      age: i
    });
  }
  return screens;
}
