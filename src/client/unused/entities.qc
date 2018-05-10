//ENTITIES
	void CSQC_Ent_Update(float isnew)
	{

	}	

	void CSQC_Ent_Remove()
	{

	}


	/*		Walks through all entities effectively doing this:
	if (ent.drawmask&mask){ if (!ent.predaw()) addentity(ent); }
	If mask&MASK_DELTA, non-csqc entities, particles, and related effects will also be added to the rentity list.
	If mask&MASK_STDVIEWMODEL then the default view model will also be added. */
//	addentities(float mask); 

	/* Copies the entity fields into a new rentity for later rendering via addscene. */
//	addentity(entity ent);//
