


void PlaceItem();
void sendRemoveToClient(entity player, entity e);
void removeInventory(entity e);

void Cmd_useItem_f(float ent)
{
	entity e = edict_num(ent);

	if(e.use ==  __NULL__)
		return;

	entity oself = self;
	self = e;
	
	e.use();
	
	self = oself;
	
	sendRemoveToClient(self, e);
}

void Cmd_dropInventory_vf(vector pos, float ent)
{
	entity e = edict_num(ent);

	e.origin = pos;
	e.owner = self;
	e.model = e.mdl;
	e.solid = SOLID_PHYSICS_BOX;
	e.movetype = MOVETYPE_PHYSICS;	


	e.mass = 5;
	e.bouncefactor = 0;
	e.bouncestop = 0;
	e.friction = 10;

	physics_enable(e, TRUE);

	removeInventory(e);
}




