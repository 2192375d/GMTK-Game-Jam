shader_type spatial;
render_mode unshaded, cull_disabled, blend_mix;

uniform vec4 line_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
uniform float line_thickness : hint_range(0.001, 0.1) = 0.02;
uniform float dash_frequency : hint_range(1.0, 100.0) = 10.0; // Lines per world unit
uniform float scroll_speed : hint_range(-10.0, 10.0) = 2.0; // Speed of marching ants
uniform vec2 rect_size = vec2(1.0, 1.0); // Passed from script

void fragment() {
vec2 uv = UV;
	
	// Distance from edges in world space units
	vec2 dist_from_edge = min(uv, 1.0 - uv) * rect_size;
	float is_border = step(min(dist_from_edge.x, dist_from_edge.y), line_thickness);
	
	// Calculate perimeter distance along edges so lines scroll cleanly around corners
	vec2 perimeter_pos = (uv - 0.5) * rect_size;
	
	// Animate position using TIME
	float time_offset = TIME * scroll_speed;
	float dash_pattern = step(0.5, fract((perimeter_pos.x + perimeter_pos.y) * dash_frequency - time_offset));
	
	ALBEDO = line_color.rgb;
	ALPHA = is_border * dash_pattern * line_color.a;
}