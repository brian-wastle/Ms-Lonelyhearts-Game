depth = -y;
dirOffset = (sign(obj_BeatEmUp_Player.x - x) != 0) ? sign(obj_BeatEmUp_Player.x - x) : dirOffset;
shakeOffset = 0;

// Appear on screen
if (enemyState == 100) {
	if (path_index == -1) {
		if (mp_potential_path_object(movePath, xGoal, yGoal, 4, 4, obj_beatEmUp_objectCollisionParent)) {
		    path_start(movePath, 4, 0, 0);
		}
	}
	if (path_position > .99) {
	    path_end();
		enemyState = 0;
	}
} else {
	xGoal = obj_BeatEmUp_Player.x;
	yGoal = obj_BeatEmUp_Player.y;
}

// Damage Triggers
if (place_meeting(x, y, obj_BeatEmUp_Player_hb) && iFrameTimer <= 0) {
    path_end();
	pathTimer = 0;
	enemyState = 6;
	if (enemyState == 6) {
	    attackStack += 1;
		freezeTimer = 40;
	} else {
		freezeTimer = 30;
	}
	iFrameTimer = 9;
	
}

// Idle
if (enemyState == 0) {
	image_speed = 1;
    sprite_index = spriteArray[charIndex][0];
	if (enemyState != previousState) {
	    image_index += irandom_range(2,4);
	}
	if (freezeTimer > 0) {
	    freezeTimer -= 1;
	} else {
	    enemyState = 1;
	}
	
}

// Chase
if (enemyState == 1) {
	image_speed = 1;
		if (path_index == -1) {
		// Find the initial path
		direction = point_direction(x,y,xGoal,yGoal);
		if (mp_potential_path_object(movePath, xGoal, yGoal, 12, 4, obj_beatEmUp_objectCollisionParent)) {
			sprite_index = spriteArray[charIndex][1];
		    path_start(movePath, 4, 0, 0);
		}
	} else {
		// Update the path every 20 steps
		pathTimer += 1;
		if (pathTimer >= 20) {
			direction = point_direction(x,y,xGoal,yGoal);
			pathTimer = 0;
			// End the current path
			if (path_index != -1) {
				path_end();
			}
			// Begin Path
		    if (mp_potential_path_object(movePath, xGoal, yGoal, 12, 4, obj_beatEmUp_objectCollisionParent)) {
				sprite_index = spriteArray[charIndex][1];
			    path_start(movePath, 4, 0, 0);
			}
		}
		// Check to see if enemy is near player and activate next enemyState
		xProximity = abs(x - xGoal) < 500  ? 1 : 0;
		yProximity = abs(y - yGoal) < 75 ? 1 : 0;
		if (xProximity && yProximity) {
			path_end();
			sprite_index = spriteArray[charIndex][0];
			pathTimer = 0;
			enemyState = 2;
		}
	}
}

// Walk up medium range
if (enemyState == 2) {
	image_speed = 1;
	var xDistance = dirOffset * 200;
	if (path_index == -1) {
		// Find the initial path
		if (mp_potential_path_object(movePath, xGoal - xDistance, yGoal, 3, 4, obj_beatEmUp_enemyParent)) {
			sprite_index = spriteArray[charIndex][1];
		    path_start(movePath, 3, 0, 0);
		} else if (mp_potential_path_object(movePath, xGoal + xDistance, yGoal, 3, 4, obj_beatEmUp_enemyParent)) {
			sprite_index = spriteArray[charIndex][1];
		    path_start(movePath, 3, 0, 0);
		}
	} else if (path_index != -1) {
		// Update the path every 20 steps
		pathTimer += 1;
		if (pathTimer >= 150) {
			pathTimer = 0;
			// End the current path
			if (path_index != -1) {
				path_end();
			}
			// Find the target
			xDistance = dirOffset * 200;
			// Begin Path
		    if (mp_potential_path_object(movePath, xGoal - xDistance, yGoal, 3, 4, obj_beatEmUp_objectCollisionParent)) {
				sprite_index = spriteArray[charIndex][1];
			    path_start(movePath, 3, 0, 0);
			}
		}
		// Check to see if enemy is near player and activate next enemyState
		xProximity = (abs(x - xGoal) < 350 && abs(x - xGoal) > 120)  ? 1 : 0;
		yProximity = abs(y - yGoal) < 70 ? 1 : 0;
		if (xProximity && yProximity) {
			path_end();
			sprite_index = spriteArray[charIndex][0];
			pathTimer = 0;
			if (obj_BeatEmUp_Player.actionstate < 2) {
			    enemyState = 3;
			}
		}
	}
}

