if tempCounter = 0 {
	tempCounter += 1;
	roomChange();
	currentScreenHandler();
}


if (boxState == 1 && textState == 0) {
    // Calculate the target box width and height
    boxHeight = point_distance(textBoxCornersX[0], textBoxCornersY[0], textBoxCornersX[2], textBoxCornersY[2]);
    boxWidth = point_distance(textBoxCornersX[0], textBoxCornersY[0], textBoxCornersX[1], textBoxCornersY[1]);
	var maxDimension = max(boxWidth, boxHeight);
    
    if (progress < 1) {
        progress += 0.03; // expansion speed
        if (progress > 1) progress = 1;
    }
    
    // Calculate the current width and height using easing
    var easeProgress = (3 - 2 * progress) * progress * progress; // Cubic ease-in-out
    currentBoxX = easeProgress * boxWidth;
    currentBoxY = easeProgress * boxHeight;

    if (progress == 1) {
        textState = 1;
    }
}



if (textState = 1) {
	if (!buttonActive) {
		if (!audio_is_playing(sfx_textEngine_voice0)) {
			audio_play_sound_ext({ sound: sfx_textEngine_voice0 });
		}
	} else {
		audio_stop_sound(sfx_textEngine_voice0);
	}
	//print the current lineset, one letter at a time
	if (lineCounter = array_length(currentScreenArray) - 1 && (charCounter[lineCounter] = array_length(currentScreenArray[lineCounter]) - 1)) {
		buttonActive = 1;
	} else if (letterDelayTimer < currentTextSpeed) {
		letterDelayTimer += 1;
	} else if (letterDelayTimer >= currentTextSpeed) {
		letterDelayTimer = 0;
		if (charCounter[lineCounter] < array_length(currentScreenArray[lineCounter]) - 1) {
			charCounter[lineCounter] += 1;
		}
		if ((charCounter[lineCounter] = array_length(currentScreenArray[lineCounter]) - 1) && lineCounter < array_length(currentScreenArray) - 1) {
			lineCounter += 1;
		}
	}
	//Progress to the next lineset when a button is pressed
	if (buttonActive = 1) {
		if (buttonActiveTimer < 20) {
			buttonActiveTimer += 1;
		} else {
			if (keyboard_check_pressed(vk_space)) {
				buttonPress();
				buttonActive = 0;
				buttonActiveTimer = 0;
			}
		}
	} else {
		if (keyboard_check_pressed(vk_space)) {
			buttonSkip();
		}
	}
}

//flicker text box bg
currentTime += (1 / 60) * flickerFrequency;

// Generate irregular flicker by adding random noise to a base value
bgAlpha = 0.85 + (0.15 * random_range(0.8, 1.2) * sin(current_time + random_range(-1, 1)));

// Clamp the alpha between 0.7 and 1
bgAlpha = clamp(bgAlpha, 0.85, .92);


