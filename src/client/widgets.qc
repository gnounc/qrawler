

entity button(vector arg_pos, vector arg_size, string arg_img, void() arg_cb_click)
{
	entity e = spawn();
	e.pos = arg_pos;
	e.size = arg_size;
	e.img = arg_img;
	e.click = arg_cb_click;

	return e;
}


