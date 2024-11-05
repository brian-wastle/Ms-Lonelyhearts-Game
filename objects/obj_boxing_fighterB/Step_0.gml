
var enemyX = obj_boxing_fighterA.x;
xOffset = abs(enemyX - x) > 150 ? sign(enemyX - x) : 0;
sprite_index = spriteArray[xOffset + 1];

if (!gamepad_is_connected(global.pad)) {
    keyLeft = keyboard_check(ord("A"));
    keyRight = keyboard_check(ord("D"));
	keySpace = keyboard_check_pressed(vk_space);

    var accel = 0.4;
    var decel = 0.3;

// Handle left/right movement
    if (keyLeft && !keyRight) {
        speed = max(speed - accel, -maxSpeed);
    }  else if (keyRight && !keyLeft) {
        speed = min(speed + accel, maxSpeed);
    } else {
        if (speed > 0) speed = max(speed - decel, 0);
        else if (speed < 0) speed = min(speed + decel, 0);
    }
}

//Handle background scrolling
var playerNearLeftEdge = (x <= roomLeftBound && speed < 0);
var playerNearRightEdge = (x >= roomRightBound && speed > 0);

if (playerNearLeftEdge || playerNearRightEdge) {
	var initialSign = sign(-speed);
	backgroundSpeed = -speed; 
	targetSpeed = abs(targetSpeed);
	var currentSpeed = min((targetSpeed * 1.05) + (targetSpeed + .01), maxScrollRate - maxSpeed)
	targetSpeed = currentSpeed * initialSign;
	layer_hspeed(layerId,backgroundSpeed + targetSpeed);
} else {
	x += speed;
    backgroundSpeed = abs(backgroundSpeed) > .25 ? backgroundSpeed * .85 : 0;
	targetSpeed = abs(targetSpeed) > .25 ? targetSpeed * .96 : 0;	
	layer_hspeed(layerId, backgroundSpeed = 0 ? -targetSpeed : backgroundSpeed + targetSpeed);
}

// Sliding back to the center if not moving away
if (abs(x - centerX) > 250 && !(speed < 0 && x > centerX) && !(speed > 0 && x < centerX)) {
    // Slide towards center
    var slideSpeed = 0.01;
    x = lerp(x, centerX, slideSpeed);
}

x = clamp(x, roomLeftBound, roomRightBound);