// scene_rt_surface.glsl
//
// Static holographic entanglement scene template:
// - two boundary/source anchors
// - wedge fields
// - connected/disconnected bridge phase
// - RT-style membrane bridge
// - tear logic when relation weakens
//
// Stylized, not a literal extremal-surface solver.

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

// Anchor regions
uniform vec3  uAnchorA;
uniform vec3  uAnchorB;
uniform float uAnchorRadius;

// Entanglement / RT controls
uniform float uEntanglementWeight;   // 0..1-ish
uniform float uBridgeThreshold;      // transition threshold
uniform float uRTTension;            // bridge thinning / saddle tension
uniform float uSharedInteriorWeight; // wedge overlap glow
uniform float uDisconnectSharpness;  // how sharply bridge fails
uniform float uMembraneGlow;         // membrane brightness
uniform float uThreadGain;           // filament brightness
uniform float uCutSeverity;          // tear severity

// Atmosphere
uniform float uBoundaryDepth;
uniform float uWarpIntensity;
uniform float uScreenBloom;

// Debug
uniform int uDebugMode;
// 0 beauty
// 1 wedge A
// 2 wedge B
// 3 overlap
// 4 bridge phase
// 5 tear field
// 6 filament field

// -----------------------------------------------------------------------------
// Helpers
// -----------------------------------------------------------------------------

float saturate(float x) { return clamp(x, 0.0, 1.0); }

float sdSphere(vec3 p, float r) {
    return length(p) - r;
}

float smin(float a, float b, float k) {
    float h = saturate(0.5 + 0.5 * (b - a) / k);
    return mix(b, a, h) - k * h * (1.0 - h);
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
        p *= 2.02;
        a *= 0.5;
    }
    return s;
}

// -----------------------------------------------------------------------------
// Mild AdS-ish warp
// -----------------------------------------------------------------------------

float adsDepth(vec3 p) {
    return max(0.03, p.y + 1.4);
}

vec3 adsWarp(vec3 p) {
    float z = adsDepth(p);
    float s = mix(1.0, 1.0 / z, uWarpIntensity);
    return vec3(p.x * s, p.y, p.z * s);
}

// -----------------------------------------------------------------------------
// Wedge fields
// -----------------------------------------------------------------------------

float wedgeField(vec3 p, vec3 anchor, vec3 inwardDir, float depth, float spread) {
    vec3 q = p - anchor;
    float axial = dot(q, inwardDir);
    float lateral = length(q - axial * inwardDir);

    float core = exp(-abs(axial - 0.55 * depth) * 1.4);
    float fan  = exp(-lateral * spread);

    return fan * core * step(0.0, axial) * step(axial, depth);
}

vec3 inwardDirForAnchor(vec3 a) {
    // inward toward scene center, with slight upward bias
    vec3 dir = normalize(-a + vec3(0.0, 0.35, 0.0));
    return dir;
}

// -----------------------------------------------------------------------------
// Bridge phase
// -----------------------------------------------------------------------------

float bridgeStrength() {
    float x = (uEntanglementWeight - uBridgeThreshold) / max(0.001, uDisconnectSharpness);
    return 1.0 / (1.0 + exp(-x));
}

// -----------------------------------------------------------------------------
// Membrane bridge
// -----------------------------------------------------------------------------

float membraneBridgeSDF(vec3 p, vec3 a, vec3 b, float phase, float tension) {
    vec3 ab = b - a;
    float len = max(length(ab), 1e-4);
    vec3 dir = ab / len;

    vec3 mid = 0.5 * (a + b);
    vec3 rel = p - mid;

    float axial = dot(rel, dir);
    vec3 perp = rel - axial * dir;
    float lateral = length(perp);

    float spanMask = smoothstep(0.65 * len, 0.35 * len, abs(axial));

    // saddle / soap-film-ish thickness
    float baseThickness = mix(0.18, 0.035, tension);
    float pinch = 1.0 - 0.55 * cos(PI * axial / len);
    float thickness = mix(baseThickness, baseThickness * 0.55, phase) * pinch;

    // slight membrane undulation
    float und = 0.015 * sin(8.0 * axial / len + 1.5 * uTime);
    float d = lateral - (thickness + und);

    // gate by phase and span
    d += (1.0 - phase) * 0.5;
    d += (1.0 - spanMask) * 0.15;

    return d;
}

// -----------------------------------------------------------------------------
// Filaments
// -----------------------------------------------------------------------------

