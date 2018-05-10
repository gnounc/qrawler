
/* Called as a result of player.dmg_save or player.dmg_take being set on the server.
Return true to completely inhibit the engine's colour shift and damage rolls, allowing you to do your own thing.
You can use punch_roll += (normalize(inflictororg-player.origin)*v_right)*(take+save)*autocvar_v_kickroll; as a modifier for the roll angle should the player be hit from the side, and slowly fade it away over time. */
float CSQC_Parse_Damage(float save, float take, vector inflictororg)
{
	return TRUE;
}


//Events
	const float EV_INV_PICKUP = 10;
	const float EV_INV_REMOVE = 11;



/* Called when the client receives an SVC_CGAMEPACKET. The csqc should read the data or call the error builtin if it does not recognise the message. */
void CSQC_Parse_Event()
{
	float event = readbyte();
	float entnum;

	switch(event)
	{
		//the server is asking the client to remove its copy of the item, 
		//if this is called, the server should have already removed its own copy
		case EV_INV_REMOVE:
			entnum = readentitynum();

			removeInventory(entnum);	//remove from inventory list
			removeById(entnum);				//delete object from memory
			break;

		case EV_INV_PICKUP:
			entnum = readentitynum();
			string img_path = readstring();

			entity e = spawn();
			e.id = entnum;
			e.img = img_path;
			e.drop = SUB_Null;
			e.size = '32 32';

			addInventory(e);

			break;
		default:
			break;
	}
}

