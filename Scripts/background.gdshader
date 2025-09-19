shader_type canvas_item;

uniform vec2 rect_pos;
uniform vec2 rect_size;

void fragment() {
    vec2 uv = FRAGCOORD.xy;
    if (uv.x >= rect_pos.x && uv.x <= rect_pos.x + rect_size.x &&
        uv.y >= rect_pos.y && uv.y <= rect_pos.y + rect_size.y) {
        discard; // inside the TextureRect -> transparent
    } else {
        COLOR = vec4(0.0, 0.0, 0.0, 1.0); // outside -> black
    }
}