float filamentField(vec3 p, vec3 a, vec3 b, float phase) {
    vec3 ab = b - a;
    float len = max(length(ab), 1e-4);
    vec3 dir = normalize(ab);

    vec3 rel = p - a;
    float axial = clamp(dot(rel, dir), 0.0, len);
    vec3 proj = a + dir * axial;

    float d = length(p - proj);

    float strands = 0.5 + 0.5 * sin(18.0 * axial / len + 12.0 * atan(p.z - proj.z, p.y - proj.y));
    float envelope = exp(-d * 18.0);

    return phase * envelope * strands;
}

// -----------------------------------------------------------------------------
// Tear field
// -----------------------------------------------------------------------------

float tearField(vec3 p, vec3 a, vec3 b, float phase) {
    vec3 mid = 0.5 * (a + b);
    vec3 ab = normalize(b - a);
    vec3 rel = p - mid;

    float axial = dot(rel, ab);
    float side = length(rel - axial * ab);

    float n = fbm(p * 2.6 + vec3(0.0, 0.0, uTime * 0.1));
    float instability = (1.0 - phase) * uCutSeverity;

    float seam = exp(-side * 10.0) * smoothstep(0.7, 0.2, abs(axial));
    return seam * smoothstep(0.45 - instability, 0.55 + instability, n);
}

// -----------------------------------------------------------------------------
// Source anchors / shell-ish nodes
// -----------------------------------------------------------------------------

float anchorGlow(vec3 p, vec3 anchor) {
    float d = abs(sdSphere(p - anchor, uAnchorRadius));
    return exp(-d * 35.0);
}

