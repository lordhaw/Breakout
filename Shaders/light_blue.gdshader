shader_type canvas_item;

uniform vec4 tint_color:hint_color;

void fragment()
{
	COLOR=texture(TEXTURE, UV) * tint_color;
//	vec4 original_colour = texture(TEXTURE, UV);
	
	
	//vec4 test_colour = vec4(0.0,0.8,0.0,1.0);
	
	//COLOR.xyz = test_colour.xyz;
	COLOR.a = original_colour.a;
}