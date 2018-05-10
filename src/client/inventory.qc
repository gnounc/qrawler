

void useItem(entity item)
{	
	//from server, call items .use(), and send back "remove item" event if nothing failed
	sendevent("useItem", "f", item.id);
}

void equipInventory(entity ent)
{

}

void removeById(float idNum)
{
	for(float idx = 0; idx < 16; idx++)
	{
		if(inventory[idx].id == idNum)
		{	
			remove(inventory[idx]);
			inventory[idx] = world;
		}
	}
}

void removeInventory(float);

void sendRemoveToServer(entity item)
{
   sendevent("dropInventory", "vf", mouseToWorldCoords(), item.id);
   remove(item);	//our copies are really just indexes. if we keep them alive after removal they get can jumbled
}

float getInvSlotByItem(entity e)
{
	for(float idx = 0; idx < 16; idx++)
	{
		if(inventory[idx].id == e.id)
			return idx;
	}

	return 0;
}

void addInventory(entity e)
{
	for(float idx = 0; idx < 20; idx++)
	{
		if(inventory[idx] == world)
		{
			inventory[idx] = e;
			return;
		}
	}
}

void removeInventory(float e)
{
	if(e == 0)
		return;

	for(float idx = 0; idx < 20; idx++)
	{
		if(inventory[idx].id == e)
			inventory[idx] = world;
	}
}

void dropInventory(entity e)
{
	removeInventory(e.id);
	sendRemoveToServer(e);
}

//need to add click debouncing :/
entity getHoverWindow()
{
	for(entity e = GUI_INVENTORY; e != world; e = e.next)
	{
		if(pointInBounds(mpos, e.pos, e.size))	
			return e;
	}

	return world;		//this WILL return world. so check for that anywhere this is called
}

float getHoverSlot()
{
	entity window = getHoverWindow();

	if(window == GUI_EQUIP) 
		return 0;

	if(window == GUI_INVENTORY)
	{
		vector cell = pointToGridCell(mpos, GUI_INVENTORY, inventorySize);
		float idx = cellToIndex(cell, inventorySize_x);

		return idx;
	}

	return 0;
}

entity hoverEnt()
{
	getHoverSlot();

	entity window = getHoverWindow();
	
//	if(window == GUI_EQUIP) 
//		return equipment[getHoverSlot()];

	if(window == GUI_INVENTORY)
		return inventory[getHoverSlot()];

	return world;
}

//TODO!!!!!!!!! cancel action if item is dropped over an inventory slot beyond our player.capacity
	// draw blocked tile runes for inventory slots beyond player.capacity
void itemDrop()
{
	//depopulate dragEnt and put into a local variable so i can be lazy below and not write dragEnt = world; everywhere
	entity ent = dragEnt;
	dragEnt = world;

	if(ent == world)
		return;

	entity window = getHoverWindow();

	//not over any gui, drop enventory item
	if(window == world)
		dropInventory(ent);
	
	if(window == GUI_EQUIP)
	{
		equipInventory(ent);
		return;
	}

	if(window == GUI_INVENTORY)
	{
		float itemSlot = getHoverSlot();
		float dragSlot = getInvSlotByItem(ent);

		entity invItem = inventory[itemSlot];

		if(invItem != world)
		{	
			removeInventory(ent.id);
			removeInventory(invItem.id);

			inventory[itemSlot] = ent;
			inventory[dragSlot] = invItem;

			return;
		}

		//drop item into emptly slot
		removeInventory(ent.id);
		inventory[getHoverSlot()] = ent;
	}
}			

void dragRelease()
{
	if(dragEnt == world)
		return;

	if(mode_interact == FALSE)
	{
		dragEnt = world;
		return;
	}

	dragEnt.drop();
	dragEnt = world;
}

