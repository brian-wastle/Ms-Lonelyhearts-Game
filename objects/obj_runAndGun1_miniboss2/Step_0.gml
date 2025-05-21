// Enemy States
// -1		- Initialization state
// 0		- Idle state
// 1		- Attack
//// 0			- Dash
//// 1			- Jump
//// 2			- Tornado
//// 3			- Shoot
// 2		- Damage

if (enemyState == -2) {
    if (obj_RunAndGun_Player.x > 12200) {
		enemyState = -1;
	}
	with (obj_runAndGun_camera) {
		scrCameraFollow(obj_runAndGun1_control);
	}
}
//// DELETE EVERYTHING ABOVE THIS LINE BEFORE PRODUCTION ////

// Tie instance to bull instance
if (bullInst == noone && instance_exists(obj_runAndGun1_ragingBull)) {
    bullInst = obj_runAndGun1_ragingBull.id;
}

// Initialize idle sprite
if (enemyState == -1) {
	if (stateTimer[0] < 5) {
	    stateTimer[0] += 1;
	} else if (currentIndex < image_number - 1) {
		stateTimer[0] = 0;
		currentIndex += 1;
	} else {
		stateTimer[0] = 0;
		enemyState = 0;
		redHerring = irandom_range(0,9);
		if (redHerring < 7) {
		    currentDir *= -1;
		}
		sprite_index = charArray.idle[1];
	}
}

// Idle State
if (enemyState == 0) {
	// set sprites
	if (sprite_index != spr_runAndGun1_minibossABC && sprite_index != spr_runAndGun1_minibossCBA &&
	sprite_index != spr_runAndGun1_minibossAtoIdle && sprite_index != spr_runAndGun1_minibossBtoIdle && sprite_index != spr_runAndGun1_minibossCtoIdle) {
	    if (xOffset > 0 ) {
		    sprite_index = spr_runAndGun1_minibossABC;
		} else {
			sprite_index = spr_runAndGun1_minibossCBA;
		}
		currentIndex = 0;
	}
	// slide enemy left and right
	if (abs(xOffset) >= maxXOffset) {
		//hang on walls
	    if (stateTimer[1] < 20) {
		    stateTimer[1] += 1;
		} else {
			// bounce off wall
			xOffset = 168 * sign(xOffset);
			bumps += 1;
			currentDir *= -1;
			stateTimer[1] = 0;
			if (sprite_index == spr_runAndGun1_minibossABC) {
				sprite_index = spr_runAndGun1_minibossCBA;
			} else if (sprite_index == spr_runAndGun1_minibossCBA ) {
				sprite_index = spr_runAndGun1_minibossABC;
			}
		}
	} else {
		// slide
		var slideSpeed = lerp(5,1, abs(xOffset)/maxXOffset);
		xOffset += (slideSpeed * currentDir);
	}
	// animate
    animateIdle(5);
	// handle attacks during each phase
	switch (enemyPhase) {
	    case -1:
	        if (x + xOffset + 264 > 12790) {
			    enemyPhase = 0;
				enemyState = 1;
				attackState = 0;
				stateTimer[0] = 0;
			}
	        break;
	    case 0:
	        if (enemyState == 0 && bullInst.enemyState == 0) {
			    if (idleTimer[0] < 60) {
				    idleTimer[0] += 1;
				} else {
					if (sign(currentDir) == sign(bullInst.currentDir)) {
					    // Pick an attack
						var goFish = irandom_range(redHerring - 3,redHerring + 2);
						if (redHerring < goFish) {
						    enemyState = 1;
							attackState = 3;
							
						} else {
							enemyState = 1;
							attackState = 0;
						}
						stateTimer[0] = 0;
						stateTimer[1] = 0;
						idleTimer[0] = 0;
						bumps = 0;
					}
				}
			}
	        break;
		case 1:
	        break;
	}
}

