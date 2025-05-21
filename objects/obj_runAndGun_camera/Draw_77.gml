gpu_set_blendenable(false);

// 1) where does the game image land?
var sc     = zoom;
var surfW  = camWidth  * sc;
var surfH  = camHeight * sc;

var winW   = window_get_width();
var winH   = window_get_height();

// centre and vertical pan
var drawX  = (winW - surfW) * 0.5;
var drawY  = (winH - surfH) * 0.5 + drawOffset;

// sub‑pixel snap (keeps follow‑mode rock‑steady)
var subX   = -(frac(x      / 4) * 4) * sc;
var subY   = -(frac(yFixed / 4) * 4) * sc;

var picX   = drawX + subX;        // picture top‑left on the monitor
var picY   = drawY + subY;

// 2) draw the surface
draw_surface_ext(application_surface,
                 picX, picY,
                 sc, sc, 0, c_white, 1);

//------------------------------------------------
// 3. draw the letter‑box bars (last)
var barHeight = 4 * round(barCurrent / 4); // grid‑snapped
if (barHeight > 0)
{
    draw_set_color(c_black);

    // --- TOP ------------------------------------------------------------
    draw_rectangle(0, 0, winW, barHeight, false);

    // --- BOTTOM ---------------------------------------------------------
    draw_rectangle(0, winH - barHeight, winW, winH, false);
}

gpu_set_blendenable(true);