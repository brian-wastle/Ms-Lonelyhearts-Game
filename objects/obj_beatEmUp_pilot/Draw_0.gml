
if (objectState = 3) {
		draw_sprite_ext(spr_beatEmUp_jetExhaust, exhaustIndex, x, y + shakeOffset, 1, 1, 0, c_white, 1);
		draw_sprite_ext(spr_beatEmUp_jetFlame, flameIndex, x, y + shakeOffset, 1, 1, 0, c_white, 1);
	}

if ( objectState == 4 && image_index = 1 ) {
	draw_sprite_ext(spr_beatEmUp_jetFlame, flameIndex, x, y + shakeOffset, 1, 1, 0, c_white, 1);
}

draw_sprite_ext(sprite_index, image_index, x, y + shakeOffset, 1, 1, 0, c_white, 1);


draw_text(200, 200, tapTimer);