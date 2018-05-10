

//in a grid of known size, position and row/col length, what cell is a given point in?
//window has to have size and position filled in
//gridSize is an x/y vector
//the idea is to convert a point to a cell, and a cell to an index into a 1dimensional array
vector pointToGridCell(vector point, entity window, vector gridSize)
{
	//mouse position offset by inventory gui
	vector mmpos = point - window.pos;
	vector cell = [floor((mmpos_x *gridSize_x/window.size_x)), floor((mmpos_y *gridSize_y/window.size_y))];

	return cell;
}

float cellToIndex(vector cell, float rowLength)
{
	return (floor(cell_x + 1 + (cell_y*rowLength)) - 1);
}


//thx spike!
vector pointToWorldCoords(vector point)
{
	vector wnear = unproject([point_x, point_y, 0]);	//determine the world coordinate for the mouse cursor upon the near clip plane
	vector wfar = unproject([point_x, point_y, 100000]);//determine the world coordinate for the mouse cursor upon the far clip plane, with an outrageously large value as a workaround for dp.
	traceline(wnear, wfar, TRUE, world);

	return trace_endpos;
};

//thx spiiiiike
vector worldToScreenCoords(vector worldpos)
{
	vector twodee = project(worldpos);
	twodee_z = 0;	//discard all depth info (note that depth is typically scaled between 0 and 1, so avoid)

	return twodee;
};


vector mouseToWorldCoords()
{
	return pointToWorldCoords(mpos);
}

float pointInBounds(vector p, vector pos, vector size)
{
	if(p_x < pos_x)
		return FALSE;
	if(p_y < pos_y)
		return FALSE;
	if(p_x > pos_x + size_x)
		return FALSE;
	if(p_y > pos_y + size_y)
		return FALSE;

	return TRUE;
}

float boundsInBounds(vector pmin, vector pmax, vector min, vector max)
{
	if(!(pointInBounds(pmin, min, max)))
		return FALSE;

	if(!(pointInBounds(pmax, min, max)))
		return FALSE;

	return TRUE;
}

vector centerPoint(vector bPos, vector bSize)
{
	return bPos + (bSize/2);
}

vector centerBounds(vector objSize, vector targPos, vector targSize)
{
	return ((targPos + (targSize/2)) - objSize/2);
//	return targPos - (objSize - targSize);
}





/*&
vector screenClamp(vector v)
{
	if(v_x > screen_size_x)
	{
		v_x = screen_size_x - (20 + 40);
	}

	if(v_x < 0)
	{
		v_x = (20 + 15);
	}

	if(v_y > screen_size_y)
	{
		v_y = screen_size_y - (20 + 15);
	}

	if(v_y < 0)
	{
		v_y = (20 + 15);
	}

	return v;
}
*/


vector clampPointToBounds(vector point, vector bounds_pos, vector bounds_size, float padding)
{
	if(point_x > bounds_size_x)
	{
		point_x = bounds_size_x - padding;	//for character width when drawing cursor
	}

	if(point_x < bounds_pos_x)
	{
		point_x = bounds_pos_x;
	}

	if(point_y > bounds_size_y)
	{
		point_y = bounds_size_y - padding;	//for character width when drawing cursor
	}

	if(point_y < bounds_pos_y)
	{
		point_y = bounds_pos_y;
	}

	return point;
}


vector screenClamp(vector v)
{
	return clampPointToBounds(v, '0 0', screen_size, 8);
}



