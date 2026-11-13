//-----------------------------------------------------------
// The player's UTComp crosshair and HUD settings.
//
// PerObjectConfig, so they are saved in UTCompSHO.ini as
// [ClientHUDSettings UTComp_ClientHudSettings], a section name without the
// package name (see UTComp_ClientSettings). Use
// class'UTComp_ClientHudSettings'.static.Get() to read and change them, and
// Save() to save them.
//-----------------------------------------------------------
class UTComp_ClientHudSettings extends Object
    Config(UTCompSHO)
    PerObjectConfig;

struct SpecialCrosshair
{
    var texture CrossTex;
    var float CrossScale;
    var color CrossColor;
    var float OffsetX;
    var float OffsetY;
};

// How a crosshair is saved: the texture by name, so that a texture from an
// older UTComp package can be found in this one (see Init()).
struct SavedCrosshair
{
    var string CrossTex;
    var float CrossScale;
    var color CrossColor;
    var float OffsetX;
    var float OffsetY;
};

var array<SpecialCrosshair> UTCompCrosshairs; // built from Crosshairs by Init()
var config array<SavedCrosshair> Crosshairs;
// Saved crosshairs whose texture didn't load. Save() keeps them in the ini,
// so they come back once the texture can be loaded again.
var array<SavedCrosshair> UnloadedCrosshairs;
var config bool bEnableUTCompCrosshairs;
var config bool bEnableCrosshairSizing;

var config bool bMatchHudColor;

var SpecialCrosshair TempxHair;

// The one settings object, kept in the class defaults (see Get()).
var UTComp_ClientHudSettings Instance;

// Returns the settings object, creating it (and loading UTCompSHO.ini) the
// first time it's needed.
static final function UTComp_ClientHudSettings Get()
{
    if (default.Instance == None)
    {
        default.Instance = new(None, "ClientHUDSettings") class'UTComp_ClientHudSettings';
        default.Instance.Init();
    }
    return default.Instance;
}

function Init()
{
    local int i;
    local string TexName;
    local SpecialCrosshair C;

    UTCompCrosshairs.Length = 0;
    UnloadedCrosshairs.Length = 0;

    // No HUD on a dedicated server (see UTComp_ClientSettings.Init).
    if (class'UTComp_ClientSettings'.default.bDedicatedServer)
        return;

    for (i = 0; i < Crosshairs.Length; i++)
    {
        TexName = Crosshairs[i].CrossTex;
        if (TexName == "" || TexName ~= "None")
            continue; // added in the menu but never given a texture
        class'UTComp_ClientSettings'.static.FixPackageName(TexName, class'Texture');
        C.CrossTex = Texture(DynamicLoadObject(TexName, class'Texture', true));
        if (C.CrossTex == None)
        {
            UnloadedCrosshairs[UnloadedCrosshairs.Length] = Crosshairs[i];
            continue;
        }
        C.CrossScale = Crosshairs[i].CrossScale;
        C.CrossColor = Crosshairs[i].CrossColor;
        C.OffsetX = Crosshairs[i].OffsetX;
        C.OffsetY = Crosshairs[i].OffsetY;
        UTCompCrosshairs[UTCompCrosshairs.Length] = C;
    }
}

function Save()
{
    local int i, n;

    n = UTCompCrosshairs.Length;
    Crosshairs.Length = n + UnloadedCrosshairs.Length;
    for (i = 0; i < n; i++)
    {
        Crosshairs[i].CrossTex = string(UTCompCrosshairs[i].CrossTex);
        Crosshairs[i].CrossScale = UTCompCrosshairs[i].CrossScale;
        Crosshairs[i].CrossColor = UTCompCrosshairs[i].CrossColor;
        Crosshairs[i].OffsetX = UTCompCrosshairs[i].OffsetX;
        Crosshairs[i].OffsetY = UTCompCrosshairs[i].OffsetY;
    }
    for (i = 0; i < UnloadedCrosshairs.Length; i++)
        Crosshairs[n + i] = UnloadedCrosshairs[i];
    SaveConfig();
}

defaultproperties
{
	bEnableCrosshairSizing=True
}
