// 1. debug zoom cycle
if (keyboard_check_pressed(ord("P")))
{
    zoomIndex  = (zoomIndex + 1) mod array_length(zoomLevels);
    targetZoom = zoomBase * zoomLevels[zoomIndex];
}

//---------------------------------------------
// 2. choose target position
if (!cutscene)
{
    // follow player horizontally
    if (follow != noone)
        targetPos.x = round(follow.x / 4) * 4;

    targetPos.y = yFixed;   // never move vertically
}
else if (follow != noone)    // moving cut‑scene
{
    targetPos.x = round(follow.x / 4) * 4;
    targetPos.y = round(follow.y / 4) * 4;
}

//---------------------------------------------
// 3. smooth pan & zoom
x         = round((x +  (targetPos.x - x) / smoothPos)   / 4) * 4;
y         = round((y +  (targetPos.y - y) / smoothPos)   / 4) * 4;
zoom     +=        (targetZoom - zoom) / smoothZoom;
drawOffset +=      (drawOffsetT - drawOffset) / smoothScreen;

//---------------------------------------------
// 4. update letter‑box height
barCurrent = lerp(barCurrent, barTarget, barSpeed);
if (abs(barCurrent - barTarget) < 0.5)
    barCurrent = barTarget;

//---------------------------------------------
// 5. push into view #0 so other objects that read camera data get correct values
camera_set_view_size(view_camera[0], camWidth, camHeight);

var offW = ((camWidth  / zoom) - camWidth)  * 0.5;
var offH = ((camHeight / zoom) - camHeight) * 0.5;

camera_set_view_pos(
    view_camera[0],
    x - camWidth  * 0.5 - offW,
    y - camHeight * 0.5 - offH);