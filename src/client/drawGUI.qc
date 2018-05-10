


void drawInventory()
{
	drawpic(GUI_INVENTORY.pos, "/gfx/bag", GUI_INVENTORY.size, '1 1 1', 1, 0);

	vector p;
	vector offs = '18 13';
	vector padding = '10 10';
	vector v_pos = GUI_INVENTORY.pos + offs;

	float idx = 0;
	for(float y = 0; y < 4; y++)
	{
		for(float x = 0; x < 4; x++, idx++)
		{
			entity e = inventory[idx];

			p_x = v_pos_x + x*(itemPicSize_x + padding_x); 
			p_y = v_pos_y + y*(itemPicSize_y + padding_y);

			if(idx >= capacity)
				drawpic(p, "gfx/blocked", itemPicSize, '1 1 1', 1, 0);

			if(e == world)
				continue;

			drawpic(p, e.img , itemPicSize, '1 1 1', dragEnt == e ? 0.6 : 1, 0);
		}
	}
}


void drawGUI()
{
	if(mode_interact == FALSE)
		return;

	drawstring('100 100', sprintf("Client: v: %v \n", GUI_INVENTORY.pos - mpos), '16 16', '1 1 1', 1, 0);

	drawInventory();

	//draw cursor
	drawstring(mpos, "x", '8 8', '1 1 1', 1, 0);

	if(dragEnt == world)
		return;

	//draw dragEnt
	drawpic(mpos - '16 16', dragEnt.img, dragEnt.size, '1 1 1', 1);
}

