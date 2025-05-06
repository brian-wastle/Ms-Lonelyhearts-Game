camWidth  = 1920;
camHeight = 1080;

surface_resize(application_surface, camWidth + 1, camHeight);
application_surface_draw_enable(false);

// --- tracking
yFixed = round(room_height * 0.5 / 4) * 4;
follow         = obj_RunAndGun_Player;   // current target instance (or noone)
cutscene       = false;                  // true while manually controlled
target_pos     = { x : x, y : yFixed };       // where we eventually want to be
zoom_levels    = [1.25, 1.5, 1.75, 2];
zoom_index     = 0;
zoom           = zoom_levels[0];
target_zoom    = zoom;



draw_offset    = 0;   // where we’re currently panned   (screen pixels)
draw_offset_t  = 0;   // where we want to be (target)   (screen pixels)
SMOOTH_SCREEN  = 10;  // bigger = slower screen pan
SMOOTH_POS  = 24;   // bigger = slower pan
SMOOTH_ZOOM = 10;   // bigger = slower zoom



/// Locks view on world‑space (_x,_y) while also zooming.
/// Works even when the room is the same height as the view.
///
/// How?
///   • X: we still move the camera horizontally (room is wide enough)
///   • Y: instead of moving the real camera, we translate the
///        application‑surface in Post‑Draw by draw_offset(_t)
///
/// NOTE: Post‑Draw must already be using draw_offset / draw_offset_t
///       like in the previous message.
///
function scr_camera_focus(_x, _y, _zoomIdx, _instant=false)
{
    //--------------------------------
    // 1) enter cut‑scene mode
    follow   = noone;
    cutscene = true;

    //--------------------------------
    // 2) world‑space target (snap X only)
    target_pos.x = round(_x / 4) * 4;
    target_pos.y = yFixed;               // keep real camera centred

    //--------------------------------
    // 3) screen‑space vertical pan
    var y_target   = round(_y / 4) * 4;
    var delta_y    = y_target - yFixed;          // room pixels
    draw_offset_t = -delta_y * zoom_levels[_zoomIdx];

    //--------------------------------
    // 4) zoom
    zoom_index  = clamp(_zoomIdx, 0, array_length(zoom_levels)-1);
    target_zoom = zoom_levels[zoom_index];

    //--------------------------------
    // 5) optional instant jump
    if (_instant)
    {
        x            = target_pos.x;
        draw_offset  = draw_offset_t;
        zoom         = target_zoom;
    }
}


/// Leaves cut‑scene, recentres the screen, zooms back out.
function scr_camera_follow(_who = obj_RunAndGun_Player)
{
    follow        = _who;
    cutscene      = false;

    // ease back to default zoom
    zoom_index    = 0;
    target_zoom   = zoom_levels[0];

    // ease screen back to centre
    draw_offset_t = 0;
}

