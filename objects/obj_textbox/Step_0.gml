
// Each entry contains :
// charSpeed: real
// charIndex: real
// effect : real
// xOffset:real
// color: hex/real

//currentCharIndex	= 0;		Tracks current character position to be typed
//typeDelay			= 0;		Delay between characters being typed, held in formatted data struct
//typeTimer			= 0;		Tracks current delay timer


// account for the length of each line then switch to the next line
// at the end of the line, switch to the next line
switch (textboxState) {
    case 0: // expanding textbox
		if (cx < 1) {
			cx += 1 / (textboxSpeed * 10);
			cy = animcurve_channel_evaluate(channelAppear, cx);
		    currentXSize = cy * totalWidth;
			currentYSize = cy * totalHeight;
		} else {
			textboxState = 1;
		}
        break;
	case 1: // typing
		if (keyboard_check(vk_space)) {
		    typeDelay = 0;
			currentCharIndex += 1;
		}
        if (currentCharIndex < charCount && currentLine < totalLines) {
		   if (typeTimer < typeDelay) {
			    typeTimer += 1;
			} else {
				typeTimer = 0;
				typeDelay = getTypeDelay();
				currentCharIndex += 1;
			}
		} else if (currentCharIndex >= charCount && currentLine < totalLines - 1) {
			currentLine += 1;
			currentCharIndex = 0;
			charCount = getCharCount(currentPage, currentLine);
		} else if (currentCharIndex >= charCount && currentLine >= totalLines - 1){
			textboxState = 2;
		}
        break;
	case 2: // waiting on player input
		if (pointerDelay < 8) {
		    pointerDelay += 1;
		} else {
			pointerDelay = 0;
			if (pointerIndex < 4) {
			    pointerIndex += 1;
			} else {
				pointerIndex = 0;
			}
		}
		if (skipDelay < 15) {
		    skipDelay += 1;
		} else {
			if (keyboard_check_pressed(vk_space)) {
			    skipDelay = 0;
				if (currentPage < totalPages - 1) {
				    textboxState = 1;
					currentPage += 1;
					currentLine = 0;
					currentCharIndex = 0;
					charCount = getCharCount(currentPage, currentLine);
				} else {
					textboxState = 3;
				}
			}
		}
        break;
	case 3: // shrinking textbox
        if (currentXSize > 0) {
			shrinkSpeed *= 1.05;
		    currentXSize -= shrinkSpeed;
			currentXSize = clamp(currentXSize,0,totalWidth);
			var xProgress = currentXSize/totalWidth;
			var tempYHeight = xProgress * totalHeight;
			currentYSize = round(tempYHeight);
		} else {
			instance_destroy();
		}
        break;
}

// Text effects
if (wavyDelay < 4) {
    wavyDelay += 1;
} else {
	if (wavyIndex < array_length(wavyArray) - 1) {
	    wavyIndex += 1;
	} else {
		wavyIndex = 0;
	}
	wavyDelay = 0;
}

