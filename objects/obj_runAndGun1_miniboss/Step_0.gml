if (obj_RunAndGun_Player.x > 12200 && enemyState == 0) {
	enemyState = 1;
	image_speed = 1;
}

switch (enemyState) {
    case 1:
        if (image_index == 6) {
			enemyState = 2;
			image_speed = 0;
		}
        break;
    case 2:
		if (stateTimer < 60) {
		    stateTimer += 1;
		} else {
			image_speed = 1;
		}
		if (image_index == 10) {
			stateTimer = 0;
		    enemyState = 3;
			image_speed = 0;
		}
        break;
	case 3:
		stateTimer += 1;
		if (image_index == 10 && stateTimer == 120) {
		    stateTimer = 0;
			image_index += 1;
		}
		if (image_index == 11 && stateTimer == 60) {
		    stateTimer = 0;
			enemyState = 4;
			image_speed = .25;
		}
		break;
	case 4:
		if (image_index == 13) {
		    image_speed = 1;
		}
		if (image_index == 17) {
		    image_speed = 0;
			enemyState = 5;
		}
		break;
	case 5:
		stateTimer += 1;
		if (stateTimer == 90) {
		    image_speed = 1;
		}
		if (image_index >= image_number - 1) {
		    sprite_index = spr_runAndGun1_bossIntro2;
			x -= 296;
			enemyState = 6;
			stateTimer = 0;
		}
		break;
	case 6:
		if (image_index >= image_number - 1) {
			image_speed = 0;
			stateTimer += 1;
			if (stateTimer == 30) {
				instance_create_layer(x,y,"Objects", obj_runAndGun1_miniboss2);
			    instance_destroy();
			}
		}
		break;
}