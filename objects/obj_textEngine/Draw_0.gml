draw_text(x,y,textBoxCornersX);
draw_text(x,y + 30, textBoxCornersY);
draw_text(x,y + 50, camera_get_view_x(view_camera[0]));
draw_text(x,y + 70, array_length(currentScreenArray));

var camTempX = camera_get_view_x(view_camera[0]);
var camTempY = camera_get_view_y(view_camera[0]);

if (boxState == 1) {
    var cornerX1 = textBoxCornersX[0] + camTempX;                  // Top-left corner (fixed)
    var cornerY1 = textBoxCornersY[0] + camTempY;                  // Top-left corner (fixed)
    var cornerX2 = cornerX1 + currentBoxX;              // Top-right corner (moves with width)
    var cornerY2 = cornerY1;                            // Top-right corner (same Y as top-left)
    var cornerX3 = cornerX1;                            // Bottom-left corner (same X as top-left)
    var cornerY3 = cornerY1 + currentBoxY;              // Bottom-left corner (moves with height)
    var cornerX4 = cornerX1 + currentBoxX;              // Bottom-right corner (moves with width and height)
    var cornerY4 = cornerY1 + currentBoxY;              // Bottom-right corner (moves with height)
    
	draw_sprite_part_ext(spr_textBox_bg,0,0,0,cornerX4 - cornerX1, cornerY4 - cornerY1, cornerX1, cornerY1, 1, 1, c_white, bgAlpha);
	
    draw_sprite_ext(spr_textBox_corners, 0, cornerX1, cornerY1, 1, 1, 0, c_white, 1); // Top-left
    draw_sprite_ext(spr_textBox_corners, 1, cornerX2, cornerY2, 1, 1, 0, c_white, 1); // Top-right
    draw_sprite_ext(spr_textBox_corners, 2, cornerX3, cornerY3, 1, 1, 0, c_white, 1); // Bottom-left
    draw_sprite_ext(spr_textBox_corners, 3, cornerX4, cornerY4, 1, 1, 0, c_white, 1); // Bottom-right

    draw_sprite_stretched(spr_textBox_verticalSides, 0, cornerX1 - 16, cornerY1, 16, currentBoxY); // Left side
    draw_sprite_stretched(spr_textBox_verticalSides, 0, cornerX2, cornerY2, 16, currentBoxY); // Right side
    draw_sprite_stretched(spr_textBox_horizontalSides, 0, cornerX1, cornerY1 - 16, currentBoxX, 16); // Top side
    draw_sprite_stretched(spr_textBox_horizontalSides, 0, cornerX3, cornerY3, currentBoxX, 16);       // Bottom side
	
	if (buttonActive) {
		draw_sprite_ext(spr_textEngine_marker, image_index, cornerX4 - 12, cornerY4 - 8, 1, 1, 0, c_white, 1);
	}

	if (textState = 1) {
		if (lineCounter > 0) {
			for (var i = 0; i <= lineCounter - 1; ++i) { //for every previous line	
				var tempCursor = cursor[0] + camTempX;
				var currentCursor = cursor[0] + camTempX;
			    for (var j = 0; j <= charCounter[i]; ++j) { //for every character in the line	
				    draw_sprite_ext(spr_alphabet, currentScreenArray[i][j].imageIndex, currentCursor, cursor[1] + i * 100, 1, 1, 0, c_white, 1);
					currentCursor = tempCursor + currentScreenArray[i][j].cumulativeWidth;
				}
			}
		}
		var tempCursor = cursor[0] + camTempX;
		var currentCursor = cursor[0] + camTempX;
		for (var j = 0; j <= charCounter[lineCounter]; ++j) { //for every character in the line	
			draw_sprite_ext(spr_alphabet, currentScreenArray[lineCounter][j].imageIndex, currentCursor, cursor[1] + lineCounter * 100, 1, 1, 0, c_white, 1);
			currentCursor = tempCursor + currentScreenArray[lineCounter][j].cumulativeWidth;
		}
	}
}