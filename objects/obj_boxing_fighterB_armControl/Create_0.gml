armOffset = [240, 80];
turnOffset = 10; 
shoulderL = instance_create_layer(x - armOffset[0], y - armOffset[1], "Arms", obj_boxing_fighterB_arm);
shoulderR = instance_create_layer(x + armOffset[0], y - armOffset[1], "Arms", obj_boxing_fighterB_arm);
punchState = 0;
punchData = {
	jab: [path_boxing_right_idle]
}
depth = -1000;
