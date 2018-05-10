
/* Called at startup. enginename and engineversion are arbitary hints and can take any form. enginename should be consistant between revisions, but this cannot truely be relied upon. */
void CSQC_Init(float apilevel, string enginename, float engineversion)
{
	//sizes and pos are calced in render.qc
	//container/terminal node
	GUI = spawn();
	GUI.name = "gui";
	GUI.pos = '25 50';

	GUI_EQUIP = spawn();
	GUI_EQUIP.name = "equip";
	GUI_EQUIP.next = GUI;

	GUI_INVENTORY = spawn();
	GUI_INVENTORY.name = "inventory";
	GUI_INVENTORY.next = GUI_EQUIP;
	

	sprintf("you can do eet\n","");
}

/* Called after model+sound precaches have been executed. Gives a chance for the qc to read the entity lump from the bsp. */
void CSQC_WorldLoaded()
{

}

/* Specifies that the csqc is going down. Save your persistant settings here. */
void CSQC_Shutdown()
{

}




