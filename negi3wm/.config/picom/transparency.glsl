// Blended keycolor transparancy by clort.  Jan, 2020
// all colors below 25% intensity get gradually less opaque, down 
// to the target opacity 
//
uniform float opacity;
uniform sampler2D tex;

void main() {
    vec4 c = texture2D(tex, gl_TexCoord[0].xy);
    {
            vec4 vdiff = abs(vec4(0.0, 0.0, 0.0, 1.0) - c);
            float diff = max(max(max(vdiff.r, vdiff.g), vdiff.b), vdiff.a);
            if (diff < 0.25)
                      c *= 0.25 + (3*diff);
    }
    c *= opacity;
    gl_FragColor = c;
}
