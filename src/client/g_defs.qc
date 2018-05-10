//debug

void() SUB_Null = {};
vector mpos;
entity dragEnt;
.void() drop;
noref vector screen_size, screen_center;

noref string s_msg;

.float id;
.vector pos;
.string img;
.entity next;
.void() click; 
.float slotnum;
.string name;

entity GUI;
entity GUI_EQUIP;
entity GUI_INVENTORY;
entity inventory[20];
noref entity equipment[6];
float capacity;
vector inventorySize = '4 4';
vector itemPicSize = '32 32';

float mode_interact;
vector (vector v) unproject = #310;

#define findentity findfloat
entity(entity start, .__variant fld, __variant match) findfloat = #98; /* Part of DP_QC_FINDFLOAT
		Equivelent to the find builtin, but instead of comparing strings contents, this builtin compares the raw values. This builtin requires multiple calls in order to scan all entities - set start to the previous call's return value.
		world is returned when there are no more entities. */

#define K_TAB	9
#define K_ENTER	13
#define K_ESCAPE	27
#define K_SPACE	32
#define K_BACKSPACE	127
#define K_UPARROW	128
#define K_DOWNARROW	129
#define K_LEFTARROW	130
#define K_RIGHTARROW	131
#define K_LALT	132
#define K_RALT	-245
#define K_LCTRL	133
#define K_RCTRL	-246
#define K_LSHIFT	134
#define K_RSHIFT	-247

#define K_MWHEELUP	515
#define K_MWHEELDOWN	516
#define K_PRINTSCREEN	174
#define K_CAPSLOCK	155
#define K_SCROLLLOCK	156
#define K_SEMICOLON	59
#define K_TILDE	126
#define K_BACKQUOTE	96
#define K_BACKSLASH	92
