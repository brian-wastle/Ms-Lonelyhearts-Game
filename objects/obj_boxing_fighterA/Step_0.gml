    playerDir = obj_boxing_fighterB.xOffset;
    sprite_index = spriteArray[playerDir + 1]; // Match the direction player is facing

    // Get the character’s current position
    var target_x = obj_boxing_fighterB.x;
    var distance_to_player = abs(x - target_x);

    // Determine if the player is moving toward or away from the tracker
    playerMovingToward = (obj_boxing_fighterB.speed < 0 && x < target_x) || (obj_boxing_fighterB.speed > 0 && x > target_x);

    // Room boundaries with buffer
    var room_left_bound = 200;
    var room_right_bound = room_width - 200;

    // Check if the player is near the screen edges
    var player_near_left_edge = obj_boxing_fighterB.x <= room_left_bound + 50; // 50 can be adjusted based on how close to the edge you want to check
    var player_near_right_edge = obj_boxing_fighterB.x >= room_right_bound - 50;

    // Check if the player is moving away from the tracker
    var playerMovingAway = (obj_boxing_fighterB.speed > 0 && x < target_x) || (obj_boxing_fighterB.speed < 0 && x > target_x);

    // Enter sliding state
    if (!isSliding && distance_to_player < triggerDistance && playerMovingToward && 
        !(player_near_left_edge || player_near_right_edge)) {
        isSliding = true; // Activate the sliding state
        slideStartTime = current_time; // Record the time when sliding starts
        // Set the target position to slide towards
        targetSlidingX = (x < target_x) ? (target_x + offsetDistance) : (target_x - offsetDistance);
    }

    if (isSliding) {
        // Smoothly move towards the target position
        x = lerp(x, targetSlidingX, slideSpeed); // Slide towards the originally set target

        // Clamp x position to stay within room boundaries
        x = clamp(x, room_left_bound, room_right_bound);

        // Check if we have reached the target position or the duration has passed
        if (distance_to_player > offsetDistance) {
            // If reached the target position, reset the sliding state
            isSliding = false;
        } else if (current_time - slideStartTime >= switchDuration * 1000) {
            // If the duration has passed, also reset the sliding state
            isSliding = false;
        }
    } else {
        // If not sliding, track the player position when outside the offset distance
        if (distance_to_player > offsetDistance && 
            !(player_near_left_edge || player_near_right_edge) &&
            !playerMovingAway) {
            // Smoothly track the player's position
            var targetSpeed = (target_x - x) * trackSpeed; // Calculate target speed towards player
            x += targetSpeed * (1 - trackSpeed); // Smoothly adjust the position
        }

        // Clamp x position to stay within room boundaries
        x = clamp(x, room_left_bound, room_right_bound);
    }

