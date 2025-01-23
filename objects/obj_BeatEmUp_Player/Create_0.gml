
actionstate = 0;
directionOffset = 1; //sprite is facing left or right
spriteSpeed = 0; // negative when sprite is walking backwards
depth = -300;
playerChar = 0; //0 - girl, 1 - boy, 2 - robot

grv = 1.1; //gravity
hsp = 0; //current horizontal speed
vsp = 0; //current vertical speed
zsp = 0; //current jump speed
hspWalk = 0; //walk speed
vspWalk = 0;
hspJump = 0; //jump horizontal speed
vspJump = 0; //jump vertical speed
zspJump = 0; // jump height speed
hspMaxWalk = 4; //walk speed
vspMaxWalk = 2;
hspMaxJump = 8; //jump horizontal max speed
vspMaxJump = 3; //jump vertical max speed
zspMaxJump = 19;
jumpStatus = 0; //prevents character from jumping immediately on landing
landingTimer = 0; // keeps player in landing position for a moment after falling 
shadowSize = 0;
airAttackState = 0; //whether jumping player is attacking, resets to 0 on landing.

// Attacks

attackQueue = 0; // keeps track of how many attacks to use in a combo
airAttackState = 0; // whether the player is doing an air attack or not
comboTimer = 0;

key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
key_up = keyboard_check(ord("W"));
key_down = keyboard_check(ord("S"));
key_jump = keyboard_check(vk_space);
key_block = keyboard_check_pressed(vk_shift);
key_attack = mouse_check_button_pressed(mb_left);
key_super = mouse_check_button_pressed(mb_right);

// Player sprite arrays

charArray[0,0] = spr_BeatEmUp_PlayerGirlIdle;
charArray[0,1] = spr_BeatEmUp_PlayerBoyIdle;
charArray[0,2] = spr_BeatEmUp_PlayerRobotIdle;
charArray[1,0] = spr_BeatEmUp_PlayerGirlWalk;
charArray[1,1] = spr_BeatEmUp_PlayerBoyWalk;
charArray[1,2] = spr_BeatEmUp_PlayerRobotWalk;
charArray[2,0] = spr_BeatEmUp_PlayerGirlCombo;
charArray[2,1] = spr_BeatEmUp_PlayerBoyCombo;
charArray[2,2] = spr_BeatEmUp_PlayerRobotCombo;
charArray[3,0] = spr_BeatEmUp_PlayerGirlAirAttack;
charArray[3,1] = spr_BeatEmUp_PlayerBoyAirAttack;
charArray[3,2] = spr_BeatEmUp_PlayerRobotAirAttack;


// Gamepad

haxis = 0;
vaxis = 0;


// Initialize attack hitboxes

instance_create_layer(x,y,"Instances", obj_BeatEmUp_Player_hb, {
	parentId: id
});