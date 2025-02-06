draw_sprite_ext(spr_BeatEmUp_PlayerShadow,playerChar,x,y,shadowSize,shadowSize,0,c_white,.3);
draw_sprite_ext(sprite_index,image_index,x,y - zsp,directionOffset,1,0,c_white,1);

draw_text(x - 100, y - 400, string_concat("Actionstate: ", actionstate));
draw_text(x - 100, y - 350, string_concat("damageTimer: ", damageTimer));
draw_text(x - 100, y - 450, string_concat("grabAnim: ", grabAnim));
draw_text(x - 100, y - 480, string_concat("freezeTimer: ", freezeTimer));
//draw_text(x - 100, y - 320, string_concat("useGamepad: ", useGamepad));
