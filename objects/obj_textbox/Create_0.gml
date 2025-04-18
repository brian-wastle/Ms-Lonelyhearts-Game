// boxData from parent on creation
textboxState		= 0;		// states - appearing, typing, paused, page switching
currentPage			= 0;		// index of current page
currentLine			= 0;		// index of current line
formattedStruct		= {}		// Holds data for textbox
skipCharState		= 0;		// Allows for tags to be skipped during parsing characters to char entry Array in formatted Struct
offsetArray			= [];		// Keeps track of current position in line while generating char data
pageKeyArray		= [];		// Array of page keys
lineKeyArray		= [];		// Array of line Keys

// boxPos data from parent
initialXPos			= boxPos.xPos;
initialYPos			= boxPos.yPos; 
channelAppear		= animcurve_get_channel(curve_textbox_size, "curve1"); // textbox bg appear animation
channelDisappear	= animcurve_get_channel(curve_textbox_size, "curve2"); // textbox bg disappear animation
cx					= 0;
cy					= 0;
textboxSpeed		= 8;		// speed settings, must be a natural number > 0

// Character attributes
charColor			= #000000;
charEffect			= "";
charSpeed			= 4;

// Typewriter effect and resizing textbox (states 0 and 1)
totalPages			= 0;
currentCharIndex	= 0;		// Tracks current character position to be typed
typeDelay			= 0;		// Delay between characters being typed, held in formatted data struct
typeTimer			= 0;		// Tracks current delay timer
charCount			= 0;		// chars in line
textboxWidth		= 0;		// total width of textbox
textboxHeight		= 0;		// total height of textbox
totalLines			= 0;		// Total lines on page
lineLength			= 0;		// pixel length of longest line in textbox
boxSpeed			= 5;		// rate at which textbox appears and disappears
currentXSize		= 0;		// current x size as box expands/retracts
currentYSize		= 0;		// current y size as box expands/retracts




if (!is_struct(boxData)) {			// Passed in by obj_textEngine
    boxData = {};
}

function charData(
	_charIndex	= 0,
	_color		= #000000,
	_effect		= 0,
	_charSpeed	= 4,
	_lineIndex	= 0,
	_xOffset	= 0
) constructor {
	color		= _color;								// Character color
	effect		= _effect;							// Character effects from parser
	charSpeed	= _charSpeed;						// Delay (in frames) for typewriter effect
	charIndex	= _charIndex;						// Image index for alphanumeric character
	lineIndex	= _lineIndex;						// Current line on page
	xOffset		= _xOffset;							// Character X position
}

charToIndex = function(_char) {
	var c = string_upper(_char);
	if (ord(c) >= ord("A") && ord(c) <= ord("Z")) return ord(c) - ord("A"); // if char is between a and z, return index 0-25
	switch (c) {
	    case ".": return 26;
	    case ",": return 27;
	    case "!": return 28;
	    case "?": return 29;
	    case "-": return 30;
	    case "/": return 31;
	    case " ": return 32;
	    case "'": return 33;
	    case "1": return 34;
	    case "2": return 35;
	    case "3": return 36;
	    case "4": return 37;
	    case "5": return 38;
	    case "6": return 39;
	    case "7": return 40;
	    case "8": return 41;
	    case "9": return 42;
	    case "0": return 43;
	}
	return 44; // unsupported character
}

charToOffset = function(_charIndex, _currentLineOffset) {
	static fontWidthArray = [
		16, 16, 16, 16,
		12, 12, 20, 16,
		12, 16, 16, 16,
		20, 16, 16, 16,
		20, 16, 12, 12,
		16, 20, 24, 20,
		16, 16,  4,  8,
		4,  8,  8,  8,
		8,  4,  8, 12,
		12, 12, 12, 12,
		12, 12, 12, 12, 0
	];
	// take current char index and add width to and return currentLineOffset
	var newOffset = _currentLineOffset + fontWidthArray[@ _charIndex];
	return newOffset;
}

getTypeDelay = function() { 
	//Loop over formattedStruct
	var thisPageData = getPageData(currentPage);
	var lineString = string(currentLine + 1);
	var lineData = thisPageData[$ lineString];
	var entry = lineData[currentCharIndex];
	return entry.charSpeed;
}

getCharCount = function(_currentPage, _currentLine) {
	var thisPageData = getPageData(_currentPage);
	var lineString = string(_currentLine + 1)
	var thisLineData = thisPageData[$ lineString];
	return array_length(thisLineData);
}

