depth					= -700;
image_speed				= 0;
stateTimer[0]			= 0;
var tempVal = irandom_range(-5,5);
instDir = sign(tempVal);
y = y + ( tempVal * 4);
currentIndex			= 4 * irandom_range(0,2);
initialIndex			= currentIndex;
var dir					= irandom_range(0,1);
facing					= (-1 + (2 * dir));				// returns -1 or 1;