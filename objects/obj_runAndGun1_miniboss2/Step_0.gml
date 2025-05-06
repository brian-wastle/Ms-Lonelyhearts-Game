if (enemyState == -1) {
    image_index += .2;
	if (image_index >= image_number - 1.5) {
	    enemyState = 0;
		sprite_index = spr_runAndGun1_minibossCBA;
		image_speed = 1;
	}
}