getLinePixelLength = function() {
	var longestLength = 0;
	for (var i = 0; i < totalPages; ++i) {
	    var thisPageData = getPageData(i);
		var lineKeys = struct_get_names(thisPageData);
		var lineCount = array_length(lineKeys);
		for (var j = 0; j < lineCount; ++j) {
		    var thisLineKey = lineKeys[j];
			var thisLineData = thisPageData[$ thisLineKey];
			var lastCharIndex = array_length(thisLineData) - 1;
			var thisLength = thisLineData[lastCharIndex].xOffset;
			longestLength = thisLength > longestLength ? thisLength: longestLength;
		}
	}
	return longestLength;
}

getPageData = function(_currentPage) {
	var thisPage = string(_currentPage + 1);
	return formattedStruct[$ thisPage];
}

// Create a formatted struct with array of character data entries for each line
// Loop over each page in the struct

	var pages = struct_get_names(boxData);
	for (var j = 0; j < array_length(pages); ++j) {
		var thisPageIndex = string(j + 1);
		var lineArray = boxData[$ thisPageIndex];
		if (!struct_exists(formattedStruct,thisPageIndex)) {
			formattedStruct[$ thisPageIndex] = {};
		}
		var lineStruct = formattedStruct[$ thisPageIndex];
		array_push(offsetArray, []); // Empty array for each page in box
		
		// loop over each entry in line array
		for (var k = 0; k < array_length(lineArray); ++k) {
		    var lineIndex = string(k + 1);
			var page = lineArray[k].page;
			var character = lineArray[k].character;
			var thisDialog = lineArray[k].dialogRaw;
	
			if (!struct_exists(lineStruct, lineIndex)) {
			    lineStruct[$ lineIndex] = []; // Array of character entries
			}
			var charEntryArray = lineStruct[$ lineIndex];
			
			array_push(offsetArray[j], 0); // Empty value for each line in page
			var currentLineOffset = offsetArray[j][k];
			
			// loop over raw dialog to check for effects and image indexs
			for (var i = 0; i < string_length(thisDialog) - 2; ++i) {
				//parse codes
				var currentChar = string_char_at(thisDialog, i + 1); // String indexes begin at 1
				//Convert lower case letters to upper case
				var ordChar = ord(currentChar);
				if (ord(ordChar) >= ord("a") && ord(ordChar) <= ord("z")) {
				    
				}
				currentChar = string_upper(currentChar);

				// Parse effects
				if (skipCharState == 1) {
				    switch (currentChar) {
						case "5":
						case "6":
						case "7":
						case "8":
						case "9":
							charSpeed = real(currentChar);
							break;
					    case "R": // Red Text
					        charColor = "#41111A";
					        break;
						case "G": // Green Text
					        charColor = #002E16;
					        break;
						case "B": // Blue Text
					        charColor = #071b5f;
					        break;
						case "V": // Violet Text
					        charColor = #271640;
					        break;
					    case "W": // Wavy Text
							charEffect = "Wavy";
					        break;
						 case "/":
							skipCharState = 2;
					        break;
					}
				} else if (skipCharState == 2) {
					switch (currentChar) {
					    case "5":
						case "6":
						case "7":
						case "8":
						case "9":
							charSpeed = 4;
							break;
						case "R":
						case "G":
						case "B":
						case "V":
					        charColor = #000000;
					        break;
					    case "W":
							charEffect = "";
					        break;
						 case "}":
							skipCharState = 1;
					        break;
					}
				}
				
				// Skip adding tags to character entry arrays
				if (currentChar == "{" || currentChar == "}" || skipCharState != 0) {
					if (skipCharState == 0) {
					    skipCharState = 1;
					} else if (currentChar == "}") {
						skipCharState = 0;
					}
				    continue;
				}
				if (i > 0) {
				    currentLineOffset += 4;
				}
				
				var charIndex = charToIndex(currentChar);
				currentLineOffset = charToOffset(charIndex, currentLineOffset);
				
				var currentCharEntry = new charData(charIndex, charColor, charEffect, charSpeed, k, currentLineOffset);
				array_push(charEntryArray, currentCharEntry);
			}
		}
	}



pageKeyArray = struct_get_names(formattedStruct);
totalPages = array_length(pageKeyArray);
var pageString = string(currentPage + 1);
var pageData = formattedStruct[$ pageString];
lineKeyArray = struct_get_names(pageData);
totalLines = array_length(lineKeyArray);
charCount = getCharCount(currentPage, currentLine);
typeDelay = getTypeDelay();
lineLength = getLinePixelLength();
totalWidth = lineLength + 64;
totalHeight = (totalLines * 28) + 64;