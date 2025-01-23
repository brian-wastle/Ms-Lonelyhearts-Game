 //actionstates
//0 - Still x
//1 - Walking x
//2 - Jumping  - button 1 x
//3 - Combo Attacks / Air Attacks - button 2 x
//4 - Block - button 4
//5 - Super Attacks - button 3
//6 - Slide
//7 - Grab
//8 - Take Damage
//9 - Air Damage
//10 - Knock Down

//13 - Die
//14 - Fall


////DEBUG

if (keyboard_check_pressed(ord("Y"))) {
    x += 1000;
}

depth = -y;

if !gamepad_is_connected(global.pad) {

	key_right = keyboard_check(ord("D"));
	key_left = keyboard_check(ord("A"));
	key_up = keyboard_check(ord("W"));
	key_down = keyboard_check(ord("S"));
	key_jump = keyboard_check(vk_space);
	key_block = keyboard_check(vk_shift);
	key_attack = mouse_check_button_pressed(mb_left);
	key_super = mouse_check_button_pressed(mb_right);

		if (actionstate < 2 || actionstate = 4) {
			if key_left {
			directionOffset = -1;
			}
			if key_right {
				directionOffset = 1;
			}
		}
	
	
	
////////////////////////////////// Actionstate 0 - Still

	if (((!keyboard_check(ord ("W")) && !keyboard_check(ord ("A")) && !keyboard_check(ord ("S")) && !keyboard_check(ord ("D"))) || (key_up && key_down) || (key_left && key_right)) && (actionstate < 2 || (actionstate = 4 && !key_block))) {
		sprite_index = charArray[0,playerChar];
		if (hsp != 0 || vsp != 0) {
			hsp *= .7;
			vsp *= .7;

			if (hsp > 0 && hsp < 1 ) || (hsp < 0 && hsp > -1) {
				hsp = 0;
			}
			if (vsp > 0 && vsp < 1 ) || (vsp < 0 && vsp > -1) {
				vsp = 0;
			}
		}
		actionstate = 0;
	}
	
	
////////////////////////////////// Actionstate 1 - Walking

	if (((keyboard_check(ord ("W")) || keyboard_check(ord ("A")) || keyboard_check(ord ("S")) || keyboard_check(ord ("D"))) && !(key_up && key_down) && !(key_left && key_right)) && (actionstate < 2 || (actionstate = 4 && !key_block))) {
		actionstate = 1;
		image_speed = 1;
	}


	if actionstate = 1 {
		sprite_index = charArray[1,playerChar];
		
		if (key_right || key_left) && (hspWalk < hspMaxWalk) {
			hspWalk += .5;
			}
		if (key_right && key_left) || (keyboard_check_released(ord("D")) && keyboard_check_pressed(ord("A"))) || (keyboard_check_released(ord("A")) && keyboard_check_pressed(ord("D"))) {
			hspWalk = 0;
			}
		hsp = (key_right - key_left) * hspWalk;
		
		if (key_up || key_down) && (vspWalk < vspMaxWalk) {
			vspWalk += .5;
			}
		if (key_up && key_down) || (keyboard_check_released(ord("S")) && keyboard_check_pressed(ord("W"))) || (keyboard_check_released(ord("W")) && keyboard_check_pressed(ord("S"))) {
			vspWalk = 0;
			}
		vsp = (key_down - key_up) * vspWalk;

	}
	
	
////////////////////////////////// Actionstate 2 - Jumping

	
	if (keyboard_check_released(vk_space) || (actionstate = 2 || actionstate = 14)) && jumpStatus = 1 {
		jumpStatus = 2;
	}
		
	
	if keyboard_check_pressed(vk_space) && actionstate != 2 && actionstate != 14 {
		jumpStatus = 1;
	}
	
	if (key_jump && actionstate != 3 && jumpStatus < 2 ) { 
		hspJump = hsp;
		hsp = 0;
		vspJump = vsp;
		vsp = 0;
		zspJump = zspMaxJump;
		actionstate = 2;
		sprite_index = charArray[3,playerChar];
		image_index = 0;
		image_speed = 1;
	}
	
	if (actionstate = 2) {	
		if (image_index >= 2) {
			if (airAttackState == 0) {
				if (zspJump < 13) {
				    image_index = 3;
				} else {
					image_index = 2;
				}
				image_speed = 0;
			}
		    zspJump -= .75;
	
			//move vertically	
			if (zspJump > zspMaxJump) {
				zspJump = zspMaxJump;
			}
			zsp += zspJump;
			
			//move horizontally
			if key_right && (abs(hspJump) < hspMaxJump) {
				hspJump += .6;
			}
			if key_left && (abs(hspJump) < hspMaxJump) {
				hspJump -= .6;
			}
			hsp = hspJump;
	
			//move forward and backward
			if key_up && (abs(vspJump) < vspMaxJump) {
				vspJump -= .6;
			}
			if key_down && (abs(vspJump) < vspMaxJump) {
				vspJump += .6;
			}
			vsp = vspJump;
		}
		
	}
	
////////////////////////////////// Actionstate 3 - Attack Combo

	if (actionstate = 3) {
		var timerLimit = 4;
		comboTimer += 1;
		
		if (image_index > 5 && image_index < 9) {
		    timerLimit = 2;
		} 
		
		if (image_index > 10 && image_index < 15) {
		    timerLimit = 2;
		}
		
		if (image_index > 16 && image_index < 21) {
		    timerLimit = 2;
		}
		
		switch (image_index) {
		    case 9:
		    case 15:
		    case 22:
				timerLimit = 8;
				break;
		}
			
		if (comboTimer == timerLimit) {
			comboTimer = 0;
			image_index += 1;
		}
		
		switch (image_index) {
		    case 3:
		    case 6:
		    case 12:
			case 17:
		        if (attackQueue = 1 && comboTimer == 0) {
				    attackQueue = 0;
				} else if (attackQueue = 0 && comboTimer == 0) {
					sprite_index = charArray[0,playerChar];
					actionstate = 0;
				}
		        break;
			case image_number: 
				sprite_index = charArray[0,playerChar];
				actionstate = 0;
		    default:
		        if (key_attack) {
				    attackQueue = 1;
				}
		        break;
		}
		
		if (image_index > 21) {	
			x += directionOffset * 4;
		}
		
	}

	if (actionstate < 2 && key_attack) {
		actionstate = 3;
		sprite_index = charArray[2, playerChar];
		image_index = 0;
		image_speed = 0;
		hsp = 0;
		vsp = 0;
	}
	
////////////////////////////////// Air Attacks

	if (sprite_index = charArray[3,playerChar] && key_attack && jumpStatus == 2 && (image_index < 4 || image_index > 5)) {
		// Forward Air Attack
		//if (key_left || key_right || key_up || key_down) {
			if (actionstate == 2 || (actionstate == 14 )) {
			    image_index = 3;
				image_speed = 1;
				airAttackState = 1;
			}

			
			if playerChar = 2 {
				if (!instance_exists(obj_beatEmUp_PlayerRobotSmoke)) {
					instance_create_layer(x,y,"Instances",obj_beatEmUp_PlayerRobotSmoke);
				}
				if (directionOffset = 1) {
					hspJump += 8;
				} else {
					hspJump -= 8;
				}
			
			}
		
		
	//} 
	
	// Neutral Air attack
	//else if (!key_left && !key_right && !key_up && !key_down) {
	//	image_index = 3;
	//	if playerChar = 2 {
	//		if (!instance_exists(obj_beatEmUp_PlayerRobotSmoke)) {
	//			instance_create_layer(x,y,"Instances",obj_beatEmUp_PlayerRobotSmoke);
	//		}
	//		if (directionOffset = 1) {
	//			hspJump += 4;
	//		} else {
	//			hspJump -= 4;
	//		}
			
	//	}
	//}
	}


////////////////////////////////// Actionstate 4 - Block

	if (actionstate < 2 && key_block) {
		actionstate = 4;
		hspWalk = 0;
		vspWalk = 0;
		hsp = 0;
		vsp = 0;
	}

	if (actionstate = 4) {
		sprite_index = charArray[2,playerChar];
		image_index = 1;
		image_speed = 0;
	}


////////////////////////////////// Actionstate 14 - Falling


	if (actionstate = 2 && (zspJump <= 0)) {
		zspJump = 0;	
		actionstate = 14;
		if hspJump = 0 && hspWalk != 0 {
			if hsp > 0 {
				hspJump = hspWalk;
			}
			if hsp < 0 {
				hspJump = hspWalk * -1;
			}
		}
	}

	if actionstate = 14 {
		if landingTimer = 0 {
			if (airAttackState == 0) {
				image_index = 6;
			}
			
			//move horizontally
			if key_right && (abs(hspJump) < hspMaxJump)
				{
				hspJump += .6;
				}
			if key_left && (abs(hspJump) < hspMaxJump)
				{
				hspJump -= .6;
				}
				hsp = hspJump;
		
			//move forward and backward
			if key_up && (abs(vspJump) < vspMaxJump) {
				vspJump -= .6;
			}
			if key_down && (abs(vspJump) < vspMaxJump) {
				vspJump += .6;
			}
			vsp = vspJump;
	
			//drop from jump height
			zspJump += 1;
	
			if zspJump > 24
				{zspJump = 24;}
		
			zsp -= zspJump;
		}

		if landingTimer > 0 {
			jumpStatus = 3;
			landingTimer -= 1;
		}
		if landingTimer == 1 {
			airAttackState = 0;
			landingTimer = 0;
			actionstate = 0;
		} 
		
	}
	
	
	


	////////////////////////////////// Clean-up  //////////////////////////////////////////////////////////////////////////////////////////////////////////

	if (!key_jump && actionstate != 2 && actionstate != 14) {
		jumpStatus = 0;
	}


	if x - 20 < camera_get_view_x(view_camera[0]) {
		x = camera_get_view_x(view_camera[0]) + 20;
	}


	//////////////////////////// Actionstate 1 - Walking

	if (actionstate = 1) {
		if hspWalk > hspMaxWalk {
			hspWalk = hspMaxWalk;
		}
	
		if hsp > hspMaxWalk {
			hsp = hspMaxWalk;
		}
		if hsp < (hspMaxWalk * -1) {
			hsp = hspMaxWalk * -1;
		}
	
		if vspWalk > vspMaxWalk {
			vspWalk = vspMaxWalk;
		}
		if vsp > vspMaxWalk {
			vsp = vspMaxWalk;
		}
		if vsp < vspMaxWalk * -1 {
			vsp = vspMaxWalk * -1;
		}
	
	}

	y = y + vsp;
	if y < 700 {
		y = 700;
	}
	if y > 1075 {
		y = 1075;
	}
	x = x + hsp;		
	
	
	/////////////////////////// Actionstate 14 - Falling
		
	if ((zsp <= 0) && actionstate = 14 && jumpStatus = 2) { 
		landingTimer = 10;
		if (playerChar = 2) {
			landingTimer = 15;
		}
		airAttackState = 0;
		hspJump = 0;
		hsp = 0;
		vspJump= 0;
		vsp = 0;
		zspJump = 0;
		zsp = 0;
		image_index = 7;
		image_speed = 0;
	}

	// (zsp / 231.25) 0 to 1
	shadowSize = 1 * (1-(zsp / 231.25));
	if (shadowSize < .5) {
		shadowSize = .5;
	}

	if ((actionstate == 2 || actionstate == 14) && airAttackState == 1 && image_index >= 5 && jumpStatus == 2) {
		image_index = 5;
		image_speed = 0;
	}
}










