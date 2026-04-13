// scene_horizon_hologram.glsl
//
// Purpose:
// A flagship holographic black-hole scene template:
// - true horizon vs stretched horizon
// - shell-local glyphfire / thermal scrambling
// - photon-ring accent
// - infalling identity melt
// - precursor residue in hidden region
//
// Assumes a generic raymarch pipeline with uniforms and helper fns.
// Keep this file modular: include from your main fragment shader.

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

// Core horizon controls
uniform float uHorizonRadius;          // true horizon radius rs
uniform float uStretchedWidth;         // stretched-horizon offset as fraction
uniform float uThermalScramble;        // shell scrambling strength
uniform float uHawkingGlow;            // sparse outgoing emission
uniform float uPhotonRingGain;         // photon-ring accent
uniform float uInteriorReadoutLoss;    // interior readability suppression
uniform float uRedshiftStrength;       // shell spectral compression
uniform float uShellGlyphDensity;      // shell glyph cell frequency
uniform float uPrecursorWeight;        // hidden nonlocal residue
uniform float uBoundaryDepth;          // optional AdS-ish boundary logic mix
uniform float uWarpIntensity;          // optional warp intensity

// Optional infall object controls
uniform vec3  uInfallPos;
uniform float uInfallRadius;
uniform float uInfallEnable;           // 0 or 1

// Optional debug view
uniform int   uDebugMode;
// 0 = beauty
// 1 = true horizon
// 2 = stretched horizon
// 3 = scramble field
// 4 = readout confidence
// 5 = precursor field
// 6 = photon ring

// -----------------------------------------------------------------------------
// Basic helpers
// -----------------------------------------------------------------------------

float saturate(float x) { return clamp(x, 0.0, 1.0); }

float sdSphere(vec3 p, float r) {
    return length(p) - r;
}

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

vec2 sphereUV(vec3 p) {
    vec3 n = normalize(p);
    float u = atan(n.z, n.x) / (2.0 * PI) + 0.5;
    float v = acos(clamp(n.y, -1.0, 1.0)) / PI;
    return vec2(u, v);
}

// -----------------------------------------------------------------------------
// Optional AdS-ish warp for mild holographic depth flavor
// -----------------------------------------------------------------------------

float adsDepth(vec3 p) {
    return max(0.03, p.y + 1.25);
}

vec3 adsWarp(vec3 p) {
    float z = adsDepth(p);
    float s = mix(1.0, 1.0 / z, uWarpIntensity);
    return vec3(p.x * s, p.y, p.z * s);
}

// -----------------------------------------------------------------------------
// Horizon layers
// -----------------------------------------------------------------------------

float trueHorizonField(vec3 p) {
    float d = abs(sdSphere(p, uHorizonRadius));
    return exp(-d * 140.0);
}

float stretchedHorizonField(vec3 p) {
    float rs = uHorizonRadius * (1.0 + uStretchedWidth);
    float d = abs(sdSphere(p, rs));
    return exp(-d * 85.0);
}

float photonRingField(vec3 p) {
    float r = length(p);
    float ringR = 1.5 * uHorizonRadius;
    return exp(-abs(r - ringR) * 22.0) * uPhotonRingGain;
}

float readoutConfidence(vec3 p) {
    float r = length(p);
    float conf = smoothstep(
        uHorizonRadius * 1.15,
        uHorizonRadius * 1.35,
        r
    );
    return mix(conf, conf * conf, uInteriorReadoutLoss);
}

// -----------------------------------------------------------------------------
// Shell glyphfire / thermal scrambling
// -----------------------------------------------------------------------------

float shellGlyphCells(vec3 p) {
    vec2 uv = sphereUV(p);
    vec2 g = uv * vec2(uShellGlyphDensity, uShellGlyphDensity * 0.65);

    vec2 cell = floor(g);
    vec2 f = fract(g) - 0.5;

    float id = hash21(cell);
    float gate = step(0.62, id);

    float lineA = smoothstep(0.12, 0.0, abs(f.x));
    float lineB = smoothstep(0.12, 0.0, abs(f.y));
    float ring  = smoothstep(0.22, 0.18, abs(length(f) - 0.2));

    float glyph = max(max(lineA, lineB * step(0.5, fract(id * 7.0))), ring);
    return gate * glyph;
}

