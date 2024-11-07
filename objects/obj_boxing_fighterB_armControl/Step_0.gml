keySpace = keyboard_check_pressed(vk_space);
keyShift = keyboard_check_pressed(vk_space);
enemyOffset = abs(obj_boxing_fighterB.x - obj_boxing_fighterA.x) > 150 ? 
	sign(obj_boxing_fighterB.x - obj_boxing_fighterA.x) : 0;
var turn = turnOffset * enemyOffset;
x = obj_boxing_fighterB.x - turn;
y = obj_boxing_fighterB.y;


//trigger punch states
if (keySpace && punchState < 1) {
    punchState = 1;
}

//idle punch state
if (punchState == 0) {
	switch (enemyOffset) {
		case 1:
		    currentRightPath = pathData.idle[3];
			currentLeftPath = pathData.idle[3];
		    break;
		case -1:
		    currentRightPath = pathData.idle[0];
			currentLeftPath = pathData.idle[0];
		    break;
		default:
		    currentRightPath = pathData.idle[1];
			currentLeftPath = pathData.idle[2];
		    break;
	}
}

// right jab state
if (punchState == 1) {	
	//set arm paths
	if (subState < 3) {
		switch (enemyOffset) {
			case 1:
				currentRightPath = pathData.jabRight[subState * 2 + 1];
				currentLeftPath = pathData.jabRight[subState * 2];
				break;
			case -1:
				currentRightPath = pathData.jabRight[subState * 2 + 7];
				currentLeftPath = pathData.jabRight[subState * 2 + 6];
				break;
			default:
				currentRightPath = pathData.jabRight[subState * 2 + 13];
				currentLeftPath = pathData.jabRight[subState * 2 + 12];
				break;
		}
	}
}
// left jab state
if (punchState == 2) {	
	//set arm paths
	if (subState < 3) {
		switch (enemyOffset) {
			case 1:
				currentRightPath = pathData.jabLeft[subState * 2 + 1];
				currentLeftPath = pathData.jabLeft[subState * 2];
				break;
			case -1:
				currentRightPath = pathData.jabLeft[subState * 2 + 7];
				currentLeftPath = pathData.jabLeft[subState * 2 + 6];
				break;
			default:
				currentRightPath = pathData.jabLeft[subState * 2 + 13];
				currentLeftPath = pathData.jabLeft[subState * 2 + 12];
				break;
		}
	}
}


if (punchState == 1 || punchState == 2) {
    if (stateTimer > 1) {
	    stateTimer -= 1
	} else if (stateTimer = 1) {
		subState += 1;
		stateTimer -= 1;
	} else {
		if (subState <= 2) {
			stateTimer = jabTimerArray[subState];
		} else {
			subState = 0;
			punchState = 0;
		}
	}
}
	//control substates with timers
	
	
	
	
	
	
	
	
	
	


//Initiate active arm paths
path_start(currentRightPath, 0, 0, 0);
//right arm position
for (var i = 0; i < 6; ++i) {
	xOnPath = path_get_x(currentRightPath, pathPositionsArray[i]);
	yOnPath = path_get_y(currentRightPath, pathPositionsArray[i]);
	armDataRight[i].x = x + armOffset[0] + xOnPath;
	armDataRight[i].y = y - armOffset[1] + yOnPath;
}
path_start(currentLeftPath, 0, 0, 0);
//left arm position
for (var i = 0; i < 6; ++i) {
	xOnPath = path_get_x(currentLeftPath, pathPositionsArray[i]);
	yOnPath = path_get_y(currentLeftPath, pathPositionsArray[i]);
	armDataLeft[i].x = x - armOffset[0] + xOnPath;
	armDataLeft[i].y = y - armOffset[1] + yOnPath;
}