float anchorGlyph(vec3 p, vec3 anchor) {
    vec3 q = normalize(p - anchor);
    float u = atan(q.z, q.x) / (2.0 * PI) + 0.5;
    float v = acos(clamp(q.y, -1.0, 1.0)) / PI;

    vec2 g = vec2(u, v) * vec2(16.0, 10.0);
    vec2 f = fract(g) - 0.5;
    vec2 cell = floor(g);

    float id = hash21(cell);
    float lineA = smoothstep(0.14, 0.0, abs(f.x));
    float lineB = smoothstep(0.14, 0.0, abs(f.y));
    float ring  = smoothstep(0.25, 0.2, abs(length(f) - 0.23));

    float glyph = max(lineA * step(0.4, id), max(lineB * step(0.7, fract(id * 9.0)), ring));
    return anchorGlow(p, anchor) * glyph;
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

    float a = sdSphere(p - uAnchorA, uAnchorRadius);
    float b = sdSphere(p - uAnchorB, uAnchorRadius);

    float anchors = smin(a, b, 0.18);
    if (anchors < h.d) {
        h.d = anchors;
        h.materialId = 1;
    }

    float phase = bridgeStrength();
    float bridge = membraneBridgeSDF(p, uAnchorA, uAnchorB, phase, uRTTension);
    if (bridge < h.d) {
        h.d = bridge;
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
// Field eval
// -----------------------------------------------------------------------------

struct FieldData {
    float wedgeA;
    float wedgeB;
    float overlap;
    float phase;
    float tear;
    float filaments;
    float anchorA;
    float anchorB;
};

FieldData evalFields(vec3 p) {
    vec3 pa = adsWarp(p);

    vec3 dirA = inwardDirForAnchor(uAnchorA);
    vec3 dirB = inwardDirForAnchor(uAnchorB);

    FieldData f;
    f.wedgeA = wedgeField(pa, uAnchorA, dirA, 2.6, 2.4);
    f.wedgeB = wedgeField(pa, uAnchorB, dirB, 2.6, 2.4);
    f.overlap = f.wedgeA * f.wedgeB * uSharedInteriorWeight;
    f.phase = bridgeStrength();
    f.tear = tearField(pa, uAnchorA, uAnchorB, f.phase);
    f.filaments = filamentField(pa, uAnchorA, uAnchorB, f.phase) * uThreadGain;
    f.anchorA = anchorGlyph(pa, uAnchorA);
    f.anchorB = anchorGlyph(pa, uAnchorB);
    return f;
}

// -----------------------------------------------------------------------------
// Shading
// -----------------------------------------------------------------------------

vec3 anchorPalette(float x) {
    vec3 a = vec3(0.16, 0.55, 1.1);
    vec3 b = vec3(0.72, 0.28, 1.25);
    vec3 c = vec3(1.0, 0.82, 0.45);
    return mix(a, b, smoothstep(0.2, 0.75, x)) + 0.12 * c * pow(x, 5.0);
}

vec3 membranePalette(float x) {
    vec3 cold = vec3(0.10, 0.35, 0.9);
    vec3 hot  = vec3(0.85, 0.35, 1.15);
    return mix(cold, hot, smoothstep(0.15, 0.85, x));
}

vec3 accumulateEmission(vec3 p, FieldData f) {
    vec3 col = vec3(0.0);

    col += anchorPalette(f.anchorA) * (0.5 * f.anchorA);
    col += anchorPalette(f.anchorB) * (0.5 * f.anchorB);

    col += vec3(0.22, 0.45, 0.95) * (f.wedgeA * 0.06 + f.wedgeB * 0.06);
    col += vec3(0.42, 0.18, 0.82) * f.overlap * 0.22;

    col += vec3(0.55, 0.85, 1.1) * f.filaments * 0.15;

    // Tear darkens / subtracts coherent bridge light
    col -= vec3(0.16, 0.08, 0.22) * f.tear * 0.22;

    return max(col, 0.0);
}

vec3 shadeSurface(vec3 p, vec3 rd, Hit hit, FieldData f) {
    vec3 n = estimateNormal(p);
    vec3 l = normalize(vec3(0.4, 0.8, -0.6));
    float ndl = 0.5 + 0.5 * dot(n, l);
    float rim = pow(1.0 - max(0.0, dot(n, -rd)), 2.5);

    if (hit.materialId == 1) {
        float g = max(f.anchorA, f.anchorB);
        vec3 c = anchorPalette(g);
        c *= (0.35 + 0.65 * ndl);
        c += vec3(0.2, 0.5, 1.1) * rim * 0.5;
        return c;
    }

    if (hit.materialId == 2) {
        float m = f.phase * (1.0 - 0.75 * f.tear);
        vec3 c = membranePalette(m);
        c *= (0.3 + 0.7 * ndl);
        c += vec3(0.9, 0.95, 1.0) * rim * 0.25 * uMembraneGlow;
        c += vec3(0.5, 0.15, 0.75) * f.overlap * 0.3;
        return c;
    }

    return vec3(0.0);
}

// -----------------------------------------------------------------------------
// Raymarch
// -----------------------------------------------------------------------------

float stepRule(vec3 p, float sdfD, FieldData f) {
    float zScale = clamp(0.16 * adsDepth(p), 0.02, 0.25);
    float membranePenalty = mix(1.0, 0.4, f.phase * (0.4 + 0.6 * f.overlap));
    return max(0.002, sdfD * zScale * membranePenalty);
}

vec3 background(vec3 rd) {
    float v = 0.5 + 0.5 * rd.y;
    vec3 bg = mix(vec3(0.012, 0.015, 0.028), vec3(0.05, 0.04, 0.08), v);
    float stars = pow(hash21(floor(rd.xy * 180.0)), 64.0);
    return bg + 0.1 * stars;
}

vec3 debugColor(FieldData f) {
    if (uDebugMode == 1) return vec3(f.wedgeA);
    if (uDebugMode == 2) return vec3(f.wedgeB);
    if (uDebugMode == 3) return vec3(f.overlap);
    if (uDebugMode == 4) return vec3(f.phase);
    if (uDebugMode == 5) return vec3(f.tear);
    if (uDebugMode == 6) return vec3(f.filaments);
    return vec3(0.0);
}

vec3 render(vec3 ro, vec3 rd) {
    float t = 0.0;
    vec3 color = vec3(0.0);

    for (int i = 0; i < 170; i++) {
        vec3 p = ro + rd * t;
        Hit h = sceneSDF(p);
        FieldData f = evalFields(p);

        if (uDebugMode != 0) {
            color += 0.045 * debugColor(f);
        } else {
            color += 0.035 * accumulateEmission(p, f);
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
    return normalize(uCamBasis * normalize(vec3(uv, 1.9)));
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec3 ro = uCamPos;
    vec3 rd = getRayDir(fragCoord);

    vec3 col = render(ro, rd);

    // soft bloom-ish lift
    col += uScreenBloom * 0.03 * col * col;

    // tonemap / gamma
    col = col / (1.0 + col);
    col = pow(col, vec3(0.4545));

    fragColor = vec4(col, 1.0);
}
