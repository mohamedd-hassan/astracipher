shader_type canvas_item;

uniform float circle_radius = 0.3;

uniform float circle_position_x = -0.2;

uniform float circle_position_y = -0.025;


uniform vec4 color: source_color;

float circle(vec2 position, float radius, float feather)
{
	return smoothstep(radius, radius + feather, length(position - vec2(0.5)));
}

void fragment() {
	vec2 uv = vec2(SCREEN_UV.x + circle_position_x, SCREEN_UV.y + circle_position_y);
	uv.x *= 1.7777777777777777777777777777778;
	//float d = length(uv + circle_position);
	float c = circle(uv, circle_radius, 0.005);
	if (circle_radius == 0.0) c = 1.0;
	COLOR = vec4(color.rgb, c);
}
