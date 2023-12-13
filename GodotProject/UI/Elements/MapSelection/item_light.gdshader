// NOTE: Shader automatically converted from Godot Engine 4.2.stable's CanvasItemMaterial.

shader_type canvas_item;
render_mode blend_add;

uniform float falloff: hint_range(0.0, 1.0);

void fragment() {
	float dist = distance(UV, vec2(0.5, 0.5));
	if (dist > 0.5) {
		COLOR = vec4(0.0);
	}
	else if (dist < falloff) {
	}
	else {
		COLOR *= (0.5 - (dist)) / (0.5 - falloff);
	}
}