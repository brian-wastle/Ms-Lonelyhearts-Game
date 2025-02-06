// Set location
x = parentId.x;
y = parentId.y;
directionOffset = parentId.directionOffset;
sideIndex = (-directionOffset + 1) / 2;

// Create hit effect
var enemy = instance_place(x, y, obj_beatEmUp_enemy);
if (enemy != noone && hitflagState == 0) {
	var playerZsp = obj_beatEmUp_player.zsp;
	if (playerZsp >= enemy.zsp && abs(playerZsp - enemy.zsp) <= 120) || 
	(playerZsp < enemy.zsp && (abs(playerZsp - enemy.zsp) < 180)) {
	    with (enemy) {
	        if (enemyState != 13) { // Enemy is not already dead
				// Spawn the hit effect
				instance_create_layer(other.x, other.y, "Instances", obj_beatEmUp_hitEffect, {
		            char: other.playerChar,
		            currentIndex: other.currentIndex
		        });
	        }
	    }
	    hitflagState = hitflag; // Prevent duplicates
	}
}
// Set Sprites
if (parentId.actionstate == 3) {
    sprite_index = charArray[1, playerChar][sideIndex];
    image_index = parentId.image_index;
} else if (parentId.actionstate == 11) {
	sprite_index = charArray[3, playerChar][sideIndex];
    image_index = parentId.image_index;
} else if ((parentId.actionstate == 2 || parentId.actionstate == 14) && parentId.airAttackState == 1) {
    sprite_index = charArray[2, playerChar][sideIndex];
    image_index = parentId.image_index;
} else {
    sprite_index = charArray[0, playerChar];
    image_index = 0;
}

// Handle hitflag state
if ((parentId.actionstate == 3 || parentId.airAttackState == 1) && image_index != currentIndex) {
    hitflag *= -1;
    if (hitflagState != hitflag) {
        hitflagState = 0;
    }
}

// Update currentIndex
currentIndex = image_index;
