switch (state) {
    case 0:
        if (keyboard_check_pressed(ord("Y"))) {
			obj_textEngine.level = 1;
			state = 1;
		}
        break;
   case 1:
        if (keyboard_check_pressed(ord("P"))) {
			obj_textEngine.scene = 1;
			state = 2;
		}
        break;
}