float thermalScrambleField(vec3 p) {
    float sh = stretchedHorizonField(p);
    vec3 q = normalize(p) * 4.0 + vec3(0.0, 0.0, uTime * 0.4);
    float n = fbm(q * 2.1 + vec3(1.3, -0.5, 0.8));
    float cells = shellGlyphCells(p);
    float swirl = 0.5 + 0.5 * sin(18.0 * sphereUV(p).x + 7.0 * sphereUV(p).y + 1.8 * uTime);

    float thermal = mix(n, max(cells, swirl), 0.45);
    return sh * thermal * uThermalScramble;
}

// -----------------------------------------------------------------------------
// Infall object and identity melt
// -----------------------------------------------------------------------------

float infallObjectSDF(vec3 p) {
    return sdSphere(p - uInfallPos, uInfallRadius);
}

float infallIdentityLoss(vec3 p) {
    float rs = uHorizonRadius * (1.0 + uStretchedWidth);
    float d = abs(length(p) - rs);
    float x = 1.0 - clamp(d / max(0.25 * rs, 1e-3), 0.0, 1.0);
    return x * x;
}

// -----------------------------------------------------------------------------
// Precursor residue: hidden, global, low-frequency interior field
// -----------------------------------------------------------------------------

float precursorField(vec3 p) {
    float r = length(p);
    float inside = 1.0 - smoothstep(uHorizonRadius * 0.95, uHorizonRadius * 1.25, r);

    float lowA = 0.5 + 0.5 * sin(1.7 * p.x + 1.1 * p.y - 0.8 * p.z + 0.6 * uTime);
    float lowB = 0.5 + 0.5 * sin(0.9 * r - 0.9 * uTime + 2.0 * atan(p.z, p.x));
    float cloud = fbm(p * 0.9 + vec3(0.0, 0.0, uTime * 0.08));

    return inside * (0.4 * lowA + 0.3 * lowB + 0.3 * cloud) * uPrecursorWeight;
}

// -----------------------------------------------------------------------------
// Redshift-ish spectral shaping
// -----------------------------------------------------------------------------

