lerpTimer += 1;

if (moveDir == 1) {
	speed = -1 * lerp(minSpeed, targetSpeed, lerpTimer / lerpDuration);
} else {
	speed = -1 * lerp(targetSpeed, minSpeed, lerpTimer / lerpDuration);
}

if (lerpTimer >= lerpDuration) {
    lerpTimer = 0;
    moveDir *= -1;
}

if (x < 3380) {
    instance_destroy();
}