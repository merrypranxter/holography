// scene_light_sheet_screen.glsl
//
// Null-projection / screen scene template:
// - seed ring / surface
// - converging beam fans
// - pseudo-expansion field theta
// - preferred-screen membranes where theta ~ 0
// - caustic termination shells
//
// Stylized screen-hypersurface logic, not a GR geodesic solver.

#ifndef PI
#define PI 3.14159265359
#endif

// -----------------------------------------------------------------------------
// Uniforms
// -----------------------------------------------------------------------------

uniform float uTime;
uniform vec2  uResolution;

uniform vec3  uCamPos;
uniform mat3  uCamBasis;

// Seed surface
uniform vec3  uSeedCenter;
uniform float uSeedRadius;
uniform float uSeedThickness;

// Null / beam controls
uniform float uBeamFocus;
uniform float uBeamFalloff;
uniform float uNullDirectionality;
uniform float uAperture;
uniform float uCausticGain;

// Screen controls
uniform float uScreenThreshold;
uniform float uPreferredScreenBias;
uniform float uScreenLayerSpacing;
uniform float uScreenLayerCount;
uniform float uScreenOpacity;
uniform float uScreenWarp;

// Mild AdS-ish flavor
uniform float uBoundaryDepth;
uniform float uWarpIntensity;

// Debug
uniform int uDebugMode;
// 0 beauty
// 1 seed
// 2 null density
// 3 theta field
// 4 preferred screen
// 5 caustic
// 6 layer mask

// -----------------------------------------------------------------------------
// Helpers
// -----------------------------------------------------------------------------

float saturate(float x) { return clamp(x, 0.0, 1.0); }

float hash21(vec2 p) {
    p = fract(p * vec2(123.34, 456.21));
    p += dot(p, p + 45.32);
    return fract(p.x * p.y);
}

float noise3(vec3 p) {
    vec3 i = floor(p);
    vec3 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);

    float n000 = hash21(i.xy + i.z);
    float n100 = hash21((i.xy + vec2(1.0, 0.0)) + i.z);
    float n010 = hash21((i.xy + vec2(0.0, 1.0)) + i.z);
    float n110 = hash21((i.xy + vec2(1.0, 1.0)) + i.z);

    float n001 = hash21(i.xy + (i.z + 1.0));
    float n101 = hash21((i.xy + vec2(1.0, 0.0)) + (i.z + 1.0));
    float n011 = hash21((i.xy + vec2(0.0, 1.0)) + (i.z + 1.0));
    float n111 = hash21((i.xy + vec2(1.0, 1.0)) + (i.z + 1.0));

    float nx00 = mix(n000, n100, f.x);
    float nx10 = mix(n010, n110, f.x);
    float nx01 = mix(n001, n101, f.x);
    float nx11 = mix(n011, n111, f.x);

    float nxy0 = mix(nx00, nx10, f.y);
    float nxy1 = mix(nx01, nx11, f.y);

    return mix(nxy0, nxy1, f.z);
}

float fbm(vec3 p) {
    float a = 0.5;
    float s = 0.0;
    for (int i = 0; i < 4; i++) {
        s += a * noise3(p);
        p *= 2.03;
        a *= 0.5;
    }
    return s;
}

float sdTorusY(vec3 p, vec2 t) {
    vec2 q = vec2(length(p.xz) - t.x, p.y);
    return length(q) - t.y;
}

// -----------------------------------------------------------------------------
// Mild AdS-ish warp
// -----------------------------------------------------------------------------

float adsDepth(vec3 p) {
    return max(0.03, p.y + 1.3);
}

vec3 adsWarp(vec3 p) {
    float z = adsDepth(p);
    float s = mix(1.0, 1.0 / z, uWarpIntensity);
    return vec3(p.x * s, p.y, p.z * s);
}

// -----------------------------------------------------------------------------
// Seed ring
// -----------------------------------------------------------------------------

float seedField(vec3 p) {
    vec3 q = p - uSeedCenter;
    float d = abs(sdTorusY(q, vec2(uSeedRadius, uSeedThickness)));
    return exp(-d * 55.0);
}

