
////DEBUG

// Set location
x = parentId.x;
y = parentId.y;
directionOffset = parentId.directionOffset;
sideIndex = (-directionOffset + 1) / 2;
// Set Sprites
if (parentId.actionstate = 3) {
	sprite_index = charArray[1, playerChar][sideIndex];
	image_index = parentId.image_index;
} else if ((parentId.actionstate == 2 || parentId.actionstate == 14) && parentId.airAttackState == 1) {
	sprite_index = charArray[2, playerChar][sideIndex];
	image_index = parentId.image_index;
} else {
	sprite_index = charArray[0, playerChar];
	image_index = 0;
}