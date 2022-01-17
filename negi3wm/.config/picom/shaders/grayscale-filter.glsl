uniform sampler2D tex;
uniform float opacity;
void main() {
    vec4 color = texture2D(tex, gl_TexCoord[0].xy);
    gl_FragColor = vec4(
        vec3(0.2126 * color.r + 0.7152 * color.g + 0.0722 * color.b) * opacity,
        color.a * opacity);
}