vec3 applyRedshift(vec3 c, vec3 p) {
    float r = length(p);
    float g = sqrt(max(1e-4, 1.0 - uHorizonRadius / max(r, uHorizonRadius + 1e-4)));
    float mixAmt = (1.0 - g) * uRedshiftStrength;

    vec3 redshifted = vec3(
        c.r + 0.15 * c.g,
        0.72 * c.g,
        0.45 * c.b
    );

    return mix(c, redshifted, clamp(mixAmt, 0.0, 1.0));
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

    float horizonOuter = sdSphere(p, uHorizonRadius * (1.0 + uStretchedWidth));
    if (horizonOuter < h.d) {
        h.d = horizonOuter;
        h.materialId = 1;
    }

    if (uInfallEnable > 0.5) {
        float infall = infallObjectSDF(p);
        if (infall < h.d) {
            h.d = infall;
            h.materialId = 2;
        }
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
// Field evaluation
// -----------------------------------------------------------------------------

struct FieldData {
    float horizonTrue;
    float horizonStretched;
    float photonRing;
    float scramble;
    float precursor;
    float readout;
    float infallLoss;
};

FieldData evalFields(vec3 p) {
    FieldData f;
    f.horizonTrue      = trueHorizonField(p);
    f.horizonStretched = stretchedHorizonField(p);
    f.photonRing       = photonRingField(p);
    f.scramble         = thermalScrambleField(p);
    f.precursor        = precursorField(p);
    f.readout          = readoutConfidence(p);
    f.infallLoss       = (uInfallEnable > 0.5) ? infallIdentityLoss(p) : 0.0;
    return f;
}

// -----------------------------------------------------------------------------
// Emission / shading
// -----------------------------------------------------------------------------

vec3 horizonPalette(float x) {
    vec3 cold = vec3(0.05, 0.16, 0.34);
    vec3 hot  = vec3(0.40, 0.85, 1.35);
    vec3 ash  = vec3(0.95, 0.78, 0.40);
    return mix(cold, hot, smoothstep(0.15, 0.7, x)) + 0.15 * ash * pow(x, 4.0);
}

vec3 accumulateEmission(vec3 p, FieldData f) {
    vec3 col = vec3(0.0);

    // Stretched horizon glyphfire
    vec3 shellCol = horizonPalette(f.scramble);
    shellCol = applyRedshift(shellCol, p);
    col += shellCol * (0.9 * f.horizonStretched + 0.55 * f.scramble);

    // True horizon inner razor line
    col += vec3(0.25, 0.65, 1.2) * f.horizonTrue * 0.4;

    // Photon ring
    col += vec3(0.6, 0.8, 1.1) * f.photonRing * 0.55;

    // Sparse Hawking flecks
    float flick = 0.5 + 0.5 * cos(7.0 * uTime + 20.0 * length(p));
    float sparse = pow(flick, 7.0);
    col += vec3(0.12, 0.22, 0.36) * uHawkingGlow * sparse * f.horizonStretched;

    // Hidden precursor residue inside
    col += vec3(0.18, 0.10, 0.32) * f.precursor * (1.0 - f.readout) * 0.8;

    return col;
}

vec3 shadeSurface(vec3 p, vec3 rd, Hit hit, FieldData f) {
    vec3 n = estimateNormal(p);
    vec3 l = normalize(vec3(0.5, 0.8, -0.7));
    float ndl = 0.5 + 0.5 * dot(n, l);
    float rim = pow(1.0 - max(0.0, dot(n, -rd)), 2.2);

    if (hit.materialId == 1) {
        vec3 base = horizonPalette(f.scramble + 0.2 * rim);
        base = applyRedshift(base, p);

        vec3 surf = base * (0.35 + 0.65 * ndl);
        surf += vec3(0.15, 0.45, 0.95) * rim * 0.6;
        surf += vec3(0.1, 0.2, 0.35) * f.photonRing * 0.4;
        return surf;
    }

    if (hit.materialId == 2) {
        float melt = f.infallLoss;
        vec3 clean = vec3(0.85, 0.78, 0.95) * (0.3 + 0.7 * ndl);
        vec3 melted = mix(
            vec3(0.2, 0.4, 0.9),
            horizonPalette(f.scramble + 0.2),
            0.7
        );
        return mix(clean, melted, melt);
    }

    return vec3(0.0);
}

// -----------------------------------------------------------------------------
// Raymarch
// -----------------------------------------------------------------------------

float stepRule(vec3 p, float sdfD, FieldData f) {
    float base = clamp(0.12 * adsDepth(p), 0.02, 0.25);

    float shellPenalty = mix(1.0, 0.35, saturate(f.horizonStretched + f.scramble));
    float hiddenPenalty = mix(1.0, 0.6, 1.0 - f.readout);

    return max(0.002, sdfD * base * shellPenalty * hiddenPenalty);
}

vec3 background(vec3 rd) {
    float v = 0.5 + 0.5 * rd.y;
    vec3 bg = mix(vec3(0.01, 0.015, 0.03), vec3(0.03, 0.05, 0.08), v);
    float stars = pow(hash21(floor(rd.xy * 140.0)), 48.0);
    return bg + 0.2 * stars;
}

vec3 debugColor(FieldData f) {
    if (uDebugMode == 1) return vec3(f.horizonTrue);
    if (uDebugMode == 2) return vec3(f.horizonStretched);
    if (uDebugMode == 3) return vec3(f.scramble);
    if (uDebugMode == 4) return vec3(f.readout);
    if (uDebugMode == 5) return vec3(f.precursor);
    if (uDebugMode == 6) return vec3(f.photonRing);
    return vec3(0.0);
}

vec3 render(vec3 ro, vec3 rd) {
    float t = 0.0;
    vec3 color = vec3(0.0);

    for (int i = 0; i < 160; i++) {
        vec3 p = ro + rd * t;
        Hit h = sceneSDF(p);
        FieldData f = evalFields(p);

        if (uDebugMode != 0) {
            color += 0.045 * debugColor(f);
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
        if (t > 16.0) {
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
    return normalize(uCamBasis * normalize(vec3(uv, 1.8)));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec3 ro = uCamPos;
    vec3 rd = getRayDir(fragCoord);

    vec3 col = render(ro, rd);

    // Simple filmic-ish tone + gamma
    col = col / (1.0 + col);
    col = pow(col, vec3(0.4545));

    fragColor = vec4(col, 1.0);
}