// Line up vertically outside
if (enemyState == 3) {
	image_speed = 1;
	var distX = path_get_x(movePath, 1);
	var distY = path_get_y(movePath, 1);
	var pathDist = point_distance(xGoal, yGoal, distX, distY);
	var playerDist = point_distance(x, y, xGoal, yGoal);
	if (playerDist > pathDist && playerDist > 170) {
		var playerDir = point_direction(x, y, xGoal, yGoal);
	    direction = playerDir;
	} else {
		path_end();
	}
	if (abs(x - xGoal) > 350) {
		path_end();
		pathTimer = 0;
		sprite_index = spriteArray[charIndex][0];
		enemyState = 2;
	}
	
	if (path_index == -1) {
		// Find the target
		var xDistance = dirOffset * irandom_range(200,300);
		// Find the initial path
		if (mp_potential_path_object(movePath, xGoal - xDistance, yGoal, 3, 3, obj_beatEmUp_objectCollisionParent)) {
			sprite_index = spriteArray[charIndex][1];
			path_start(movePath, 2, 0, 0);
		}
	} else {
		pathTimer += 1;
		if (pathTimer > 20) {
			pathTimer = 0;
			var xDistance = dirOffset * irandom_range(200,300);
			// Update path periodically
			if (mp_potential_path_object(movePath, xGoal - xDistance, yGoal, 3, 3, obj_beatEmUp_objectCollisionParent)) {
				sprite_index = spriteArray[charIndex][1];
				path_start(movePath, 2, 0, 0);
			}
		}
		if (path_position > .95) {
			path_end();
			enemyState = 4;
		}
	}
}

//Close-in for attack
if (enemyState == 4) {
	image_speed = 1;
	var distX = path_get_x(movePath, 1);
	var distY = path_get_y(movePath, 1);
	var pathDist = point_distance(xGoal, yGoal, distX, distY);
	var playerDist = point_distance(x, y, xGoal, yGoal);
	if (playerDist > pathDist && playerDist > 170) {
		var playerDir = point_direction(x, y, xGoal, yGoal);
	    direction = playerDir;
	}
	var xDistance = dirOffset * 150;
	if (path_index == -1 && obj_BeatEmUp_Player.actionstate < 2) {
		// Find the initial path
		if (mp_potential_path_object(movePath, xGoal - xDistance, yGoal, 3, 8, obj_beatEmUp_objectCollisionParent)) {
			sprite_index = spriteArray[charIndex][1];
		    path_start(movePath, 2, 0, 0);
		}
	} else if (path_index != -1) {
		pathTimer += 1;
		if (pathTimer > 20) {
			pathTimer = 0;
			// Update path periodically
			if (mp_potential_path_object(movePath, xGoal - xDistance, yGoal, 3, 8, obj_beatEmUp_objectCollisionParent)) {
				sprite_index = spriteArray[charIndex][1];
				path_start(movePath, 2, 0, 0);
			}
		}
		
		xProximity = (abs(x - xGoal) < 170 && abs(x - xGoal) > 8)  ? 1 : 0;
		yProximity = abs(y - yGoal) < 8 ? 1 : 0;
		if (xProximity && yProximity) {
			path_end();
			sprite_index = spriteArray[charIndex][0];
			pathTimer = 0;
			enemyState = 5;
		}
	} else {
		sprite_index = spriteArray[charIndex][0];
	}
}

// Attack

if (enemyState == 5) {
    
}

// Take Damage
if (enemyState == 6) {
	image_speed = 0;
	shakeOffset = 4;
	shakeDir *= -1; 	
    sprite_index = spriteArray[charIndex][2];
	image_index = 0;
	if (freezeTimer > 0) {
	    freezeTimer -= 1;
		shakeOffset *= shakeDir;
	} else {
		attackStack = 0;
		freezeTimer = 30;
		enemyState = 0;
	}
	if (iFrameTimer > 0) {
	    iFrameTimer -= 1;
	}
	
	// Attack Stack
	if (attackStack = 3) {
	    image_index = 1;
	} else if (attackStack > 4) {
		enemyState = 7;
		image_index = 0;
	}
}

if (iFrameTimer > 0 && enemyState != 6) {
    iFrameTimer = 0;
}

// KO'd