// -----------------------------------------------------------------------------
// Beam families
// -----------------------------------------------------------------------------

vec3 beamDirA(vec3 seedP) {
    return normalize(vec3(0.0, 0.65, 1.0));
}

vec3 beamDirB(vec3 seedP) {
    return normalize(vec3(0.0, 0.35, 1.0));
}

vec3 beamDirC(vec3 seedP) {
    vec3 radial = normalize(vec3(seedP.x, 0.0, seedP.z));
    return normalize(vec3(-0.35 * radial.x, 0.55, 1.0 - 0.35 * radial.z));
}

float coneGate(vec3 dir, vec3 seedToP) {
    float c = dot(normalize(seedToP), normalize(dir));
    return smoothstep(uAperture, uAperture + 0.08, c);
}

float beamLobe(vec3 p, vec3 seedP, vec3 dir, float focus, float falloff) {
    vec3 q = p - seedP;
    float axial = dot(q, dir);
    vec3 perp = q - axial * dir;
    float radial = length(perp);

    float beam = exp(-radial * focus);
    float range = exp(-max(axial, 0.0) * falloff);

    return beam * range * step(0.0, axial);
}

float nullDensity(vec3 p) {
    vec3 local = p - uSeedCenter;
    float ang = atan(local.z, local.x);
    vec3 seedP = uSeedCenter + vec3(cos(ang), 0.0, sin(ang)) * uSeedRadius;

    vec3 dA = beamDirA(seedP);
    vec3 dB = beamDirB(seedP);
    vec3 dC = beamDirC(seedP);

    float gA = coneGate(dA, p - seedP);
    float gB = coneGate(dB, p - seedP);
    float gC = coneGate(dC, p - seedP);

    float bA = beamLobe(p, seedP, dA, uBeamFocus, uBeamFalloff) * gA;
    float bB = beamLobe(p, seedP, dB, uBeamFocus * 0.85, uBeamFalloff * 1.1) * gB;
    float bC = beamLobe(p, seedP, dC, uBeamFocus * 1.1, uBeamFalloff * 0.9) * gC;

    float mixAB = mix(bB, bA, uNullDirectionality);
    return max(mixAB, 0.8 * bC);
}

// -----------------------------------------------------------------------------
// Pseudo expansion scalar theta
// Negative-ish in converging beam core, positive outside.
// Preferred screens where theta ~ 0.
// -----------------------------------------------------------------------------

float thetaField(vec3 p) {
    float d = nullDensity(p);

    vec3 q = p - uSeedCenter;
    float z = q.z;
    float r = length(q.xy);

    float converge = 0.75 - 1.6 * d;
    float radialOpen = 0.28 * r;
    float forwardRelax = 0.08 * z;

    float warp = 0.12 * sin(2.4 * z + 3.0 * fbm(p * 0.8 + vec3(0.0, 0.0, 0.15 * uTime)));

    return converge + radialOpen + forwardRelax + warp;
}

float preferredScreenWeight(vec3 p) {
    float th = thetaField(p);
    return exp(-abs(th) / max(uScreenThreshold, 1e-4)) * uPreferredScreenBias;
}

// -----------------------------------------------------------------------------
// Screen layers
// -----------------------------------------------------------------------------

float screenLayerField(vec3 p, float idx) {
    vec3 q = p - uSeedCenter;

    float z0 = 0.95 + idx * uScreenLayerSpacing;
    float wobble = uScreenWarp * (
        0.12 * sin(2.2 * q.x + 1.1 * uTime + idx) +
        0.10 * sin(2.8 * q.y - 0.7 * uTime + 0.5 * idx)
    );

    float axial = q.z - (z0 + wobble);
    float lateral = length(q.xy);

    float discRadius = uSeedRadius * (1.0 + 0.18 * idx);
    float disc = exp(-abs(axial) * 85.0) * smoothstep(discRadius, discRadius * 0.55, lateral);

    float pref = preferredScreenWeight(p);
    return disc * pref;
}

float screenStackField(vec3 p) {
    float s = 0.0;
    for (int i = 0; i < 8; i++) {
        if (float(i) >= uScreenLayerCount) break;
        s = max(s, screenLayerField(p, float(i)));
    }
    return s;
}

