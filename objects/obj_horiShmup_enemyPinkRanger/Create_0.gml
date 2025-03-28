
currentView = view_camera[0];
x1 = camera_get_view_x(currentView);
y1 = camera_get_view_y(currentView);
x2 = x1 + camera_get_view_width(currentView);
y2 = y1 + camera_get_view_height(currentView);
centerX = x1 + ((x2-x1)/2);
centerY = y1 + ((y2-y1)/2);

image_speed = 0;
direction = 180;

enemyEventTimer = 0;


xSpeed = 0;
ySpeed = 0;
directionStateX = -1; //controls whether players moves up or down
directionStateY = -1; //controls whether players moves up or down
slowdownTimerX = 0; //deceleration on x axis
slowdownTimerY = 0; //deceleration on y axis

enemyBulletTimer = 0;
bulletEventTimer = 0; //timer that switches between single fire or burst
bulletEvent = 0; // keeps track of single fire bullets fired
singleFire = 1; //controls whether gun is in single fire or burst
rapidEventTimer = 0; //keeps track of breaks between burst fire shots

blinkVar = 0;
enemyHealth = 400;

collisionList = 0;
bulletList = ds_list_create();