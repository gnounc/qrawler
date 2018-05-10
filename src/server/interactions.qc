



/*
		TODONE:

	send message to client when added to inventory	-done
		//also need to spawn entities for incoming stuff, -done
			and add to .inventory linked list clientside 
			(so create addToInventory linked list and removeFromInventory)

	send message to server when removed from inventory	-done
	setup debug key in client to remove item from inventory	-done

	setup clientstat for inventory capacity-done
		
	setup open/close inventory button	-done

	setup inHand entity variable(dragEnt) -done
	
	setup startDrag and endDrag events - done

	add ondrop handler to inventory cells - done

	check for outside GUI drops, and drop anything inHand if dropped outside GUI area - done

	Send useItem message to server on rightclick over item in inventory cell


		TODO: 

	//make windows draggable



	//add hover stats for trace_ent in csqc, at least the name of the item

	//add a bit of speed to the item drop when dragging from inventory,
		base the speed on how fast you moved from clickpoint to releasepoint
		and the direction of movement based on the vector from clickpoint to releasepoint

	create storage chest entity ala diablo

	//populate .img on models in items.qc

	//fix the way items look when they drop. either through ode or without





void syncInventory(entity player)
{
	//keep client entnums in step with server entnums on map change and respawn

	return;
}

void printInventory(entity player)
{
	for(entity e = player.inventory; e != world; e = e.next)
		sprint(player, strcat("inv: ", e.classname, "\n"));
}

/*
	IMPORTANT NOTE!!!!!
		items arent removed when you pick them up. 
		so calling add inventory to an item you picked up, then calling it again near the same space
		will cause that item to be its own next, causing an infinite loop.
		so you MUST REMOVE ITEMS when you pick them up, and SPAWN THEM AGAIN when you drop them

*/


//Events
	const float EV_INV_PICKUP = 10;
	const float EV_INV_REMOVE = 11;

//asking the client to delete client side copies, and stop tracking this inventory item
void sendRemoveToClient(entity player, entity item)
{
	msg_entity = player; //make the client who touches this thing to be the receiver
	WriteByte(MSG_MULTICAST, SVC_CGAMEPACKET); //when sending a SVC_CGAMEPACKET we can handle it clientside, note: it has to be a MSG_MULTICAST.
	WriteByte(MSG_MULTICAST, EV_INV_REMOVE); //it's smart to use the first byte of the actual message as an identifier, and it's also smart to name them.

	WriteEntity(MSG_MULTICAST, item);

	multicast('0 0 0', MULTICAST_ONE_R); //send the message only to the dude that touched it, there's plenty of other ways to send these messages
}

void sendPickupToClient(entity player, entity item)
{
	msg_entity = player; //make the client who touches this thing to be the receiver
	WriteByte(MSG_MULTICAST, SVC_CGAMEPACKET); //when sending a SVC_CGAMEPACKET we can handle it clientside, note: it has to be a MSG_MULTICAST.
	WriteByte(MSG_MULTICAST, EV_INV_PICKUP); //it's smart to use the first byte of the actual message as an identifier, and it's also smart to name them.

	WriteEntity(MSG_MULTICAST, item);
	WriteString(MSG_MULTICAST, item.img);

	multicast('0 0 0', MULTICAST_ONE_R); //send the message only to the dude that touched it, there's plenty of other ways to send these messages
}


void addInventory(entity e)
{
	entity head = self.inventory;
	while(head.next != world)
	{
		if(head.next == e)
		{
			sprint(self, "Item already in inventory.\n");
			return;
		}

		head = head.next;
	}

	head.next = e;

	//so we can trigger .use()
	e.owner = self;

	self.quantity++;
	sendPickupToClient(self, e);

//	printInventory(self);
}


void removeInventory(entity e)
{
	if(self.quantity < 1 || e == world)
		return;

	entity head = self.inventory;
	while(head.next != e)
		head = head.next;

	head.next = e.next;
	e.next = world;

	//this would interrupt physics on drop, also it will get stomped over if someone else picks it up, so its fine
//	e.owner = world;
	self.quantity--;
}


/*
	serverside inventory is just a linked list
	clientside, we store entnum and inventorySlotId where inventory is just an array of playerInventorySize (which is a clientstat float)

	we send pickup item events to the client, with the entnum, itemname and iconPath
	client handles it from there, where you can drag and drop to rearrange
	message is sent back to the server if item is dropped onto paper doll, or off inventory, or procs some other way so that the effects can be handled

	//not sure if entnums are persistant across saves. they probably are, but if not, we'll just resynch the client on game load


	because inventory items are entities now, frikfile may be needed to save all inventory, then respawn them, 
		which will give them new entnums, so we'll need to resync with clienst after respawning
*/


entity getClosestEntity(vector pos)
{
	entity e, closest;
	float dist, oldDist;
	for(e = findradius(pos, 60), oldDist = 1000; e != world; e = e.chain)
	{	
		dist = vlen(pos - e.origin);
		if(dist < oldDist)
		{
			closest = e;
			oldDist = dist;
		}
	}

	sprint(self, strcat("item: ", closest.classname, ", dist: ", ftos(dist), "\n"));
	return closest;
}

void pickupItem(vector pos)
{
	if(self.quantity >= self.capacity)
	{
		//play error sound, maybe print inventory full somewhere
		return;
	}

	entity e = getClosestEntity(pos);

	if(e == world)
		return;

	e.model = string_null;
	e.solid = SOLID_NOT;

	physics_enable(e, FALSE);		//im getting ode errors, i think this will fix that..turned out to be remove(self) in a touch function. leaving thes here coz cant hurt
	
	WriteByte (MSG_BROADCAST, SVC_TEMPENTITY);
	WriteByte (MSG_BROADCAST, TE_SUPERSPIKE);
	WriteCoord (MSG_BROADCAST, pos_x);
	WriteCoord (MSG_BROADCAST, pos_y);
	WriteCoord (MSG_BROADCAST, pos_z);

	addInventory(e);
}


//dropItem() is clientside because its in the gui. it calls removeInventory