// -----------------------------------------------------------------------------
// Caustic field
// -----------------------------------------------------------------------------

float causticField(vec3 p) {
    vec3 q = p - uSeedCenter;

    float ca = 0.0;
    for (int i = 0; i < 8; i++) {
        if (float(i) >= uScreenLayerCount) break;

        float z0 = 0.95 + float(i) * uScreenLayerSpacing;
        float ringR = uSeedRadius * mix(0.85, 0.42, float(i) / max(uScreenLayerCount, 1.0));
        float band = exp(-abs(q.z - z0) * 22.0) * exp(-abs(length(q.xy) - ringR) * 18.0);

        ca = max(ca, band);
    }

    return ca * uCausticGain;
}

// -----------------------------------------------------------------------------
// Scene SDF
// -----------------------------------------------------------------------------

struct Hit {
    float d;
    int materialId;
};

Hit sceneSDF(vec3 p) {
    p = adsWarp(p);

    Hit h;
    h.d = 1e6;
    h.materialId = 0;

    float seed = abs(sdTorusY(p - uSeedCenter, vec2(uSeedRadius, uSeedThickness)));
    if (seed < h.d) {
        h.d = seed;
        h.materialId = 1;
    }

    float screens = 1e6;
    for (int i = 0; i < 8; i++) {
        if (float(i) >= uScreenLayerCount) break;

        vec3 q = p - uSeedCenter;
        float z0 = 0.95 + float(i) * uScreenLayerSpacing;
        float wobble = uScreenWarp * (
            0.12 * sin(2.2 * q.x + 1.1 * uTime + float(i)) +
            0.10 * sin(2.8 * q.y - 0.7 * uTime + 0.5 * float(i))
        );

        float axial = abs(q.z - (z0 + wobble));
        float lateral = length(q.xy);
        float discRadius = uSeedRadius * (1.0 + 0.18 * float(i));

        float disc = max(axial - 0.01, lateral - discRadius);
        screens = min(screens, disc);
    }

    if (screens < h.d) {
      h.d = screens;
      h.materialId = 2;
    }

    return h;
}

vec3 estimateNormal(vec3 p) {
    const vec2 e = vec2(0.001, 0.0);
    return normalize(vec3(
        sceneSDF(p + e.xyy).d - sceneSDF(p - e.xyy).d,
        sceneSDF(p + e.yxy).d - sceneSDF(p - e.yxy).d,
        sceneSDF(p + e.yyx).d - sceneSDF(p - e.yyx).d
    ));
}

// -----------------------------------------------------------------------------
// Field pack
// -----------------------------------------------------------------------------

struct FieldData {
    float seed;
    float nullD;
    float theta;
    float preferred;
    float screen;
    float caustic;
};

FieldData evalFields(vec3 p) {
    vec3 pw = adsWarp(p);

    FieldData f;
    f.seed = seedField(pw);
    f.nullD = nullDensity(pw);
    f.theta = thetaField(pw);
    f.preferred = preferredScreenWeight(pw);
    f.screen = screenStackField(pw);
    f.caustic = causticField(pw);
    return f;
}

// -----------------------------------------------------------------------------
// Shading
// -----------------------------------------------------------------------------

vec3 beamPalette(float x) {
    vec3 a = vec3(0.08, 0.24, 0.55);
    vec3 b = vec3(0.18, 0.72, 1.25);
    vec3 c = vec3(0.95, 0.75, 0.40);
    return mix(a, b, smoothstep(0.15, 0.75, x)) + 0.08 * c * pow(x, 5.0);
}

vec3 screenPalette(float x) {
    vec3 cold = vec3(0.20, 0.55, 1.10);
    vec3 hot  = vec3(0.82, 0.35, 1.05);
    return mix(cold, hot, smoothstep(0.1, 0.9, x));
}

