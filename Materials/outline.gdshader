shader_type canvas_item;

uniform vec4 line_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
uniform float line_thickness : hint_range(0, 14) = 1.0;

void fragment() {
    vec2 size = TEXTURE_PIXEL_SIZE * line_thickness;
    
    // Sample the current pixel's alpha
    float alpha = texture(TEXTURE, UV).a;
    
    // Check neighboring pixels (Up, Down, Left, Right)
    float outline = texture(TEXTURE, UV + vec2(-size.x, 0.0)).a;
    outline += texture(TEXTURE, UV + vec2(size.x, 0.0)).a;
    outline += texture(TEXTURE, UV + vec2(0.0, -size.y)).a;
    outline += texture(TEXTURE, UV + vec2(0.0, size.y)).a;
    
    // If the current pixel is transparent but surrounded by solid pixels, make it an outline
    outline = min(outline, 1.0);
    
    vec4 color = texture(TEXTURE, UV);
    // Mix the original sprite texture over the outline color
    COLOR = mix(vec4(line_color.rgb, outline), color, color.a);
}