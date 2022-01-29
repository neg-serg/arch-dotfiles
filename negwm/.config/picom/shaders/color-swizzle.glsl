#version 130
#extension GL_ARB_shading_language_420pack: enable

#define CYCLE 5000 // The amount of miliseconds it takes to do a full "loop" around all the colors.

uniform float opacity;
uniform bool invert_color;
uniform sampler2D tex;
uniform float time;

float get_decimal_part(float f) {
	return f - int(f);
}

float snap0(float f) {
	return (f < 0) ? 0 : f;
}

void main() {
	vec4 c = texture2D(tex, gl_TexCoord[0].xy);
	float f = get_decimal_part(time / CYCLE);

	gl_FragColor.a = 1;

	float p[3] = {
		snap0(0.33 - abs(f - 0.33)) * 4,
		snap0(0.33 - abs(f - 0.66)) * 4,
		snap0(0.33 - abs(f - 1.00)) * 4 + snap0(0.33 - abs(f - 0.0)) * 4
	};
	gl_FragColor.r = p[0] * c.r + p[1] * c.g + p[2] * c.b;
	gl_FragColor.g = p[2] * c.r + p[0] * c.g + p[1] * c.b;
	gl_FragColor.b = p[1] * c.r + p[2] * c.g + p[0] * c.b;
}
