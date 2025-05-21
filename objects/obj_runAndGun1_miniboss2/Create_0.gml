// Render
image_speed = 0;
currentIndex		= 0;		// current image index
bullInst			= noone;	// Instance ID of bull boss object
redHerring			= 42;		// that's a strange variable, I wonder what that'll do

// Track x pos offset while sliding in idle state
xOffset				= 0;		// current distance from initial x position
maxXOffset			= 172;		// max distance miniboss can move in either direction
currentDir			= 1;		// + or -1 to indicate direction
bumps				= 0;		// # of times boss has bumped sides in idle state

// Phases
enemyPhase			= -1;
phaseTimer[0]		= 0;

// States
enemyState			= -2;		// Current state
attackState			= 0;		// Which attack to queue
stateTimer[0]		= 0;		// state reusuable timers
stateTimer[1]		= 0;

// Idle
idleTimer[0]		= 0;		// Keeps track of idle state after initial phase

charArray = {
	preIdle: [
		spr_runAndGun1_minibossAtoIdle,
		spr_runAndGun1_minibossBtoIdle,
		spr_runAndGun1_minibossCtoIdle,
	],
	idle: [
		spr_runAndGun1_minibossABC,
		spr_runAndGun1_minibossCBA
	],
	jumpAttack: [
		spr_runAndGun1_minibossJumpLeft,
		spr_runAndGun1_minibossJumpRight,
	],
	dashAttack: [
		spr_runAndGun1_minibossLeft,
		spr_runAndGun1_minibossRight,
	],
	otherAttacks: [
		spr_runAndGun1_minibossShoot,
		spr_runAndGun1_minibossSmash
	],
	damage: [
		spr_runAndGun1_minibossDamage,
		spr_runAndGun1_minibossDamage2
	]
}

function easeIn(_t, _power) {
    return power(_t, _power);       // slow start → fast finish
}

function getTornadoOffset(_f, _max, _power)
{
    if (_f <= 8) {                       // rising side  (−max → +max)
        var t = _f / 8;                  // 0 … 1
        return lerp(-_max, _max, easeIn(t, _power));
    }
    else {                               // falling side (+max → −max)
        var t = (_f - 8) / 6;            // 0 … 1 over frames 8–14
        return lerp( _max, -_max, easeIn(t, _power));
    }
}


function animateIdle(duration) {
	if (stateTimer[0] < duration) {
		stateTimer[0] += 1;
	} else if (currentIndex < image_number - 1) {
		stateTimer[0] = 0;
		currentIndex += 1;
	} else {
		stateTimer[0] = 0;
		currentIndex = 0;
	}
}