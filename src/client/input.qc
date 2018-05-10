
/* Gives the CSQC a chance to intercept stuffcmds. 
Use the tokenize builtin to parse the message. 
Unrecognised commands would normally be localcmded, 
but its probably better to drop unrecognised stuffcmds completely. */
void CSQC_Parse_StuffCmd(string msg) 
{
	localcmd(msg);
}

/* 
	Called whenever a key is pressed, 

	the mouse is moved, etc. evtype will be one of the IE_* constants. 
	The other arguments vary depending on the evtype. 
	Key presses are not guarenteed to have both scan and unichar values set at the same time
*/

	//const float IE_KEYDOWN = 0;	/* Specifies that a key was pressed. Second argument is the scan code. Third argument is the unicode (printable) char value. Fourth argument denotes which keyboard(or mouse, if its a mouse 'scan' key) the event came from. Note that some systems may completely separate scan codes and unicode values, with a 0 value for the unspecified argument. */
	//const float IE_KEYUP = 1;	/* Specifies that a key was released. Arguments are the same as IE_KEYDOWN. On some systems, this may be fired instantly after IE_KEYDOWN was fired. */
	//const float IE_MOUSEDELTA = 2;	/* Specifies that a mouse was moved (touch screens and tablets typically give IE_MOUSEABS events instead, use _windowed_mouse 0 to test code to cope with either). Second argument is the X displacement, third argument is the Y displacement. Fourth argument is which mouse or touch event triggered the event. */
	//const float IE_MOUSEABS = 3;	/* Specifies that a mouse cursor or touch event was moved to a specific location relative to the virtual screen space. Second argument is the new X position, third argument is the new Y position. Fourth argument is which mouse or touch event triggered the event. */
	//const float IE_ACCELEROMETER = 4;
	//const float IE_FOCUS = 5;	/* Specifies that input focus was given. parama says mouse focus, paramb says keyboard focus. If either are -1, then it is unchanged. */
	//const float IE_JOYAXIS = 6;	/* Specifies that what value a joystick/controller axis currently specifies. x=axis, y=value. Will be called multiple times, once for each axis of each active controller. */
	//const float IE_GYROSCOPE = 7;



//my keyboard appears to send press and release frames even when i havent released
//that or i have an bug
entity hoverEnt();
void itemDrop();
void useItem(entity item);
float CSQC_InputEvent(float evtype, float scanx, float chary, float devid) 
{
	float scancode = scanx;
	float unicode = chary;
	switch(evtype) 
	{
		case IE_KEYDOWN:
//			cprint(strcat(ftos(scancode), "\n"));

			switch(scancode) 
			{
				case K_MOUSE1:
					if(mode_interact == FALSE)
						break;
					dragEnt = hoverEnt();
//					print(sprintf("dragEnt: %s\n", dragEnt.img));
					return TRUE;
				case K_MOUSE2:
					if(mode_interact == FALSE)
						break;
					if(hoverEnt() == world)
						break;
					useItem(hoverEnt());
					return TRUE;
				case K_LSHIFT:
					mode_interact = TRUE;
					break;
				default:
					//code...
					break;
			}
			break;

		case IE_KEYUP:
//			print(strcat(ftos(scancode), "\n"));
			switch(scancode) 
			{
				case K_MOUSE1:
					if(mode_interact == TRUE)
						itemDrop();
					break;
				case K_LSHIFT:
					mode_interact = FALSE;
					dragEnt = world;
					break;

				default:
					//code...
					break;
			}
			break;

			case IE_MOUSEABS:
				break;
			case IE_MOUSEDELTA:
				if(mode_interact == TRUE)
					mpos += [scanx, chary];
				return mode_interact;		//dont mouselook when shift is held

				break;
		default:
			//code...
			break;
	}
	mpos = screenClamp(mpos);
	return FALSE;
}

/* Called just before each time clientcommandframe is updated. 
You can edit the input_* globals in order to apply your own player inputs within csqc, 
which may allow you a convienient way to pass certain info to ssqc. */
__used void CSQC_Input_Frame()	
{

}

/* Called if the user uses any console command registed via registercommand. */
float CSQC_ConsoleCommand(string cmd)	
{

	return FALSE;
}