if (enemyState == 1) {
    switch (attackState) {
	    case 0: // Dash
			if (sprite_index != spr_runAndGun1_minibossLeft && sprite_index != spr_runAndGun1_minibossRight) {
				if ((sprite_index == spr_runAndGun1_minibossABC || sprite_index == spr_runAndGun1_minibossCBA) && 
				currentIndex % 6 == 0 && currentIndex != image_number - 1 ) {
					switch (sprite_index) {
					    case spr_runAndGun1_minibossABC:
							switch (currentIndex) {
							    case 0:
							        sprite_index = spr_runAndGun1_minibossAtoIdle;
							        break;
							    case 6:
							        sprite_index = spr_runAndGun1_minibossBtoIdle;
							        break;
								case 12:
							        sprite_index = spr_runAndGun1_minibossCtoIdle;
							        break;
							}
							currentIndex = 0;
					        break;
					    case spr_runAndGun1_minibossCBA:
					        switch (currentIndex) {
							    case 0:
							        sprite_index = spr_runAndGun1_minibossCtoIdle;
							        break;
							    case 6:
							        sprite_index = spr_runAndGun1_minibossBtoIdle;
							        break;
								case 12:
							        sprite_index = spr_runAndGun1_minibossAtoIdle;
							        break;
							}
							currentIndex = 0;
					        break;
					}
				} else if (sprite_index == spr_runAndGun1_minibossABC || sprite_index == spr_runAndGun1_minibossCBA) {
					if (stateTimer[0] < 5) {
					    stateTimer[0] += 1;
					} else {
						stateTimer[0] = 0;
						currentIndex += 1;
					}
				}
				if (sprite_index == spr_runAndGun1_minibossAtoIdle || sprite_index == spr_runAndGun1_minibossBtoIdle ||
				sprite_index == spr_runAndGun1_minibossCtoIdle) {
				    if (currentIndex < image_number - 1) {
					    if (stateTimer[0] < 5) {
						    stateTimer[0] += 1;
						} else {
							stateTimer[0] = 0;
							currentIndex += 1;
						}
					} else {
						if ( bullInst.x > 12676) {
							sprite_index = spr_runAndGun1_minibossLeft;
							currentDir = 1;
						} else {
							sprite_index = spr_runAndGun1_minibossRight;
							currentDir = -1;
						}
						bullInst.enemyState = 1;
						bullInst.attackState = 0;
						currentIndex = 0;
					}
				}
				if (sprite_index == spr_runAndGun1_bossIdleTransition) {
					// animate
					if (stateTimer[0] < 5) { 
						stateTimer[0] += 1;
					} else {
						stateTimer[0] = 0;
						currentIndex += 1;
					}
				
					if (currentIndex == image_number - 1) {
						currentDir *= -1;
						stateTimer[0] = 0;
						enemyState = 0;
					}
				}
			} else {
				//slide backwards
				if (abs(xOffset) >= maxXOffset && currentIndex < 3) {
					//hit the wall
					if (stateTimer[1] < 20) {	// stick to wall
					    stateTimer[1] += 1;
						currentIndex = 2;
					} else {
					    currentDir *= -1;
						xOffset = 168 * sign(xOffset);
						currentIndex = 3;
						stateTimer[0] = 0;
						stateTimer[1] = 0;
					}
				} else if (currentIndex < 3) {
					// slide
					if (stateTimer[0] < 20) {	// initial delay
					    stateTimer[0] += 1;
					} else {
						currentIndex = 1;
						var slideSpeed = lerp(3,1.5, abs(xOffset)/maxXOffset);
						xOffset += (slideSpeed * currentDir);
					}
				} 
				// Animation End
				if (currentIndex >= 3 && currentIndex < 8) {
					// animate
					if (stateTimer[0] < 5) {
					    stateTimer[0] += 1;
					} else {
						stateTimer[0] = 0;
						currentIndex += 1;
					}
					//slide
					var slideSpeed = lerp(3,7, abs(xOffset)/150);
					xOffset += (slideSpeed * currentDir);
					if (sign(currentDir == sign(xOffset))) {
					    if (abs(xOffset > 150)) {
						    currentIndex = 8;
						}
					}
				}
				if (currentIndex == 8) {
				    //slide
					if (abs(xOffset) >= maxXOffset) {
					    if (stateTimer[0] < 10) { //short delay
						    stateTimer[0] += 1;
						} else {
							xOffset = 168 * sign(xOffset);
							stateTimer[0] = 0;
							sprite_index = spr_runAndGun1_bossIdleTransition;
							currentIndex = 0;
						}
					} else {
						var slideSpeed = lerp(7,4, abs(xOffset)/maxXOffset);
						xOffset += (slideSpeed * currentDir);
					}
				}
			}
			break;			
		case 1: // Jump
			if (sprite_index != spr_runAndGun1_minibossJumpRight && sprite_index != spr_runAndGun1_minibossJumpLeft) {
				if (xOffset != 0) {
				    if (sign(currentDir) != sign(xOffset)) {
						if (abs(xOffset) > 2) {
						    xOffset += 2 * currentDir;
						} else {
							xOffset = 0;
						}
					} else {
						currentDir *= -1;
					}
				} else {
					bullInst.enemyState = 1;
					bullInst.attackState = 1;
				    if (bullInst.currentDir == 1) {
					    sprite_index = spr_runAndGun1_minibossJumpRight;
					} else {
						sprite_index = spr_runAndGun1_minibossJumpLeft;
					}
				}
			}
			// Animate			
			animateIdle(5);
			// Trigger state change
			if ((sprite_index == spr_runAndGun1_minibossJumpRight || sprite_index == spr_runAndGun1_minibossJumpLeft) && 
			bullInst.enemyState == 0) {
			    enemyState = 0;
				stateTimer[0] = 0;
			}
	        break;
		case 2: // Tornado
	        if (sprite_index != spr_runAndGun1_minibossSmash) {
				if (abs(xOffset) >= 4) {
				    xOffset -= sign(xOffset) * 4;
					animateIdle(5);
				} else {
					xOffset = 0;
					currentIndex = 4;
					bullInst.enemyState = 1;
					bullInst.attackState = 2;
					sprite_index = spr_runAndGun1_minibossSmash;
				}
			}
			if (sprite_index == spr_runAndGun1_minibossSmash) {
				// Slide
				var frameSteps = 5;
				var easePower   = 2.5;
				var fracFrame = currentIndex + (stateTimer[0] / frameSteps);
				xOffset = (getTornadoOffset(fracFrame, 140, easePower) * .6) + 24;

				// Animate
				animateIdle(frameSteps);
				
				// Trigger state change
				if (bullInst.enemyState == 0) {
				    enemyState = 0;
					stateTimer[0] = 0;
					stateTimer[1] = 0;
				}
			}
	        break;
		case 3: // Shoot
	        if (sprite_index != spr_runAndGun1_minibossShoot) {
				if (abs(xOffset) >= 4) {
				    xOffset -= sign(xOffset) * 4;
					animateIdle(5);
				} else {
					xOffset = 0;
					
					sprite_index = spr_runAndGun1_minibossShoot;
					currentIndex = 0;
				}
			}
			if (sprite_index == spr_runAndGun1_minibossShoot) {
				// Animate
				if (stateTimer[0] < 5) {
					stateTimer[0] += 1;
				} else if (currentIndex = image_number - 1) {
					enemyState = 0;
					stateTimer[0] = 0;
					stateTimer[1] = 0;
				} else if (currentIndex != 10) {
					stateTimer[0] = 0;
					currentIndex += 1;
				} else if (currentIndex == 10) {
					//hanging delay
					if (bullInst.enemyState != 1) {
						bullInst.enemyState = 1;
						bullInst.attackState = 3;
					}
					if (stateTimer[1] < 20) {
					    stateTimer[1] += 1;
					} else {
						stateTimer[1] = 0;
						currentIndex += 1;
						stateTimer[0] = 0;
					}
				} 
			}
	        break;
	}
}
