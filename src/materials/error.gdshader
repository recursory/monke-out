shader_type canvas_item;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	float aspect = SCREEN_PIXEL_SIZE.x/SCREEN_PIXEL_SIZE.y;
	vec2 squv = SCREEN_UV*vec2(1.0, aspect);
	float checker = float(int(floor(mod(squv.x*10., 2.))) ^ int(floor(mod(squv.y*10., 2.))));
	COLOR *= vec4(checker, 0., checker, 1.);
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
