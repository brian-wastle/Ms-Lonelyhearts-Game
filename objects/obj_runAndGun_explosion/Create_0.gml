depth = -560;
image_speed = 0;
stateTimer[0] = 0;

spriteArray = [
	spr_runAndGun_explosion1,
	spr_runAndGun_explosion2,
	spr_runAndGun_explosion3
];
hitboxArray = [
	spr_runAndGun_explosion1hb,
	spr_runAndGun_explosion2hb,
	spr_runAndGun_explosion3hb,
	spr_runAndGun_explosion1hb2,
	spr_runAndGun_explosion2hb2,
	spr_runAndGun_explosion3hb2
];

var thisIndex = irandom_range(0,2);
sprite_index = spriteArray[thisIndex];
currentIndex = 0;
var randomNum = irandom_range(0,1);
xScale = (randomNum * -2) + 1;			// -1 or 1 xScale for facing dir
var hbIndex = thisIndex + (randomNum * 3);	// Select proper mask based on xScale/sprite
mask_index = hitboxArray[hbIndex];