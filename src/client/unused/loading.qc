
/* Called each time some resource is being loaded. CSQC can invoke various draw calls to provide a loading screen, until WorldLoaded is called. */
float CSQC_LoadResource(string resname, string restype)	
{

}


/* Alternative to CSQC_UpdateView, called when the engine thinks there should be a loading screen. If present, will inhibit the engine's normal loading screen, deferring to qc to draw it. */
void CSQC_UpdateViewLoading(float vwidth, float vheight, float notmenu) 
{

}
