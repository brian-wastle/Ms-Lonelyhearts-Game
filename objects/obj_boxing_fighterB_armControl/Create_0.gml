armOffset = [240, 80];
turnOffset = -10; 
enemyOffset = 0; // direction player is facing
punchState = 0;
pathData = {
	idle: [
		path_boxing_right_idle, 
		path_boxing_center_idle, 
		path_boxing_center_idle1, 
		path_boxing_left_idle
	],
	jab: [path_boxing_right_idle]
}


pathPositionsArray = [0,.2,.4,.6,.8,1]; // positions of arm nodes
armDataRight = array_create(6); // instance ids for right arm
armDataLeft = array_create(6); // instance ids for left arm
xOnPath = 0; //calculate path positions
yOnPath = 0; //calculate path positions

currentRightPath = pathData.idle[1];
currentLeftPath = pathData.idle[2];

//create right arm
path_start(currentRightPath, 0, 0, 0);
for (var i = 0; i < 5; ++i) {
	xOnPath = path_get_x(path_index, pathPositionsArray[i]);
	yOnPath = path_get_y(path_index, pathPositionsArray[i]);
	armDataRight[i] = instance_create_layer(
		x + armOffset[0] + xOnPath, 
		y - armOffset[1] + yOnPath, 
		"Arms", 
		obj_boxing_fighterB_nodes, {
			node: "arm"
		}
	);
}

//create right glove
xOnPath = path_get_x(path_index, pathPositionsArray[5]);
yOnPath = path_get_y(path_index, pathPositionsArray[5]);
armDataRight[5] = instance_create_layer(
	x + armOffset[0] + xOnPath, 
	y - armOffset[1] + yOnPath, 
	"Arms", 
	obj_boxing_fighterB_nodes, {
		node: "gloveRight"
	}
);

//create left arm
path_start(currentLeftPath, 0, 0, 0);
for (var i = 0; i < 5; ++i) {
	xOnPath = path_get_x(path_index, pathPositionsArray[i]);
	yOnPath = path_get_y(path_index, pathPositionsArray[i]);
	armDataLeft[i] = instance_create_layer(
		x - armOffset[0] - xOnPath, 
		y - armOffset[1] + yOnPath, 
		"Arms", 
		obj_boxing_fighterB_nodes, {
			node: "arm"
		}
	);
}

//create left glove
xOnPath = path_get_x(path_index, pathPositionsArray[5]);
yOnPath = path_get_y(path_index, pathPositionsArray[5]);
armDataLeft[5] = instance_create_layer(
	x - armOffset[0] - xOnPath, 
	y - armOffset[1] + yOnPath, 
	"Arms", 
	obj_boxing_fighterB_nodes, {
		node: "gloveLeft"
	}
);