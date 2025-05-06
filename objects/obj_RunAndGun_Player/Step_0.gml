 //actionstates
//0 - Still x
//1 - Walking x
//2 - Jumping x
//3 - Shoot
//11 - Take Damage
//13 - Die
//14 - Fall x
if (obj_camera.cutscene == false) {
    // code here


if !gamepad_is_connected(global.pad) {
	//initalize

	image_speed = 1;

	key_right = keyboard_check(ord("D"));
	key_left = keyboard_check(ord("A"));
	key_up = keyboard_check(ord("W"));
	key_fall = keyboard_check(ord("S"));
	key_jump = keyboard_check(vk_space);
	key_slide = keyboard_check_pressed(vk_shift);
	key_hook = mouse_check_button_pressed(mb_right);


	if hsp_walk > hsp_max_walk
		{
		hsp_walk = hsp_max_walk;
		}
	
	if hsp > hsp_max_walk
		{
		hsp = hsp_max_walk;
		}
	if hsp < hsp_max_walk * -1
		{
		hsp = hsp_max_walk * -1;
		}

		hsp = (key_right - key_left) * hsp_walk;


	if (!keyboard_check(ord("W")) && !keyboard_check(ord("A")) && !keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
		if (sprite_index = spr_RunAndGun_PlayerStill)  {
			if (xOffset = 1) {
				directionOffset = "right";
			} else if (xOffset = -1) {
				directionOffset = "left";
			}
		}
	}

	if (!keyboard_check(ord("W")) && !keyboard_check(ord("A")) && !keyboard_check(ord("S")) && keyboard_check(ord("D"))) {
		directionOffset = "right";
		xOffset = 1;
	} else if (keyboard_check(ord("W")) && !keyboard_check(ord("A")) && !keyboard_check(ord("S")) && keyboard_check(ord("D"))) {
		directionOffset = "upRight";
		xOffset = 1;
	} else if (keyboard_check(ord("W")) && !keyboard_check(ord("A")) && !keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
		directionOffset = "up";
		yOffset = 1;
	} else if (keyboard_check(ord("W")) && keyboard_check(ord("A")) && !keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
		directionOffset = "upLeft";
		xOffset = -1;
	} else if (!keyboard_check(ord("W")) && keyboard_check(ord("A")) && !keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
		directionOffset = "left";
		xOffset = -1;
	} else if (!keyboard_check(ord("W")) && keyboard_check(ord("A")) && keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
		directionOffset = "downLeft";
		xOffset = -1;
	} else if (!keyboard_check(ord("W")) && !keyboard_check(ord("A")) && keyboard_check(ord("S")) && !keyboard_check(ord("D"))) {
		directionOffset = "down";
		yOffset = -1;
	} else if (!keyboard_check(ord("W")) && !keyboard_check(ord("A")) && keyboard_check(ord("S")) && keyboard_check(ord("D"))) {
		directionOffset = "downRight";
		xOffset = 1;
	}
	if (!keyboard_check(ord("W")) && !keyboard_check(ord("S"))) {
		yOffset = 0;
	}

	////////////////////////////////// Actionstate 0 - Still

	if (!keyboard_check(ord ("A")) && !keyboard_check(ord ("D"))) && actionstate != 2 && actionstate != 14 {
		if hsp_walk != 0
			{
			hsp_walk -= 2;
			if (hsp_walk > 0 && hsp_walk < 2 ) || (hsp_walk < 0 && hsp_walk > -2)
				{
				hsp_walk = 0;
				}
			}
		actionstate = 0;
		}

	if (actionstate = 0) {
		sprite_index = spr_RunAndGun_PlayerStill;
		if (xOffset = 1) {
			bulletDir = 0;
		} else {
			bulletDir = 180;
		}
		if (yOffset = 1) {
			sprite_index = spr_RunAndGun_PlayerStillUp; //up sprite
			bulletDir = 90;
		} else if (yOffset = -1) {
			sprite_index = spr_RunAndGun_PlayerStillProne; //prone sprite
		}
	}



	////////////////////////////////// Actionstate 1 - Walking

	if ((keyboard_check(ord ("A")) || keyboard_check(ord ("D"))) && actionstate < 2) {
		actionstate = 1;
	}

	if actionstate = 1 {
	
		//move horizontally
		if (key_right || key_left) && (hsp_walk < hsp_max_walk)
			{
			hsp_walk += .5;
			}
		if (key_right && key_left) || (keyboard_check_released(ord("D")) && keyboard_check_pressed(ord("A"))) || (keyboard_check_released(ord("A")) && keyboard_check_pressed(ord("D")))
			{
			hsp_walk = 0;
			}
		hsp = (key_right - key_left) * hsp_walk;
	

	
		if (directionOffset = "right" || directionOffset = "left") {
			sprite_index = spr_RunAndGun_PlayerRun;
			if (xOffset = 1) {
				bulletDir = 0;
			} else {
				bulletDir = 180;
			}
		}
		if (directionOffset = "up") {
			sprite_index = spr_RunAndGun_PlayerRunUp;
			bulletDir = 90;
		}
		if (directionOffset = "downRight" || directionOffset = "downLeft") {
			sprite_index = spr_RunAndGun_PlayerRunDownRight;
			if (xOffset = 1) {
				bulletDir = 315;
			} else {
				bulletDir = 225;
			}
		}
		if (directionOffset = "upRight" || directionOffset = "upLeft") {
			sprite_index = spr_RunAndGun_PlayerRunUpRight;
			if (xOffset = 1) {
				bulletDir = 45;
			} else {
				bulletDir = 135;
			}
		}
	
	}



	////////////////////////////////// Actionstate 2 - Jumping
	
	// Fall through floor
	if (actionstate = 0 && key_fall && key_jump && !collision_line(x - 12, y + 1, x + 12, y + 1, obj_RunAndGun_ParentOverlay, 1, 1) ) {
		y += 8;
		actionstate = 14;
	}

	if (keyboard_check_released(vk_space) || (actionstate == 2 || actionstate == 14)) && jump_status == 1 {
		jump_status = 2;
	}


	if keyboard_check_pressed(vk_space) && actionstate != 2 && actionstate != 14 && actionstate != 3 {
		jump_status = 1;
	}

	//collision check
	if ((collision_line(x - 10, y + 1, x + 10, y + 1, obj_RunAndGun_ParentPlatform, 1, 1) || collision_line(x - 12, y + 1, x + 12, y + 1, obj_RunAndGun_ParentOverlay, 1, 1)) && (!key_fall || (key_left || key_right)) && key_jump && jump_status < 2) { 

		hsp_jump = hsp;
		hsp = 0;

	actionstate = 2;
	}

	if (actionstate = 2) {	
		vsp_max_height -= 2;

		//move vertically	
		if (key_jump) && (vsp_jump > vsp_max_jump) {
			vsp_jump = vsp_max_jump;
		}

		vsp = vsp_jump;

		if vsp_jump < vsp_max_jump {
			vsp_jump = vsp_max_jump;
		}

		//move horizontally
		if key_right && (abs(hsp_jump) < hsp_max_jump) {
			hsp_jump += .6;
		}
		if key_left && (abs(hsp_jump) < hsp_max_jump) {
			hsp_jump -= .6;
		}
		hsp = hsp_jump;


		//stop horizontal movement when no key press left or right
		if (!key_right && !key_left) || (key_right && key_left) {
			if (hsp_jump != 0) {
				if hsp_jump < 0 {
					hsp_jump += .3;
				}
				if hsp_jump > 0 {
					hsp_jump -= .3;
				}
				if (hsp_jump > 0 && hsp_jump < .3 ) || (hsp_jump < 0 && hsp_jump > -.3) {
					hsp_jump = 0;
				}
			}
		}
	
	
		if (directionOffset = "right" || directionOffset = "left") {
			sprite_index = spr_RunAndGun_PlayerJump;
			if (xOffset = 1) {
				bulletDir = 0;
			} else {
				bulletDir = 180;
			}
		}
		if (directionOffset = "up") {
			sprite_index = spr_RunAndGun_PlayerJumpUp;
			bulletDir = 90;
		}
		if (directionOffset = "down") {
			sprite_index = spr_RunAndGun_PlayerJumpDown;
			bulletDir = 270;
		}
		if (directionOffset = "downRight" || directionOffset = "downLeft") {
			sprite_index = spr_RunAndGun_PlayerJumpDownRight;
			if (xOffset = 1) {
				bulletDir = 315;
			} else {
				bulletDir = 225;
			}
		}
		if (directionOffset = "upRight" || directionOffset = "upLeft") {
			sprite_index = spr_RunAndGun_PlayerJumpUpRight;
			if (xOffset = 1) {
				bulletDir = 45;
			} else {
				bulletDir = 135;
			}
		}
	
		if image_index <= 2 {
			image_speed = .8;
		} else {
			image_speed = 0;
		}
		if (image_index >= 3) {
			image_index = 1;
		}
	}

	////////////////////////////////// Actionstate 3 - Shoot


	if mouse_check_button_pressed(mb_left) {
	
		instance_create_layer(x,y,"Instances",obj_RunAndGun_playerBullet1, {
			speed:20,
			direction:bulletDir,
			spriteDir:xOffset
		});
	}

	if mouse_check_button(mb_left) {
		bulletTimer += 1;
		if bulletTimer >= 15 {

			instance_create_layer(x,y,"Instances",obj_RunAndGun_playerBullet1, {
				speed:20,
				direction:bulletDir,
				spriteDir:xOffset
			});
			bulletTimer = 0;
		}
	}

	if mouse_check_button_released(mb_left) {
		bulletTimer = 0;
	}


	////////////////////////////////// Actionstate 14 - Falling

	
	if ((actionstate = 2 && !key_jump) || (vsp_max_height < vsp_max_jump) || (actionstate < 2 
	&& !collision_line(x - 12, y + 1, x + 12, y + 1, obj_RunAndGun_ParentOverlay, 1, 1) 
	&& !collision_line(x - 10, y + 1, x + 10, y + 1, obj_RunAndGun_ParentPlatform, 1, 1))) {
		vsp_max_height = 0;	
		actionstate = 14;
		if hsp_jump = 0 && hsp_walk != 0 {
			if hsp > 0 {
				hsp_jump = hsp_walk;
			}
			if hsp < 0 {
				hsp_jump = hsp_walk * -1;
			}
		}
	}
	


	if actionstate == 14 {
	
		//move horizontally
		if key_right && (abs(hsp_jump) < hsp_max_jump)
			{
			hsp_jump += .6;
			}
		if key_left && (abs(hsp_jump) < hsp_max_jump)
			{
			hsp_jump -= .6;
			}
			hsp = hsp_jump;
	
		if vsp > 24
			{vsp = 24;}
	
	
		//stop horizontal movement when no key press left or right
		if ((!key_right && !key_left) || (key_right && key_left)) {
			if (hsp_jump != 0) {
				if (hsp_jump < 0) {
					hsp_jump += .3;
				}
				if (hsp_jump > 0) {
					hsp_jump -= .3;
				}
				if ((hsp_jump > 0 && hsp_jump < .3 ) || (hsp_jump < 0 && hsp_jump > -.3)) {
					hsp_jump = 0;
				}
			}
		}
	
		if (directionOffset == "right" || directionOffset == "left") {
			sprite_index = spr_RunAndGun_PlayerJump;
			if (xOffset = 1) {
				bulletDir = 0;
			} else {
				bulletDir = 180;
			}
		}
		if (directionOffset == "up") {
			sprite_index = spr_RunAndGun_PlayerJumpUp;
			bulletDir = 90;
		}
		if (directionOffset == "down") {
			sprite_index = spr_RunAndGun_PlayerJumpDown;
			bulletDir = 270;
		}
		if (directionOffset == "downRight" || directionOffset == "downLeft") {
			sprite_index = spr_RunAndGun_PlayerJumpDownRight;
			if (xOffset = 1) {
				bulletDir = 315;
			} else {
				bulletDir = 225;
			}
		}
		if (directionOffset == "upRight" || directionOffset == "upLeft") {
			sprite_index = spr_RunAndGun_PlayerJumpUpRight;
			if (xOffset = 1) {
				bulletDir = 45;
			} else {
				bulletDir = 135;
			}
		}
	
		if (image_index < image_number - .5) {
			image_speed = .8;
		} else {
			image_speed = 0;
		}
	
	}



	// Check if player bumps head on ceiling
	if ((actionstate == 2 || actionstate == 14) && collision_line(x - 12, y + vsp - 140, x + 12, y + vsp - 140, obj_RunAndGun_ParentOverlay, 1, 1)) {
		while (!collision_line(x - 12, y - 140, x + 12, y - 140, obj_RunAndGun_ParentOverlay, 1, 1)) {
			y -= 1;
		}
		vsp_max_height = 0;	
		actionstate = 14;
		vsp = 0;
		vsp_jump = 0;
	}
	
	// Check left and right collision with overlay
	if ((actionstate == 2 || actionstate == 14) && 
    (collision_line(x + hsp - 14, y - 20 , x + hsp - 14, y - 120, obj_RunAndGun_ParentOverlay, 1, 1) 
    || collision_line(x + hsp + 14, y - 20 , x + hsp + 14, y - 120, obj_RunAndGun_ParentOverlay, 1, 1)))
	{
	    var onepixel = sign(hsp);
    
	    while (!collision_line(x + onepixel + (onepixel * 14), y, x + onepixel + (onepixel * 14), y - 140, obj_RunAndGun_ParentOverlay, 1, 1)) {
	        x += onepixel;
	    }
    
	    hsp = 0;
	    hsp_jump = 0;
	}

	////////////////////////////////// End Step  //////////////////////////////////////////////////////////////////////////////////////////////////////////

	if (!key_jump && actionstate != 2 && actionstate != 14) {
	    jump_status = 0;
	}

	// Apply gravity
	vsp = vsp + grv;

	// Handle vertical movement
	if (vsp > 0) {
	    var onepixel = sign(vsp); // up = -1, down = 1

	    // Check if falling onto a platform
	    if ((collision_line(x-10, y + vsp, x+10, y + vsp, obj_RunAndGun_ParentPlatform, 1, 1) 
	        && !collision_line(x-10, y-1, x+10, y-1, obj_RunAndGun_ParentPlatform, 1, 1) 
	        && actionstate != 2)) {
        
	        // Move player down until exactly on the platform
	        while (!collision_line(x-10, y + onepixel, x+10, y + onepixel, obj_RunAndGun_ParentPlatform, 1, 1)) {
	            y = y + onepixel;
			}
	        vsp = 0;
		}
	}

	if (vsp != 0) {
	    var onepixel = sign(vsp);

		// Check if colliding with a wall or floor object
		if (collision_line(x - 12, y + vsp, x + 12, y + vsp, obj_RunAndGun_ParentOverlay, 1, 1)) {
			while (!collision_line(x - 12, y + onepixel, x + 12, y + onepixel, obj_RunAndGun_ParentOverlay, 1, 1)) {
				y += onepixel;
			}
			vsp = 0;
		}
	}

	// Apply vertical movement
	y = y + vsp;


	//////////////////////////// Actionstate 1 - Walking

	if (actionstate == 1) {
	    if (hsp_walk > hsp_max_walk) {
	        hsp_walk = hsp_max_walk;
	    }
	    if (hsp > hsp_max_walk) {
	        hsp = hsp_max_walk;
	    }
	    if (hsp < -hsp_max_walk) {
	        hsp = -hsp_max_walk;
	    }
	

		if (hsp != 0) {
		    var onepixel = sign(hsp);

		    // If the player is about to collide in the horizontal direction
		    if (collision_line(x + hsp - 14, y - 1, x + hsp + 14, y - 1, obj_RunAndGun_ParentOverlay, 1, 1)) {
		        // Move as close as possible without colliding
		        while (!collision_line(x + onepixel - 14, y - 1, x + onepixel + 14, y - 1, obj_RunAndGun_ParentOverlay, 1, 1)) {
		            x += onepixel;
		        }
		        hsp = 0;
		    }
		}
	}

	// Apply horizontal movement
	x += hsp;	
	
	// Ensure player doesn’t go past the left camera boundary
	if (x - 20 < camera_get_view_x(view_camera[0])) {
	    x = camera_get_view_x(view_camera[0]) + 20;
	}
	/////////////////////////// Actionstate 2 - Jumping
	
	if (collision_line(x-10, y + 1, x+10, y + 1, obj_RunAndGun_ParentPlatform, 1, 1) && !collision_line(x-10, y, x+10, y, obj_RunAndGun_ParentPlatform, 1, 1) && actionstate = 2) { 
		actionstate = 0;
		hsp_jump = 0;
		vsp_jump = 0;
	}

	/////////////////////////// Actionstate 14 - Falling
		
	if (actionstate == 14 && ((collision_line(x-10, y + 1, x+10, y + 1, obj_RunAndGun_ParentPlatform, 1, 1) && !collision_line(x-10, y - 1, x+10, y - 1, obj_RunAndGun_ParentPlatform, 1, 1))  
	|| (collision_line(x - 12, y, x + 12, y, obj_RunAndGun_ParentOverlay, 1, 1) && !collision_line(x - 12, y - 1, x + 12, y - 1, obj_RunAndGun_ParentOverlay, 1, 1)))) { 
		actionstate = 0;
		hsp_jump = 0;
		vsp_jump= 0;
	}

}




if gamepad_is_connected(global.pad) {
		//initalize

	image_speed = 1;

	haxis = gamepad_axis_value(global.pad, gp_axislh);
	vaxis = gamepad_axis_value(global.pad, gp_axislv);



	if (haxis <= .2 && haxis >= -.2 && vaxis <= .2 && vaxis >= -.2)  {
		if (sprite_index = spr_RunAndGun_PlayerStill)  {
			if (xOffset = 1) {
				directionOffset = "right";
			} else if (xOffset = -1) {
				directionOffset = "left";
			}
		
		}
	}

	if (haxis >= .85 && vaxis <= .4 && vaxis >= -.4) {
		directionOffset = "right";
		xOffset = 1;
	} else if (haxis > .4 && haxis < .85 && vaxis < -.3 && vaxis > -.75) {
		directionOffset = "upRight";
		xOffset = 1;
	} else if (vaxis <= -.75 && haxis <= .4 && haxis >= -.4) {
		directionOffset = "up";
		yOffset = 1;
	} else if (haxis < -.4 && haxis > -.85 && vaxis < -.3 && vaxis > -.75) {
		directionOffset = "upLeft";
		xOffset = -1;
	} else if (haxis <= -.85 && vaxis <= .4 && vaxis >= -.4) {
		directionOffset = "left";
		xOffset = -1;
	} else if (haxis < -.4 && haxis > -.85 && vaxis > .3 && vaxis < .75) {
		directionOffset = "downLeft";
		xOffset = -1;
	} else if (vaxis >= .75 && haxis <= .4 && haxis >= -.4) {
		directionOffset = "down";
		yOffset = -1;
	} else if (haxis > .4 && haxis < .85 && vaxis > .3 && vaxis < .75) {
		directionOffset = "downRight";
		xOffset = 1;
	}
	if (vaxis < .85 && vaxis > -.85) {
		yOffset = 0;
	}

	////////////////////////////////// Actionstate 0 - Still

	if (haxis > -.2 && haxis < .2) && actionstate != 2 && actionstate != 14 {
		speed = 0;
		actionstate = 0;
		}

	if (actionstate = 0) {
		sprite_index = spr_RunAndGun_PlayerStill;
		if (xOffset = 1) {
			bulletDir = 0;
		} else {
			bulletDir = 180;
		}
		if (yOffset = 1) {
			sprite_index = spr_RunAndGun_PlayerStillUp; //up sprite
			bulletDir = 90;
		} else if (yOffset = -1) {
			sprite_index = spr_RunAndGun_PlayerStillProne; //prone sprite
			speed = 0;
		}
	}



	////////////////////////////////// Actionstate 1 - Walking

	if ((haxis < -.2 || haxis > .2) && actionstate < 2) {
		actionstate = 1;
	}

	if actionstate = 1 {
	
		//move horizontally
		direction = point_direction(0, 0, haxis, 0);
		speed = point_distance(0 ,0, haxis, 0) * 7;
	

	
		if (directionOffset = "right" || directionOffset = "left") {
			sprite_index = spr_RunAndGun_PlayerRun;
			if (xOffset = 1) {
				bulletDir = 0;
			} else {
				bulletDir = 180;
			}
		}
		if (directionOffset = "up") {
			sprite_index = spr_RunAndGun_PlayerRunUp;
			bulletDir = 90;
		}
		if (directionOffset = "downRight" || directionOffset = "downLeft") {
			sprite_index = spr_RunAndGun_PlayerRunDownRight;
			if (xOffset = 1) {
				bulletDir = 315;
			} else {
				bulletDir = 225;
			}
		}
		if (directionOffset = "upRight" || directionOffset = "upLeft") {
			sprite_index = spr_RunAndGun_PlayerRunUpRight;
			if (xOffset = 1) {
				bulletDir = 45;
			} else {
				bulletDir = 135;
			}
		}
	
	}



	////////////////////////////////// Actionstate 2 - Jumping

	
	if (gamepad_button_check_released(global.pad,gp_face1) || (actionstate == 2 || actionstate == 14)) && jump_status == 1 {
		jump_status = 2;
	}
		
	
	if gamepad_button_check_pressed(global.pad,gp_face1) && actionstate != 2 && actionstate != 14 && actionstate != 3 {
		jump_status = 1;
	}
	
	//collision check
	if ((collision_line(x-10, y + 1, x+10, y + 1, obj_RunAndGun_ParentPlatform, 1, 1) && (directionOffset != "down") && gamepad_button_check(global.pad,gp_face1) && jump_status < 2)) { 
	
	actionstate = 2;
	}
	
	
	
	if (actionstate = 2) {	
		vsp_max_height -= 2;
	
		//move vertically	
		if (gamepad_button_check(global.pad,gp_face1)) && (vsp_jump > vsp_max_jump) {
			vsp_jump = vsp_max_jump;
		}
		
		vsp = vsp_jump;
	
		if vsp_jump < vsp_max_jump {
			vsp_jump = vsp_max_jump;
		}
			
		//move horizontally
		if key_right && (abs(hsp_jump) < hsp_max_jump) {
			direction = 0;
		}
		if key_left && (abs(hsp_jump) < hsp_max_jump) {
			direction = 180;
		}
		speed = point_distance(0 ,0, haxis, 0) * 10;
	
	
		if (directionOffset = "right" || directionOffset = "left") {
			sprite_index = spr_RunAndGun_PlayerJump;
			if (xOffset = 1) {
				bulletDir = 0;
			} else {
				bulletDir = 180;
			}
		}
		if (directionOffset = "up") {
			sprite_index = spr_RunAndGun_PlayerJumpUp;
			bulletDir = 90;
		}
		if (directionOffset = "down") {
			sprite_index = spr_RunAndGun_PlayerJumpDown;
			bulletDir = 270;
		}
		if (directionOffset = "downRight" || directionOffset = "downLeft") {
			sprite_index = spr_RunAndGun_PlayerJumpDownRight;
			if (xOffset = 1) {
				bulletDir = 315;
			} else {
				bulletDir = 225;
			}
		}
		if (directionOffset = "upRight" || directionOffset = "upLeft") {
			sprite_index = spr_RunAndGun_PlayerJumpUpRight;
			if (xOffset = 1) {
				bulletDir = 45;
			} else {
				bulletDir = 135;
			}
		}
	
		if image_index <= 2 {
			image_speed = .8;
		} else {
			image_speed = 0;
		}
		if (image_index >= 3) {
			image_index = 1;
		}
	}

	////////////////////////////////// Actionstate 3 - Shoot


	if gamepad_button_check_pressed(global.pad,gp_face3) {
	
		instance_create_layer(x,y,"Instances",obj_RunAndGun_playerBullet1, {
			speed:20,
			direction:bulletDir,
			spriteDir:xOffset
		});
	}

	if gamepad_button_check(global.pad,gp_face3) {
		bulletTimer += 1;
		if bulletTimer >= 15 {

			instance_create_layer(x,y,"Instances",obj_RunAndGun_playerBullet1, {
				speed:20,
				direction:bulletDir,
				spriteDir:xOffset
			});
			bulletTimer = 0;
		}
	}

	if gamepad_button_check_released(global.pad,gp_face3) {
		bulletTimer = 0;
	}


	////////////////////////////////// Actionstate 14 - Falling

	if (actionstate = 0 && vaxis >= .75 && gamepad_button_check(global.pad,gp_face1)) {
		y += 1;
	}

	if ((actionstate = 2 && !gamepad_button_check(global.pad,gp_face1)) || (vsp_max_height < vsp_max_jump) || (actionstate < 2 && !collision_line(x-10, y + 1, x+10, y + 1, obj_RunAndGun_ParentPlatform, 1, 1))) {
		vsp_max_height = 0;	
		actionstate = 14;
	}
	

	if actionstate == 14 {
	
		if haxis > 0 && (abs(hsp_jump) < hsp_max_jump) {
			direction = 0;
		}
		if haxis < 0 && (abs(hsp_jump) < hsp_max_jump) {
			direction = 180;
		}
		speed = point_distance(0 ,0, haxis, 0) * 10;
		
		if vsp > 24
			{vsp = 24;}
	
	
		if (directionOffset = "right" || directionOffset = "left") {
			sprite_index = spr_RunAndGun_PlayerJump;
			if (xOffset = 1) {
				bulletDir = 0;
			} else {
				bulletDir = 180;
			}
		}
		if (directionOffset = "up") {
			sprite_index = spr_RunAndGun_PlayerJumpUp;
			bulletDir = 90;
		}
		if (directionOffset = "down") {
			sprite_index = spr_RunAndGun_PlayerJumpDown;
			bulletDir = 270;
		}
		if (directionOffset = "downRight" || directionOffset = "downLeft") {
			sprite_index = spr_RunAndGun_PlayerJumpDownRight;
			if (xOffset = 1) {
				bulletDir = 315;
			} else {
				bulletDir = 225;
			}
		}
		if (directionOffset = "upRight" || directionOffset = "upLeft") {
			sprite_index = spr_RunAndGun_PlayerJumpUpRight;
			if (xOffset = 1) {
				bulletDir = 45;
			} else {
				bulletDir = 135;
			}
		}
	
		if (image_index < image_number - .5) {
			image_speed = .8;
		} else {
			image_speed = 0;
		}
	
	}



	////////////////////////////////// End Step  //////////////////////////////////////////////////////////////////////////////////////////////////////////

	if (!gamepad_button_check(global.pad,gp_face1) && actionstate != 2 && actionstate != 14) {
		jump_status = 0;
	}

	vsp = vsp + grv;
	if (vsp > 0) {
		var onepixel = sign(vsp) //up = -1, down = 1.
		if (collision_line(x-10, y + vsp, x+10, y + vsp, obj_RunAndGun_ParentPlatform, 1, 1) && !collision_line(x-10, y-1, x+10, y-1, obj_RunAndGun_ParentPlatform, 1, 1) && (actionstate != 2)) {
			while (!collision_line(x-10, y + onepixel, x+10, y + onepixel, obj_RunAndGun_ParentPlatform, 1, 1)) {
				y = y + onepixel;
			}
			vsp = 0;
		}
	}

	if x - 20 < camera_get_view_x(view_camera[0]) {
		x = camera_get_view_x(view_camera[0]) + 20;
	}


	y = y + vsp;
	/////////////////////////// Actionstate 1 - Walking
	if (sprite_index = spr_RunAndGun_PlayerStillProne) {
		speed = 0;
	}
	
	
	/////////////////////////// Actionstate 2 - Jumping
	
	if (collision_line(x-10, y + 1, x+10, y + 1, obj_RunAndGun_ParentPlatform, 1, 1) && !collision_line(x-10, y, x+10, y, obj_RunAndGun_ParentPlatform, 1, 1) && actionstate == 2) { 
		actionstate = 0;
		hsp_jump = 0;
		vsp_jump = 0;
	}

	/////////////////////////// Actionstate 14 - Falling
		
	if (collision_line(x-10, y + 1, x+10, y + 1, obj_RunAndGun_ParentPlatform, 1, 1) && !collision_line(x-10, y, x+10, y, obj_RunAndGun_ParentPlatform, 1, 1) && actionstate == 14) { 
		actionstate = 0;
		hsp_jump = 0;
		vsp_jump= 0;
	}
	
	
	
}


//debug
if (y > camera_get_view_height(view_camera[0])) {
	y = 200;
}

x = round(x / 4) * 4;
y = round(y / 4) * 4;


} else if (obj_camera.cutscene == true) {
sprite_index = spr_RunAndGun_PlayerStill;
}