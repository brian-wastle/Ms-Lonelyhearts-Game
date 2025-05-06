

switch (enemyState) {
    case 1:
		if ((currentIndex < 10 && stateTimer[0] < 5) || (currentIndex >= 10 && stateTimer[0] < 15)) {
		    stateTimer[0] += 1;
		} else {
			currentIndex += 1;
			stateTimer[0] = 0;
		}
		if (currentIndex = image_number) {
		    currentIndex -= 3;
		}
		// change state on scene end
		if (!instance_exists(obj_textbox)) {
		    enemyState = 2;
			currentIndex = image_number - 1;
			stateTimer[0] = 0;
			obj_runAndGun1_scientist.scientistState = 3;
		}
        break;
	case 2:
		if (sprite_index != spr_runAndGun1_bossReact1) {
		    sprite_index = spr_runAndGun1_bossReact1;
			currentIndex = 0;
		}
		
		if (currentIndex < 4) {
		    if (stateTimer[0] < 5) {
			    stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		} else if (currentIndex < 8 ) {
			if (stateTimer[0] < 3) {
			    stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		// idle loop
		}  else if (currentIndex <= image_number - 1) {
			if (stateTimer[1] < 30) {
			    stateTimer[1] += 1;
			} else {
				if (stateTimer[0] < 10) {
					stateTimer[0] += 1;
				} else {
					stateTimer[0] = 0;
					currentIndex += 1;
				}
				if (currentIndex == image_number) {
				    currentIndex -= 4;
					stateTimer[1] = 0;
				}
			}
		}
		break;
	case 3:
		if (sprite_index != spr_runAndGun1_bossReact2) {
		    sprite_index = spr_runAndGun1_bossReact2;
			currentIndex = 0;
		} 
			
		if (currentIndex < 3) {
		    if (stateTimer[0] < 10) {
			    stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		// idle loop
		}  else if (currentIndex <= image_number - 1) {
			var indexDelay = currentIndex % 2 == 0? 3 : 5;
			
			if (stateTimer[0] < indexDelay) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
			if (currentIndex == image_number) {
				currentIndex = 3;
			}
		if (obj_textEngine.boxIndex > obj_textEngine.totalBoxes) {
			enemyState = 4;
			currentIndex = 2;
			stateTimer[0] = 0;
		}
		}
		
		break;
	case 4:
		if (sprite_index != spr_runAndGun1_bossReact3) {
		    sprite_index = spr_runAndGun1_bossReact3;
			currentIndex = 0;
		}
		if (currentIndex < 5) {
		    if (stateTimer[0] < 6) {
			    stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
		// idle loop
		}  else if (currentIndex <= image_number - 1) {
			var indexDelay = currentIndex % 2 == 0? 45 : 15;
			
			if (stateTimer[0] < indexDelay) {
				stateTimer[0] += 1;
			} else {
				stateTimer[0] = 0;
				currentIndex += 1;
			}
			if (currentIndex == image_number) {
				currentIndex = 5;
			}
		}
		break;
	// Transition to boss' idle state
	case 6:
		if (sprite_index != spr_runAndGun1_bossIntro) {
		    sprite_index = spr_runAndGun1_bossIntro;
			currentIndex = 0;
		}
		
		if (currentIndex = 3) {
			stateTimer[0] += 1;
			if (stateTimer[0] == 60) {
			    stateTimer[0] = 0;
				currentIndex = 4;
			}
		} else if (stateTimer[0] < 5) {
		    stateTimer[0] += 1;
		} else {
			currentIndex += 1;
			stateTimer[0] = 0;
		}
		if (currentIndex >= image_number - 1) {
			enemyState = 7;
		}
		break;
	case 7:
		if (sprite_index != spr_runAndGun1_bossIntro2) {
		    sprite_index = spr_runAndGun1_bossIntro2;
			x -= 296;
		}
		if (image_index >= image_number - 1) {
			image_speed = 0;
			stateTimer[0] += 1;
			if (stateTimer[0] == 30) {
				instance_create_layer(x,y,"Objects", obj_runAndGun1_miniboss2);
			    instance_destroy();
			}
		}
		break;
}

if (obj_RunAndGun_Player.x > 12200 && enemyState == 0) {
	enemyState = 1;
	obj_textEngine.scene = 1;
	with (obj_camera) {
	    scr_camera_focus(
	        12720,
	        room_height/2,		//room_height / 2, etc.
	        1					// zoom_levels[1]
	    );
	}
}