if (enemyState == 7) {
    sprite_index = spriteArray[charIndex][2];
	image_speed = 0;
	var timerLimit = 4;
	comboTimer += 1;
		
	if (image_index > 5 && image_index < 9) {
		timerLimit = 2;
	} 
		
	if (image_index > 10 && image_index < 15) {
		timerLimit = 2;
	}
		
	if (image_index > 16 && image_index < 21) {
		timerLimit = 2;
	}
		
	switch (image_index) {
		case 9:
		case 15:
		case 22:
			timerLimit = 8;
			break;
	}
			
	if (comboTimer == timerLimit) {
		comboTimer = 0;
		image_index += 1;
	}


	// Variables
	if (!knockbackState) {
	    initialX = x; // Current x position
	    finalX = initialX + (knockbackDistance * -dirOffset);
	    knockbackProgress = 0;
	    knockbackState = 1;
	}

	// Update progress
	knockbackProgress += knockbackSpeed;

	if (knockbackProgress > 1) knockbackProgress = 1;

	// Calculate positions
	var xCurrent = initialX + knockbackProgress * (finalX - initialX);
	var zCurrent = zMaxKO * (1 - sqr((2 * knockbackProgress) - 1));

	// Update position
	x = xCurrent;
	zsp = zCurrent;

	if (knockbackProgress == 1) {
	    enemyState = 0;
	    knockbackState = 0;
		attackStack = 0;
	}
}

// Wait when player is stacked with enemies
if (enemyState == 8) {
    image_speed = 1;
	// Ellipse Parameters
	var b = 80; // Semi-minor axis (height)
	var a = 4.5 * b; // Semi-major axis (width)
	var ellipseIncrement = 10; // Degrees to sweep each step

	if (!foundPosition) {
		if (path_index != 1) {
		    path_end();
		}
	    var angleStart = point_direction(xGoal, yGoal, x, y);
		for (var i = 0; i <= 180; i += ellipseIncrement) {
		    // Check clockwise
		    var sweepAngleCW = degtorad(angleStart + i);
		    targetX = xGoal + a * cos(sweepAngleCW);
		    targetY = yGoal + b * sin(sweepAngleCW);

		    if (place_free(targetX, targetY)) {
		        foundPosition = 1;
		        break;
		    }

		    // Check counterclockwise
		    var sweepAngleCCW = degtorad(angleStart - i);
		    targetX = xGoal + a * cos(sweepAngleCCW);
		    targetY = yGoal + b * sin(sweepAngleCCW);

		    if (place_free(targetX, targetY)) {
		        foundPosition = 1;
		        break;
		    }
		}
	} 
	
	if (foundPosition) {
	    if (path_index == -1 && obj_BeatEmUp_Player.actionstate < 2) {
			// Find the initial path
			if (mp_potential_path_object(movePath, targetX, targetY, 3, 8, obj_beatEmUp_collisionParent)) {
				sprite_index = spriteArray[charIndex][1];
			    path_start(movePath, 2, 0, 0);
			}
		} else if (path_index != -1) {
			pathTimer += 1;
			if (pathTimer > 20) {
				pathTimer = 0;
				foundPosition = 0;
			}
		} else {
			enemyState = 0;
			foundPosition = 0;
			freezeTimer = 60;
			sprite_index = spriteArray[charIndex][0];
		}
	}

	if (path_position > .98) {
		path_end();
	    enemyState = 0;
		freezeTimer = 240;
		foundPosition = 0;
	}
	
}



// Handle enemy re-routing
if (enemyState > 0 && enemyState < 5) {
    var enemyOverlapLeft = place_meeting(xGoal - 150, yGoal, obj_beatEmUp_enemyParent);
	var enemyOverlapRight = place_meeting(xGoal + 150, yGoal, obj_beatEmUp_enemyParent);
    var enemyOverlapCenter = place_meeting(x, y, obj_beatEmUp_enemyParent);

	if (obj_BeatEmUp_Player.actionstate < 2 && 
	(enemyOverlapLeft && enemyOverlapRight)) {
	    path_end();
		pathTimer = 0;	
		enemyState = 8;
	}
	
	if (enemyOverlapCenter) {
        var overlapID = instance_place(x, y, obj_beatEmUp_enemyParent);
        var playerDir = point_direction(x, y, xGoal, yGoal); // Angle between player and current enemy
        var detourDir = point_direction(x, y, overlapID.x, overlapID.y); // Angle to overlapping enemy
		
		var selfDistance = point_distance(x, x, xGoal, yGoal);
		var otherDistance = point_distance(overlapID.x, overlapID.y, xGoal, yGoal);
		if (otherDistance < selfDistance) {
		    path_end();
			pathTimer = 0;
			enemyState = 0;
			freezeTimer = 60;
		}
    }
}

// Shadow Size
shadowSize = 1 * (1-(zsp / 231.25));
	if (shadowSize < .5) {
		shadowSize = .5;
	}
	
previousState = enemyState;