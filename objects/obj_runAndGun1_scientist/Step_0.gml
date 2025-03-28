if (obj_RunAndGun_Player.x > 12000 && scientistState == 0) {
	scientistState = 1;
}

switch (scientistState) {
	case 1:
		currentFrame += frameSpeed;
        if (currentFrame == 14) {
		    currentFrame = 3;
			stateLoop += 1;
		}
		if (stateLoop == 3) {
		    scientistState = 2;
			stateLoop = 0;
		}
		break;
    case 2:
		currentFrame += frameSpeed;
	    if (currentFrame >= 16) {
			scientistState = 3;
		}
        break;
    case 3:
		currentFrame += frameSpeed;
        if (currentFrame == 24) {
		    currentFrame = 16;
			stateLoop += 1;
		}
		if (stateLoop == 4) {
		    scientistState = 4;
		}
        break;
	case 4:
		if (currentFrame < 40) {
		    currentFrame += frameSpeed * 2;
		} else {
			currentFrame += frameSpeed
		}
		
		
		if (currentFrame >= image_number - 1) {
		    instance_destroy();
		}
		break;
}