// Create Event
playerState = 0;
armControlInst = instance_create_layer(x,y,"Instances", obj_boxing_fighterB_armControl);
spriteArray = [spr_boxing_fighterB_bgL, spr_boxing_fighterB_bgC, spr_boxing_fighterB_bgR];

maxSpeed = 7;
maxScrollRate = 12;
keyLeft = 0;
keyRight = 0;
keySpace = 0;
screenBuffer = 600; 
roomLeftBound = screenBuffer;
roomRightBound = room_width - screenBuffer;
centerX = room_width / 2; 
layerId = layer_get_id("Background");
backgroundSpeed = 0;
targetSpeed = 0;
punchState = 0;
xOffset = 0; // Difference in x position between player and enemy

