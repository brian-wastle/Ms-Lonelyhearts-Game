sideIndex = 0;
// Player hitbox arrays
directionOffset = 1;
charArray[0,0] = spr_BeatEmUp_PlayerGirlIdle_hb;
charArray[0,1] = spr_BeatEmUp_PlayerGirlIdle_hb;
charArray[0,2] = spr_BeatEmUp_PlayerGirlIdle_hb;
charArray[1,0] = [spr_BeatEmUp_PlayerGirlCombo_hb, spr_BeatEmUp_PlayerGirlCombo_hb2];
charArray[1,1] = [spr_BeatEmUp_PlayerBoyCombo];
charArray[1,2] = [spr_BeatEmUp_PlayerRobotCombo];
charArray[2,0] = [spr_BeatEmUp_PlayerGirlAirAttack_hb, spr_BeatEmUp_PlayerGirlAirAttack_hb2];
charArray[2,1] = [spr_BeatEmUp_PlayerBoyAirAttack];
charArray[2,2] = [spr_BeatEmUp_PlayerRobotAirAttack];
charArray[3,0] = [spr_BeatEmUp_PlayerGirlBackAttack_hb, spr_BeatEmUp_PlayerGirlBackAttack_hb2];
charArray[3,1] = [-1];
charArray[3,2] = [-1];
image_speed = 0;

hitflag = 1;		// Triggers changes in hitflag state
hitflagState = 0;	// Hitflag state
currentIndex = 0;	// Keeps track of current image index for hitflag control
