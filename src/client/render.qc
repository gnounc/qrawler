// vars
vector screen_size, screen_center;


/* Called by the engine after the video was restarted. 
This serves to notify the CSQC that any render targets that it may have cached were purged, and will need to be regenerated. */
void CSQC_RendererRestarted(string rendererdescription) 
{

}

void drawInventory();

/* Called every single video frame. The CSQC is responsible for rendering the entire screen. */
void CSQC_UpdateView(float vwidth, float vheight, float notmenu) 
{
	screen_size_x = vwidth;
	screen_size_y = vheight;

	screen_center_x = screen_size_x/2;
	screen_center_y = screen_size_y/2;

	GUI_INVENTORY.size = '195 187';
	GUI_EQUIP.size = '95 95';
	GUI.size = [GUI_INVENTORY.size_x + 5, GUI_INVENTORY.size_y + GUI_EQUIP.size_y + 10];

	GUI_INVENTORY.pos = GUI.pos + '2.5 2.5';
	GUI_EQUIP.pos = GUI_INVENTORY.pos + [0 , GUI_INVENTORY.size_y + 5];

	clearscene();

	setviewprop(VF_DRAWWORLD, 1);
	setviewprop(VF_DRAWCROSSHAIR, 0);
	setviewprop(VF_DRAWENGINESBAR, 0);
	addentities(MASK_ENGINE | MASK_VIEWMODEL);
	

	renderscene();

	//add 2d draw stuff below
	
	getStats();

	drawGUI();
}



/* Called by addentities after the filter and before the entity is actually drawn. Do your interpolation and animation in here. Should return one of the PREDRAW_* constants. */
//.float() predraw;	

