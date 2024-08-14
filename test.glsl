
#extension GL_OES_standard_derivatives : enable

#ifdef GL_ES
precision mediump float;
#endif

varying vec4 v_position;
varying vec4 v_normal;
varying vec2 v_texcoord;
varying vec4 v_color;

uniform mat4 u_projectionMatrix;
uniform mat4 u_modelViewMatrix;
uniform mat4 u_normalMatrix;
uniform vec2 u_resolution;
uniform float u_time;

#if defined(VERTEX)

// attribute vec4 a_position; // myfolder/myfile.obj
attribute vec4 a_position;
attribute vec4 a_normal;
attribute vec2 a_texcoord;
attribute vec4 a_color;

varying vec4 pos;

void main(void)
{
	pos = a_position;
	if (pos.y < 1.)
		pos.y += (tan(u_time));
	else if (pos.y >= 1.)
		pos.y -= (tan(u_time));

	v_position = a_position;
	v_position.z = 0.;
	v_normal = a_normal;
	v_texcoord = a_texcoord;
	v_color = a_color;
	gl_Position = v_position;
}

#else // fragment shader

uniform vec2 u_mouse;
uniform vec2 u_pos;
// uniform sampler2D u_texture; // https://cdn.jsdelivr.net/gh/actarian/plausible-brdf-shader/textures/mars/4096x2048/diffuse.jpg?repeat=true
// uniform vec2 u_textureResolution;

float checker(vec2 uv, float repeats) {
	float cx = floor(repeats * uv.x);
	float cy = floor(repeats * uv.y);
	float result = mod(cx + cy, 2.0);
	return sign(result);
}

varying vec4 pos;

void main()
{
	
	float fadeFactor = smoothstep(0., 1., abs(pos.y));
	vec4	blue	= vec4(0., 0., 1., 1);
	vec4	pink	= vec4(1., 0., 1., 1.);

	vec4	finalColour = mix(pink, blue, fadeFactor);
	gl_FragColor = finalColour;

}

#endif