////// Gamepad Controls


if gamepad_is_connected(global.pad) {
	
	haxis = gamepad_axis_value(0, gp_axislh);
	vaxis = gamepad_axis_value(0, gp_axislv);
	
	

	if (actionstate < 2 || actionstate = 4) {
		if haxis < 0 {
		directionOffset = -1;
		}
		if haxis > 0 {
			directionOffset = 1;
		}
	}
	
////////////////////////////////// Actionstate 0 - Still

	if ((haxis <= .2 && haxis >= -.2 && vaxis <= .2 && vaxis >= -.2) && (actionstate < 2 || (actionstate = 4 && !gamepad_button_check(global.pad,gp_face2)))) {
		sprite_index = charArray[0,playerChar];
		speed = 0;
		actionstate = 0;
	}
	
	
////////////////////////////////// Actionstate 1 - Walking

	if ((haxis >= .2 || haxis <= -.2 || vaxis >= .2 || vaxis <= -.2) && (actionstate < 2 || (actionstate = 4 && !gamepad_button_check(global.pad,gp_face2)))) {
		actionstate = 1;
		image_speed = 1;
	}


	if actionstate = 1 {
		sprite_index = charArray[1,playerChar];
		direction = point_direction(0, 0, haxis, vaxis);
		speed = point_distance(0 ,0, haxis, vaxis * .4) * 7;
	}
	
	
////////////////////////////////// Actionstate 2 - Jumping

	
	if (gamepad_button_check_released(global.pad,gp_face1) || (actionstate = 2 || actionstate = 14)) && jumpStatus = 1 {
		jumpStatus = 2;
	}
		
	
	if (gamepad_button_check_pressed(global.pad,gp_face1) && actionstate != 2 && actionstate != 14) || (actionstate = 2 && image_index < 1 && jumpStatus = 0) {
		jumpStatus = 1;
	}
	
	if (gamepad_button_check(global.pad,gp_face1) && actionstate != 3 && jumpStatus < 2 ) { 
		zspJump = zspMaxJump;
		actionstate = 2;
		sprite_index = charArray[3,playerChar];
		image_index = 0;
		image_speed = 1;
	}
	
	if (actionstate = 2) {	
		if image_index >= 1.5 {
			image_speed = 0;
		}
		zspJump -= .75;
	
		zsp += zspJump;
		direction = point_direction(0, 0, haxis, vaxis);
		speed = point_distance(0 ,0, haxis, vaxis * .6) * 7;
	
	}
	
////////////////////////////////// Actionstate 3 - Attack Combo

	

	if (actionstate = 3) {
		
	}
	
	

	if (actionstate < 2 && gamepad_button_check_pressed(global.pad,gp_face3)) {
		speed = 0;
		image_index = 0;
		image_speed = 0;
		actionstate = 3;
	}
	
////////////////////////////////// Air Attacks

	if (sprite_index = charArray[3,playerChar] && gamepad_button_check_pressed(global.pad,gp_face3) && image_index < 2) {
		if (haxis < -.2 || haxis > .2) {
			image_index = 2;
			if playerChar = 2 {
				if (!instance_exists(obj_beatEmUp_PlayerRobotSmoke)) {
					instance_create_layer(x,y,"Instances",obj_beatEmUp_PlayerRobotSmoke);
				}
			}
		} else if (haxis = 0) {
			image_index = 3;
			if playerChar = 2 {
				if (!instance_exists(obj_beatEmUp_PlayerRobotSmoke)) {
					instance_create_layer(x,y,"Instances",obj_beatEmUp_PlayerRobotSmoke);
				}
			}
		}
	}

	if (sprite_index = charArray[3,playerChar] && image_index >= 2) {
		if (directionOffset = 1) {
			speed = 12;
			direction = 0;
		} else {
			speed = 12;
			direction = 180;
		}
	}
	if (sprite_index = charArray[3,playerChar] && image_index >= 3) {
		image_speed = .8;
		if (image_index >= image_number-.5) {
			image_index = 5;
			image_speed = 0;
		}
	}

	////////////////////////////////// Actionstate 4 - Block

	if (actionstate < 2 && gamepad_button_check(global.pad,gp_face2)) {
		actionstate = 4;
		speed = 0;
	}

	if (actionstate = 4) {
		sprite_index = charArray[2,playerChar];
		image_index = 1;
		image_speed = 0;
	}


	////////////////////////////////// Actionstate 14 - Falling


	if (actionstate = 2 && (zspJump <= 0)) {
		zspJump = 0;	
		actionstate = 14;
	}

	if actionstate = 14 {
		if landingTimer = 0 {

			//drop from jump height
			zspJump += 1;
	
			if zspJump > 24
				{zspJump = 24;}
		
			zsp -= zspJump;
		}

		if landingTimer > 0 {
			image_index = 0;
			speed = 0;
			jumpStatus = 3;
			landingTimer -= 1;
		}
		if landingTimer = 1 {
			airAttackState = 0;
			landingTimer = 0;
			actionstate = 0;
		}
		
	}
	
	
	


	////////////////////////////////// Clean-up  //////////////////////////////////////////////////////////////////////////////////////////////////////////

	if (!gamepad_button_check(global.pad,gp_face1) && actionstate != 2 && actionstate != 14) {
		jumpStatus = 0;
	}


	if x - 20 < camera_get_view_x(view_camera[0]) {
		x = camera_get_view_x(view_camera[0]) + 20;
	}


	//////////////////////////// Actionstate 1 - Walking

	if (actionstate = 1) {
		if (haxis < .2 && haxis > -.2) {
			haxis = 0;
		}
		if (vaxis < .2 && vaxis > -.2) {
			vaxis = 0;
		}
	
	}

	if y < 700 {
		y = 700;
	}
	if y > 1075 {
		y = 1075;
	}	
	
	/////////////////////////// Actionstate 14 - Falling

	if ((zsp <= 0) && actionstate = 14 && jumpStatus = 2) { 
		landingTimer = 10;
		if (playerChar = 2) {
			landingTimer = 15;
		}
		speed = 0;
		zspJump = 0;
		zsp = 0;
		image_index = image_number - 1;
	}

	// Resize player shadow
	shadowSize = 1 * (1-(zsp / 231.25));
	if (shadowSize < .5) {
		shadowSize = .5;
	}
}