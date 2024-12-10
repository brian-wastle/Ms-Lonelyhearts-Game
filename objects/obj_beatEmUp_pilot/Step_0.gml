switch (objectState) {
    case 0:
		tapTimer -= 1;
		if (tapTimer = 0 && image_index = 0) {
			image_index = 1;
			tapTimer = 20;
		} else if (tapTimer = 0 && image_index = 1) {
			image_index = 0;
			tapTimer = round(random_range(2,4) * 60);
		}
        if (obj_BeatEmUp_controlObject.levelProgress = 1) {
		    objectState = 1;
			tapTimer = 0;
			sprite_index = spr_beatEmUp_pilot1b;
			image_index = 0;
			image_speed = 1.1;
		}
        break;
	case 1:
        if (image_index >= image_number - 1) {
			objectState = 2;
			sprite_index = spr_beatEmUp_pilot1c;
			image_index = 0;
			image_speed = 1.2;
		}
        break;
	case 2:
		
        
        break;
}


