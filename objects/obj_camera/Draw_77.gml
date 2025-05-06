gpu_set_blendenable(false);

var _scale = zoom;

var surf_w = camWidth  * _scale;
var surf_h = camHeight * _scale;

var win_w  = window_get_width();
var win_h  = window_get_height();

// centre on screen…
var draw_x = (win_w - surf_w) * 0.5;
var draw_y = (win_h - surf_h) * 0.5
           + draw_offset;                 // << vertical pan in screen px

// sub‑pixel snap (still uses *yFixed* so follow‑mode is rock‑steady)
var sub_x = -(frac(x       / 4) * 4) * _scale;
var sub_y = -(frac(yFixed  / 4) * 4) * _scale;

draw_surface_ext(application_surface,
                 draw_x + sub_x,
                 draw_y + sub_y,
                 _scale, _scale,
                 0,  c_white, 1);

gpu_set_blendenable(true);
