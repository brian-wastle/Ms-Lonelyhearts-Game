
// We're up to the current line array of entries
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
        if (currentCharIndex < charCount && currentLine < totalLines) {
		   if (typeTimer < typeDelay) {
			    typeTimer += 1;
			} else {
				typeTimer = 0;
				typeDelay = getTypeDelay();
				currentCharIndex += 1;
			}
		} else if (currentCharIndex == charCount && currentLine < totalLines - 1) {
			currentLine += 1;
			currentCharIndex = 0;
			charCount = getCharCount(currentPage, currentLine);
		} else if (currentCharIndex == charCount && currentLine >= totalLines - 1){
			textboxState = 2;
		}
        break;
	case 2: // waiting on player input
        break;
	case 3: // shrinking textbox
        if (currentXSize > 0) {
		    currentXSize -= 4;
			currentXSize = clamp(currentXSize,0,totalWidth);
			var xProgress = currentXSize/totalWidth;
			var tempYHeight = xProgress * totalHeight;
			currentYSize = round(tempYHeight);
		} else {
			instance_destroy();
		}
        break;

}
