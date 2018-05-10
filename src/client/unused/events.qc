
/* Called as a result of player.dmg_save or player.dmg_take being set on the server.
Return true to completely inhibit the engine's colour shift and damage rolls, allowing you to do your own thing.
You can use punch_roll += (normalize(inflictororg-player.origin)*v_right)*(take+save)*autocvar_v_kickroll; as a modifier for the roll angle should the player be hit from the side, and slowly fade it away over time. */
float CSQC_Parse_Damage(float save, float take, vector inflictororg)
{

}

/* Called when the client receives an SVC_CGAMEPACKET. The csqc should read the data or call the error builtin if it does not recognise the message. */
void CSQC_Parse_Event()
{
	
}