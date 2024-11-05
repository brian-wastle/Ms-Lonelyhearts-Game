if (obj_BeatEmUp_Player.x > 7643) {
	init = 1;
}

if (init = 1) {
	if (image_index <= 0) {
		image_speed = 1;
	}
	if (image_index >= image_number - 1) {
		image_speed = 0;
	}
}