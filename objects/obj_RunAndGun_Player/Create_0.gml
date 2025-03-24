
mask_index = spr_RunAndGun_PlayerHitbox;
actionstate = 0;
directionOffset = 0;
xOffset = 1;
yOffset = 0;
depth = -300;

grv = 1.1; //gravity
hsp = 0; //current horizontal speed
vsp = 0; //current vertical speed
hsp_walk = 0; //walk speed
hsp_jump = 0; //jump horizontal speed
vsp_jump = 0; //jump vertical speed
hsp_max_walk = 9; //walk speed
hsp_max_jump = 9; //jump horizontal max speed
vsp_max_jump = -19; //jump vertical max speed
vsp_max_height = 0; //counter to keep track of char's height during jump
jump_status = 0; //prevents character from jumping immediately on landing

bulletTimer = 0; //allows bullets to continuously fire
bulletDir = 0;


key_right = keyboard_check(ord("D"));
key_left = keyboard_check(ord("A"));
key_up = keyboard_check(ord("W"));
key_fall = keyboard_check(ord("S"));
key_jump = keyboard_check(vk_space);
key_slide = keyboard_check_pressed(vk_shift);
key_hook = mouse_check_button_pressed(mb_right);



//gamepad
haxis = 0;
vaxis = 0;