/*
 * Original shader from: https://www.shadertoy.com/view/3lsSR7
 */

#ifdef GL_ES
precision mediump float;
#endif

// glslsandbox uniforms
uniform float time;
uniform vec2 resolution;

// shadertoy emulation
#define iTime time
#define iResolution resolution

// --------[ Original ShaderToy begins here ]---------- //
#define UVScale 			 0.4
#define Speed				 0.6

#define FBM_WarpPrimary		-0.24
#define FBM_WarpSecond		 0.29
#define FBM_WarpPersist 	 0.78
#define FBM_EvalPersist 	 0.62
#define FBM_Persistence 	 0.5
#define FBM_Lacunarity 		 2.2
#define FBM_Octaves 		 5

//fork from Dave Hoskins
//https://www.shadertoy.com/view/4djSRW
vec4 hash43(vec3 p)
{
	vec4 p4 = fract(vec4(p.xyzx) * vec4(1031, .1030, .0973, .1099));
    p4 += dot(p4, p4.wzxy+19.19);
	return -1.0 + 2.0 * fract(vec4(
        (p4.x + p4.y)*p4.z, (p4.x + p4.z)*p4.y,
        (p4.y + p4.z)*p4.w, (p4.z + p4.w)*p4.x)
    );
}

//offsets for noise
const vec3 nbs0 = vec3(0.0, 0.0, 0.0);
const vec3 nbs1 = vec3(0.0, 1.0, 0.0);
const vec3 nbs2 = vec3(1.0, 0.0, 0.0);
const vec3 nbs3 = vec3(1.0, 1.0, 0.0);
const vec3 nbs4 = vec3(0.0, 0.0, 1.0);
const vec3 nbs5 = vec3(0.0, 1.0, 1.0);
const vec3 nbs6 = vec3(1.0, 0.0, 1.0);
const vec3 nbs7 = vec3(1.0, 1.0, 1.0);

//'Simplex out of value noise', forked from: https://www.shadertoy.com/view/XltXRH
//not sure about performance, is this faster than classic simplex noise?
vec4 AchNoise3D(vec3 x)
{
    vec3 p = floor(x);
    vec3 fr = smoothstep(0.0, 1.0, fract(x));

    vec4 L1C1 = mix(hash43(p+nbs0), hash43(p+nbs2), fr.x);
    vec4 L1C2 = mix(hash43(p+nbs1), hash43(p+nbs3), fr.x);
    vec4 L1C3 = mix(hash43(p+nbs4), hash43(p+nbs6), fr.x);
    vec4 L1C4 = mix(hash43(p+nbs5), hash43(p+nbs7), fr.x);
    vec4 L2C1 = mix(L1C1, L1C2, fr.y);
    vec4 L2C2 = mix(L1C3, L1C4, fr.y);
    return mix(L2C1, L2C2, fr.z);
}

vec4 ValueSimplex3D(vec3 p)
{
	vec4 a = AchNoise3D(p);
	vec4 b = AchNoise3D(p + 120.5);
	return (a + b) * 0.5;
}

//my FBM
vec4 FBM(vec3 p)
{
    vec4 f = vec4(0.0), s = vec4(0.0), n = vec4(0.0);
    float a = 1.0, w = 0.0;
    for (int i=0; i<FBM_Octaves; i++)
    {
        n = ValueSimplex3D(p);
        f += (abs(n)) * a;	//billowed-like
        s += n.zwxy *a;
        a *= FBM_Persistence;
        w *= FBM_WarpPersist;
        p *= FBM_Lacunarity;
        p += n.xyz * FBM_WarpPrimary *w;
        p += s.xyz * FBM_WarpSecond;
        p.z *= FBM_EvalPersist +(f.w *0.5+0.5) *0.015;
    }
    return f;
}

void mainImage(out vec4 col, in vec2 uv)
{
    float aspect = iResolution.x / iResolution.y;
    uv /= iResolution.xy / UVScale *0.1; uv.x *= aspect;
    col = vec4(0.0, 0.0, 0.0, 1.0);
    
    vec4 fbm = (FBM(vec3(uv, iTime *Speed +100.0)));
    float explosionGrad = (dot(fbm.xyzw, fbm.yxwx)) *0.5;
    explosionGrad = pow(explosionGrad, 1.3);
    explosionGrad = smoothstep(0.0,1.0,explosionGrad);
    
    #define color0 vec3(0.5,0.2,1.0) // Color of dark regions
    #define color1 vec3(0.5,0.7,0.8) // Color of bright regions
    
    col.xyz = explosionGrad * mix(color0, color1, explosionGrad) +0.05;
}
// --------[ Original ShaderToy ends here ]---------- //

void main(void)
{
    mainImage(gl_FragColor, gl_FragCoord.xy);
}
