depth = -15999;
image_speed = .2;
currentRoomArray = []; // Holds array of structs containing current room script
currentScreenArray = [];
currentSceneIndex = 0; // Increases as each scene of the script is displayed, resets on room change 
currentScreenIndex = 0; // Increases as each line of the script is displayed, resets on room change
controlObj = ""; // Keeps track of control object for current room
textState = 0; // Whether text is being displayed
boxState = 0; //Whether the text box is being displayed
textBoxCornersX = [0, 0, 0, 0];
textBoxCornersY = [0, 0, 0, 0];
cursor = [56, 814];
letterDelayTimer = 0;
lineCounter = 0;
charCounter = [0,0,0];
buttonActive = 0; //whether the player can press a button to advance the screen yet
buttonActiveTimer = 0; //short delay to prevent skipping dialog too quickly
currentTextSpeed = 5;
tempCounter = 0;
currentBoxX = 0;
currentBoxY = 0;
boxHeight = 0;
boxWidth = 0;
progress = 0; //controls easing on text box resize
bgAlpha = 0; //alpha channel for text box bg
currentTime = 0;
flickerFrequency = 4;  // Adjust this for how frequently flickers happen
bgAlpha = 0;

// Initialize alphabet settings
function loadAlphabetSettings() {
    var alphabetFile = file_text_open_read(working_directory + "alphabet.txt");
    var jsonAlphabet = "";
    while (!file_text_eof(alphabetFile)) {
        jsonAlphabet += file_text_read_string(alphabetFile);
        file_text_readln(alphabetFile);
    }
    file_text_close(alphabetFile);

    var parsed = json_parse(jsonAlphabet);
    if (parsed == undefined) {
        show_error("Failed to parse alphabet JSON", true);
    }
    return parsed;
}

alphabetStruct = loadAlphabetSettings();

// Read entire script into a variable
function loadScript() {
    var scriptFile = file_text_open_read(working_directory + "script.txt");
    var jsonScript = "";
    while (!file_text_eof(scriptFile)) {
        jsonScript += file_text_read_string(scriptFile);
        file_text_readln(scriptFile);
    }
    file_text_close(scriptFile);
    return json_parse(jsonScript);
}

scriptStruct = loadScript();

// Run when room changes
function roomChange() {
	currentSceneIndex = 0;
    currentScreenIndex = 0;
    var _roomName = room_get_name(room);
    var _roomHash = variable_get_hash(_roomName);
    currentRoomArray = struct_get_from_hash(scriptStruct, _roomHash);
}


// Display current line of text and queue up next line
function currentScreenHandler(xBoxPos = 24, yBoxPos = 714, padding = "full", alignment = "left", textSpeed = 9) {
    // Freeze all action in the current room's control object
    //with (controlObj) {
    //    if (actionPause == 0) {
    //        actionPause = 1;
    //    }
    //}
	currentTextSpeed = 11 - textSpeed;
	currentTextSpeed = clamp(currentTextSpeed, 1, 10);
    // Process the current scene and line
    var currentScene = currentRoomArray[currentSceneIndex];
    var currentScreenSet = currentScene[currentScreenIndex].lines; // This can be a string or an array of strings
    currentScreenArray = [];

    // If the line set is a string, convert to an array 
    if (!is_array(currentScreenSet)) {
        currentScreenSet = [currentScreenSet];
    }

    // Iterate over each line in the set
    for (var lineIdx = 0; lineIdx < array_length(currentScreenSet); lineIdx++) {
        var currentLine = currentScreenSet[lineIdx];
        var lineArray = [];
        var totalWidth = 0;

        // Iterate over each character in the current line
        for (var i = 1; i <= string_length(currentLine); i++) {
            var char = string_char_at(currentLine, i);
            var data = getAlphabetData(char);
            var alphabetIndex = data[0];
            var charWidth = data[1];
            totalWidth += charWidth;

            // Add the character's data to the lineArray
            array_push(lineArray, {
                imageIndex: alphabetIndex,
                cumulativeWidth: totalWidth
            });
        }

        // Add the lineArray to the currentScreenArray
        array_push(currentScreenArray, lineArray);
    }
    // Calculate text box corners based on padding
	var xBoxPosParam = xBoxPos;
	var yBoxPosParam = yBoxPos;
    calculateCornerPadding(padding, xBoxPosParam, yBoxPosParam);
	boxState = 1;
}


