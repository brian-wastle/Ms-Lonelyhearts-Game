enemyOffset = abs(obj_boxing_fighterB.x - obj_boxing_fighterA.x) > 150 ? sign(obj_boxing_fighterB.x - obj_boxing_fighterA.x) : 0;
var turn = turnOffset * enemyOffset;
x = obj_boxing_fighterB.x - turn;
y = obj_boxing_fighterB.y;

//idle arm state
if (punchState = 0) {
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
}

// jab state
if (punchState = 1) {
//draw arm to starting position


//extend arm to jab position


//return arm to rest position


}
