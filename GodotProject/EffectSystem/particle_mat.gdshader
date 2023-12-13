shader_type spatial;
render_mode unshaded;

uniform sampler2DArray particle_texture;

varying flat int particle_id;

void vertex()
{
    particle_id = INSTANCE_ID % 16;
	
    POINT_SIZE = 48.0;
}

void fragment()
{
    vec4 color = texture(particle_texture, vec3(POINT_COORD, float(particle_id)));
	
    ALBEDO = color.rgb;
	ALPHA = color.a;
}