prone = 0;
image_speed = 0;
switch (direction) {
    case 0:
        image_index = 2;
        break;
	case 45:
        image_index = 1;
        break;
	case 90:
        image_index = 0;
        break;
	case 135:
        image_index = 1;
        break;
	case 180:
        image_index = 2;
        break;
	case 225:
        image_index = 3;
        break;
	case 270:
        image_index = 4;
        break;
	case 315:
        image_index = 3
        break;
}

if (obj_RunAndGun_Player.sprite_index = spr_RunAndGun_PlayerStillProne) {
	y+= 92;
}