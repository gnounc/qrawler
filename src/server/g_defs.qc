

string(string fmt, ...) sprintf = #627;
string(string s1, optional string s2, optional string s3, optional string s4, optional string s5, optional string s6, optional string s7, optional string s8) strcat = #115; /* Part of FRIK_FILE, FTE_STRINGS, ZQ_QC_STRINGS*/

.entity next;
.entity inventory;
.float quantity;
.float capacity;
.string img;

void(vector where, float set) multicast = #82; /*const float SVC_CGAMEPACKET = 83;	/* Direct ssqc->csqc message. Must only be multicast. The data triggers a CSQC_Parse_Event call in the csqc for the csqc to read the contents. The server *may* insert length information for clients connected via proxies which are not able to cope with custom csqc payloads. This should only ever be used in conjunction with the MSG_MULTICAST destination. */

const float SVC_CGAMEPACKET = 83;	/* Direct ssqc->csqc message. Must only be multicast. The data triggers a CSQC_Parse_Event call in the csqc for the csqc to read the contents. The server *may* insert length information for clients connected via proxies which are not able to cope with custom csqc payloads. This should only ever be used in conjunction with the MSG_MULTICAST destination. */
const float MSG_BROADCAST = 0;	/* The byte(s) will be unreliably sent to all players. MSG_ constants are valid arguments to the Write* builtin family. */
const float MSG_ONE = 1;	/* The byte(s) will be reliably sent to the player specified in the msg_entity global. WARNING: in quakeworld servers without network preparsing enabled, this can result in illegible server messages (due to individual reliable messages being split between multiple backbuffers/packets). NQ has larger reliable buffers which avoids this issue, but still kicks the client. */
const float MSG_ALL = 2;	/* The byte(s) will be reliably sent to all players. */
const float MSG_INIT = 3;	/* The byte(s) will be written into the signon buffer. Clients will see these messages when they connect later. This buffer is only flushed on map changes, so spamming it _WILL_ result in overflows. */
const float MSG_MULTICAST = 4;	/* The byte(s) will be written into the multicast buffer for more selective sending. Messages sent this way will never be split across packets, and using this for csqc-only messages will not break protocol translation. */
const float MSG_ENTITY = 5;	/* The byte(s) will be written into the entity buffer. This is a special value used only inside 'SendEntity' functions. */
const float MULTICAST_ALL = 0;	/* The multicast message is unreliably sent to all players. MULTICAST_ constants are valid arguments for the multicast builtin, which ignores the specified origin when given this constant. */
const float MULTICAST_PHS = 1;	/* The multicast message is unreliably sent to only players that can potentially hear the specified origin. Its quite loose. */
const float MULTICAST_PVS = 2;	/* The multicast message is unreliably sent to only players that can potentially see the specified origin. */
const float MULTICAST_ONE = 6;	/* The multicast message is unreliably sent to the player specified in the msg_entity global. The specified origin is ignored. */
const float MULTICAST_ALL_R = 3;	/* The multicast message is reliably sent to all players. The specified origin is ignored. */
const float MULTICAST_PHS_R = 4;	/* The multicast message is reliably sent to only players that can potentially hear the specified origin. Players might still not receive it if they are out of range. */
const float MULTICAST_PVS_R = 5;	/* The multicast message is reliably sent to only players that can potentially see the specified origin. Players might still not receive it if they cannot see the event. */
const float MULTICAST_ONE_R = 7;	/* The multicast message is reliably sent to the player specified in the msg_entity global. The specified origin is ignored */

void(float buf, float fl) WriteFloat = #280;
void(float to, float val) WriteByte = #52; /*
		Writes a single byte into a network message buffer. Typically you will find a more correct alternative to writing arbitary data. 'to' should be one of the MSG_* constants. MSG_ONE must have msg_entity set first. */

void(float to, float val) WriteChar = #53;
void(float to, float val) WriteShort = #54;
void(float to, float val) WriteLong = #55;
void(float to, float val) WriteCoord = #56;
void(float to, float val) WriteAngle = #57;
void(float to, string val) WriteString = #58;
void(float to, entity val) WriteEntity = #59;

entity(float entnum) edict_num = #459; /* Part of DP_QC_EDICT_NUM*/


void(entity e, float physics_enabled) physics_enable = #540; /* Enable or disable the physics attached to a MOVETYPE_PHYSICS entity. Entities which have been disabled in this way will stop taking so much cpu time. */
void(entity e, vector force, vector relative_ofs) physics_addforce = #541; /* Apply some impulse directional force upon a MOVETYPE_PHYSICS entity. */
void(entity e, vector torque) physics_addtorque = #542; 

const float MOVETYPE_PHYSICS = 32;	/* Enable the use of ODE physics upon this entity.*/ 
const float SOLID_PHYSICS_BOX = 32;
const float SOLID_PHYSICS_SPHERE = 33;
const float SOLID_PHYSICS_CAPSULE = 34;
const float SOLID_PHYSICS_TRIMESH = 35;
const float SOLID_PHYSICS_CYLINDER = 36;

.float geomtype;
.float friction;
.float erp;
.float jointtype;
.float mass;
.float bouncefactor;
.float bouncestop;

void(float num, float type, .__variant fld) clientstat = #232;
void(float num, float type, string name) globalstat = #233;

const float AS_STRING 			= 1;
const float AS_FLOAT_TRUNCATED 	= 2; // int value
const float AS_FLOAT			= 8;
