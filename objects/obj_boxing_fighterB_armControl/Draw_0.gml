draw_self();
draw_text(1300,400,string_concat("Punch State: ",punchState));
draw_text(1300,420,string_concat("Sub State: ",subState));

draw_path(currentRightPath,x + armOffset[0], y - armOffset[1], false);
draw_path(currentLeftPath,x - armOffset[0], y - armOffset[1], false);