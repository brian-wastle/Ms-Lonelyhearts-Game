enemyState = 100; // State 100 - Appear from the margins of the screen
previousState = 0; // State of previous step
enemyHealth = 100;
aggroState = 0;
randomize();
freezeTimer = irandom_range(120,180); // Used to add delay within a state or during transitions between states
spriteArray = [[
spr_beatEmUp_yjacketIdle,
spr_beatEmUp_yjacketWalk,
spr_beatEmUp_yjacketDamage,
spr_beatEmUp_yjacketAttack1
]];
sprite_index = spriteArray[charIndex][1];

// Initialize and appear onscreen
dirOffset = 0;
mid_x = view_get_xport(0) + (view_get_wport(0) / 2);
if (x < mid_x) {
    // Left side
	dirOffset = -1;
} else {
    // Right side
	dirOffset = 1;
}
xGoal = 0;
yGoal = y;
xGoal = mid_x + 760 * dirOffset;
shadowSize = 0;

//pathfinding
movePath = path_add();
path_set_kind(movePath, 1);
path_set_precision(movePath, 8);

zsp = 0;
pathTimer = 0;
xProximity = 0;
yProximity = 0;
foundPosition = 0;
targetX = 0; // Used for pathfinding when target is not player
targetY = 0; 

// Combat
comboTimer = 0;
attackStack = 0; // Current number of combo hits towards a KO
shakeOffset = 0; // Distance for shake effect during damage state
shakeDir = 0;
iFrameTimer = 0; // How long enemy is invincible after being hit to prevent double damage
knockbackState = 0; // Tracks enemy position when knocked back
initialX = 0 // Track initial position for knockback state
finalX = 0; // Target x position
zMaxKO = 150; // Adjust for desired arc height
knockbackProgress = 0;
knockbackSpeed = 0.03; // Adjust for duration (higher = faster)
knockbackState = 0; // Prevent reinitialization
knockbackDistance = 400;