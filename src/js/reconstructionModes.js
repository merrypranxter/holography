export const reconstructionModes = {
  LOCAL_SMEAR: "local_smear",
  PRECURSOR_ASSISTED: "precursor_assisted",
  COARSE_GRAINED: "coarse_grained",
  FAILED_LOCAL_READOUT: "failed_local_readout"
};

export function chooseReconstructionMode(flags) {
  if (flags.hasTrappedGeodesics || flags.hasStrongEvanescence) {
    return reconstructionModes.COARSE_GRAINED;
  }
  if (flags.requiresEarlyKnowledge) {
    return reconstructionModes.PRECURSOR_ASSISTED;
  }
  return reconstructionModes.LOCAL_SMEAR;
}

export function selectReconstructionMode(flags) {
  if (flags.hasTrappedGeodesics || flags.hasStrongEvanescence) {
    return "coarse_grained";
  }
  if (flags.requiresEarlyKnowledge) {
    return "precursor_assisted";
  }
  return "local_smear";
}