vec3 accumulateEmission(vec3 p, FieldData f) {
    vec3 col = vec3(0.0);

    col += beamPalette(f.nullD) * (0.11 * f.nullD);
    col += vec3(0.25, 0.85, 1.2) * f.seed * 0.3;

    col += screenPalette(f.screen) * (0.14 * f.screen * uScreenOpacity);
    col += vec3(0.65, 0.95, 1.10) * f.preferred * 0.08;

    col += vec3(0.95, 0.75, 0.45) * f.caustic * 0.12;

    return col;
}

vec3 shadeSurface(vec3 p, vec3 rd, Hit hit, FieldData f) {
    vec3 n = estimateNormal(p);
    vec3 l = normalize(vec3(0.5, 0.75, -0.6));
    float ndl = 0.5 + 0.5 * dot(n, l);
    float rim = pow(1.0 - max(0.0, dot(n, -rd)), 2.6);

    if (hit.materialId == 1) {
        vec3 c = beamPalette(max(f.seed, f.nullD));
        c *= (0.35 + 0.65 * ndl);
        c += vec3(0.3, 0.8, 1.2) * rim * 0.55;
        return c;
    }

    if (hit.materialId == 2) {
        vec3 c = screenPalette(f.screen + 0.3 * f.preferred);
        c *= (0.25 + 0.75 * ndl);
        c += vec3(0.95, 1.0, 1.0) * rim * 0.22;
        c += vec3(0.9, 0.7, 0.4) * f.caustic * 0.2;
        return c;
    }

    return vec3(0.0);
}

// -----------------------------------------------------------------------------
// Raymarch
// -----------------------------------------------------------------------------

float stepRule(vec3 p, float sdfD, FieldData f) {
    float zScale = clamp(0.15 * adsDepth(p), 0.02, 0.23);
    float beamPenalty = mix(1.0, 0.45, f.nullD);
    float screenPenalty = mix(1.0, 0.38, f.screen);
    return max(0.002, sdfD * zScale * beamPenalty * screenPenalty);
}

vec3 background(vec3 rd) {
    float v = 0.5 + 0.5 * rd.y;
    vec3 bg = mix(vec3(0.008, 0.012, 0.028), vec3(0.03, 0.045, 0.08), v);
    float stars = pow(hash21(floor(rd.xy * 180.0)), 56.0);
    return bg + 0.12 * stars;
}

vec3 debugColor(FieldData f) {
    if (uDebugMode == 1) return vec3(f.seed);
    if (uDebugMode == 2) return vec3(f.nullD);
    if (uDebugMode == 3) return vec3(0.5 + 0.5 * tanh(-2.0 * f.theta));
    if (uDebugMode == 4) return vec3(f.preferred);
    if (uDebugMode == 5) return vec3(f.caustic);
    if (uDebugMode == 6) return vec3(f.screen);
    return vec3(0.0);
}

vec3 render(vec3 ro, vec3 rd) {
    float t = 0.0;
    vec3 color = vec3(0.0);

    for (int i = 0; i < 180; i++) {
        vec3 p = ro + rd * t;
        Hit h = sceneSDF(p);
        FieldData f = evalFields(p);

        if (uDebugMode != 0) {
            color += 0.04 * debugColor(f);
        } else {
            color += 0.04 * accumulateEmission(p, f);
        }

        if (h.d < 0.0015) {
            if (uDebugMode == 0) {
                color += shadeSurface(p, rd, h, f);
            }
            break;
        }

        t += stepRule(p, h.d, f);
        if (t > 18.0) {
            color += background(rd);
            break;
        }
    }

    return color;
}

// -----------------------------------------------------------------------------
// Entry
// -----------------------------------------------------------------------------

vec3 getRayDir(vec2 fragCoord) {
    vec2 uv = (2.0 * fragCoord - uResolution) / min(uResolution.x, uResolution.y);
    return normalize(uCamBasis * normalize(vec3(uv, 1.85)));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec3 ro = uCamPos;
    vec3 rd = getRayDir(fragCoord);

    vec3 col = render(ro, rd);

    // light bloom lift
    col += 0.03 * col * col;

    // tonemap / gamma
    col = col / (1.0 + col);
    col = pow(col, vec3(0.4545));

    fragColor = vec4(col, 1.0);
}
