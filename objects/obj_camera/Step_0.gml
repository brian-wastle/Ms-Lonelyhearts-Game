




// 1. Manual zoom cycling for debug (optional)
if (keyboard_check_pressed(ord("P")))
{
    zoom_index  = (zoom_index + 1) mod array_length(zoom_levels);
    target_zoom = zoom_levels[zoom_index];
}

// --------------------------------------------------
// 2. Decide the target X/Y each frame
if (!cutscene)  // ---- normal gameplay ----------------------------------
{
    // Follow player only on X; Y is locked
    if (follow != noone)
    {
        target_pos.x = round(follow.x / 4) * 4;
    }
    target_pos.y = yFixed;               // never move vertically
}
else            // ---- cut‑scene ----------------------------------------
{
    // A) STATIC shot  → follow == noone
    //    keep whatever target_pos we already have.

    // B) MOVING shot  → follow == some instance
    if (follow != noone)
    {
        target_pos.x = round(follow.x / 4) * 4;
        target_pos.y = round(follow.y / 4) * 4;
    }
    // (If you want the camera to slide on X *only* but stay fixed on Y
    //  during a cut‑scene, simply do not assign a follow object;
    //  call scr_camera_focus() once and leave follow = noone.)
}

// --------------------------------------------------
// 3. Smoothly pan & zoom toward the targets
var dx = target_pos.x - x;
var dy = target_pos.y - y;

if (abs(dx) < 1) {
    x = target_pos.x;
} else {
	x += dx / SMOOTH_POS;		// position easing
	x = round(x / 4) * 4;
	}

if (abs(dy) < 1) {
    y = target_pos.y;
} else {
	y += dy / SMOOTH_POS;		// position easing
	y = round(y / 4) * 4;
}

zoom += (target_zoom - zoom) / SMOOTH_ZOOM;   // zoom easing

//Ease the screen‑space pan (cut‑scenes only)
draw_offset += (draw_offset_t - draw_offset) / SMOOTH_SCREEN;

// --------------------------------------------------
// 4. Push values into the actual camera
camera_set_view_size(view_camera[0], camWidth, camHeight);

var offset_w = ((camWidth  / zoom) - camWidth)  * 0.5;
var offset_h = ((camHeight / zoom) - camHeight) * 0.5;

camera_set_view_pos(
    view_camera[0],
    x - camWidth  * 0.5 - offset_w,
    y - camHeight * 0.5 - offset_h
);