// Get alphabet index and character width based on character
function getAlphabetData(char) {
    var alphabetIndex;
    var charWidth;
    var key;

    // Determine the alphabet index
    if (char >= "A" && char <= "Z") {
    alphabetIndex = ord(char) - ord("A");
} else if (char >= "a" && char <= "z") {
    alphabetIndex = 26 + (ord(char) - ord("a"));
} else if (char >= "0" && char <= "9") {
    alphabetIndex = 60 + (ord(char) - ord("0"));
} else {
    switch (char) {
        case ".": alphabetIndex = 52; break;
        case ",": alphabetIndex = 53; break;
        case "!": alphabetIndex = 54; break;
        case "?": alphabetIndex = 55; break;
        case "-": alphabetIndex = 56; break;
        case "/": alphabetIndex = 57; break;
        case " ": alphabetIndex = 58; break;
        case "'": alphabetIndex = 59; break;
        default: alphabetIndex = -1; break;
    }
}


    // Determine the character width
    switch (char) {
        case ".": key = "period"; break;
        case ",": key = "comma"; break;
        case "!": key = "exclamation"; break;
        case "?": key = "question"; break;
        case "-": key = "hyphen"; break;
        case "/": key = "slash"; break;
        case " ": key = "space"; break;
        case "'": key = "apostrophe"; break;
        default: key = char; key = string_lower(key); break;
    }
	
    var value = struct_get(alphabetStruct, key);
    if (value != undefined) {
        if (is_array(value)) {
            charWidth = (char >= "A" && char <= "Z") ? value[0] : value[1];
        } else if (typeof(value) == "number") {
            charWidth = value;
        } else {
            show_error("Unexpected type for key " + key + ":" + typeof(value), true);
            charWidth = 0;
        }
    } else {
        charWidth = 16;
    }

    // Return an array with alphabetIndex and charWidth
    return [alphabetIndex, charWidth];
}

// calculate corners based on padding
function calculateCornerPadding(padding, xBoxPos, yBoxPos) {
    if (padding == "full") {
        textBoxCornersX = [24, 1896, 24, 1896];
        textBoxCornersY = [714, 714, 1048, 1048];
        cursor = [56, 814];
    } else {
		//calculate longest line's x length and pad it out
		var tempLength = 0;
		var finalLine = 0;
		var screenArrayLength = array_length(currentScreenArray) - 1;
		for (var i = 0; i <= screenArrayLength; ++i) {
			var tempLine = array_last(currentScreenArray[i]);
			tempLine = tempLine.cumulativeWidth;
			if (finalLine < tempLine) {
				finalLine = tempLine;
			}
		}
		
		//calculate longest line's y length and pad it out
		
		textBoxCornersX = [xBoxPos, xBoxPos , xBoxPos, xBoxPos ];
        textBoxCornersY = [yBoxPos, yBoxPos, yBoxPos , yBoxPos ];
		
		var _addCameraPosX = function (_element, _index) {
			var camTempX = camera_get_view_x(view_camera[0]);
		    return _element + camTempX;
		}
		var _addCameraPosY = function (_element, _index) {
			var camTempY = camera_get_view_y(view_camera[0]);
		    return _element + camTempY;
		}
		var _addCameraPosCursor = function (_element, _index) {
			var camTempX = camera_get_view_x(view_camera[0]);
			var camTempY = camera_get_view_y(view_camera[0]);
		    return _element + camTempY;
		}
		
		textBoxCornersX = [xBoxPos, xBoxPos + finalLine + 64, xBoxPos, xBoxPos + finalLine + 64];
        textBoxCornersY = [yBoxPos, yBoxPos, yBoxPos + 100 + (100 * screenArrayLength) + 34, yBoxPos + 100 + (100 * screenArrayLength) + 34];

		cursor = [xBoxPos + 32, yBoxPos + 100];

		
	}
}

//progress screen
function buttonPress(xBoxPos = 24, yBoxPos = 714, padding = "slim", alignment = "left", textSpeed = 9) {
	currentScreenIndex += 1;
		//end the scene
		if (currentScreenIndex >= array_length(currentRoomArray[currentSceneIndex])) {
			currentScreenIndex = 0;
			currentSceneIndex += 1;
			textState = 0;
			boxState = 0;
			lineCounter = 0;
			charCounter = [0,0,0];
		} else {
		//display next line
		var xBoxPosTemp = xBoxPos;
		var yBoxPosTemp = yBoxPos;
		var paddingTemp = padding;
		var alignmentTemp = alignment;
		var textSpeedTemp = textSpeed;
		currentScreenHandler(xBoxPosTemp, yBoxPosTemp, paddingTemp, alignmentTemp, textSpeedTemp);
		}
		lineCounter = 0;
		charCounter = [0,0,0];
		array_resize(charCounter, array_length(currentRoomArray[currentSceneIndex]));
}

//skip to end of screen
function buttonSkip() {
	for (var i = 0; i < array_length(currentScreenArray); ++i) { 
		charCounter[i] = array_length(currentScreenArray[i]) - 1;
	}
	lineCounter = array_length(currentScreenArray) - 1;
}

//calculate text box corner positions
function calculateCornerPositions() {
    var cornerX1 = textBoxCornersX[0];                  // Top-left corner (fixed)
	var cornerY1 = textBoxCornersY[0];                  // Top-left corner (fixed)
	var cornerX2 = cornerX1 + currentBoxX;              // Top-right corner (moves with width)
	var cornerY2 = cornerY1;                            // Top-right corner (same Y as top-left)
	var cornerX3 = cornerX1;                            // Bottom-left corner (same X as top-left)
	var cornerY3 = cornerY1 + currentBoxY;              // Bottom-left corner (moves with height)
	var cornerX4 = cornerX1 + currentBoxX;              // Bottom-right corner (moves with width and height)
	var cornerY4 = cornerY1 + currentBoxY;              // Bottom-right corner (moves with height)
}


//function for drawing sides
function drawStretchedSide(sprite, x, y, width, height) {
    draw_sprite_stretched(sprite, 0, x, y, width, height);
}

