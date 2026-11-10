//-----------------------------------------------------------
// The player's UTComp settings.
//
// PerObjectConfig, so they are saved in UTCompSHO.ini as
// [ClientSettings UTComp_ClientSettings], a section name without the package
// name. Settings therefore carry over when a new version is released under
// a new package name. Use class'UTComp_ClientSettings'.static.Get() to read and
// change them, and Save() to save them. Keep the class name, the object name
// and the variable names, or later versions won't find the saved settings.
//
// The settings of UTComp_Overlay, UTComp_ScoreBoard, UTComp_xDeathMessage,
// ModernPlayer and UTComp_xPawn.bPlayOwnFootsteps are kept here too.
// Those classes still use their own default values, which ApplyToClasses()
// sets and Save() reads back.
//-----------------------------------------------------------
class UTComp_ClientSettings extends Object
    Config(UTCompSHO)
    PerObjectConfig
    HideDropDown
    CacheExempt;

//#exec AUDIO IMPORT FILE=Sounds\HitSound.wav     GROUP=Sounds
//#exec AUDIO IMPORT FILE=Sounds\HitSoundFriendly.wav    GROUP=Sounds

var config bool bFirstRun;
var config bool bStats;
var config bool bEnableUTCompAutoDemorec;
var config string DemoRecordingMask;
var config bool bEnableAutoScreenshot;
var config string ScreenShotMask;
var config string FriendlySound;
var config string EnemySound;
var config bool bEnableHitSounds;
var config float HitSoundVolume;
var config bool bCPMAStyleHitsounds;
var config float CPMAPitchModifier;
var config float SavedSpectateSpeed;
var config bool bUseDefaultScoreBoard;
var config bool bShowSelfInTeamOverlay;
var config bool bEnableEnhancedNetCode;
var config bool bEnableColoredNamesOnEnemies;
var config bool ballowcoloredmessages;
var config bool bEnableColoredNamesInTalk;
var config array<byte> DontDrawInStats;
// var config float InstaFireRate;


var config int CurrentSelectedColoredName;
var config color ColorName[20];

var config bool bDisableSpeed, bDisableBooster, bDisableInvis, bDisableberserk;

struct ColoredNamePair
{
    var color SavedColor[20];
    var string SavedName;
};

var config array<ColoredNamePair> ColoredName;



struct ClanSkinTripple
{
    var string PlayerName;
    var color PlayerColor;
    var string ModelName;
};

var config string FallbackCharacterName;
var config bool bEnemyBasedSkins;
var config byte ClientSkinModeRedTeammate;
var config byte ClientSkinModeBlueEnemy;
var config byte PreferredSkinColorRedTeammate;
var config byte PreferredSkinColorBlueEnemy;
var config color BlueEnemyUTCompSkinColor;
var config color RedTeammateUTCompSkinColor;
var config bool bBlueEnemyModelsForced;
var config bool bRedTeammateModelsForced;
var config string BlueEnemyModelName;
var config string RedTeammateModelName;
var config bool bEnableDarkSkinning;
var config array<ClanSkinTripple> ClanSkins;
var config array<string> DisallowedEnemyNames;
var config bool bEnemyBasedModels;
var config bool bUseNewEyeHeightAlgorithm;

// UTComp_Overlay (team overlay)
var config float DesiredOnJoinMessageTime;
var config bool OverlayEnabled, bDrawIcons;
var config float VertPosition, HorizPosition;
var config Color BGColor, InfoTextColor, LocTextColor;
var config int theFontSize;

// UTComp_ScoreBoard
var config bool bEnableColoredNamesOnScoreboard;
var config bool bDrawStats;
var config bool bDrawPickups;
var config bool bOverrideDisplayStats;

// UTComp_xDeathMessage
var config bool drawcolorednamesindeathmessages;
var config bool bEnableTeamColoredDeaths;

// ModernPlayer
var config int MaxSavedMoves;
var config float SavedMovesWarningInterval;

// UTComp_xPawn (a stock xPawn setting, changed in the Miscellaneous menu)
var config bool bPlayOwnFootsteps;

// The one settings object, kept in the class defaults (see Get()).
var UTComp_ClientSettings Instance;

// Set in the defaults by MutUTComp on a dedicated server, where these are
// only the default settings: Init() then doesn't change or save anything.
var bool bDedicatedServer;

// Returns the settings object, creating it (and loading UTCompSHO.ini) the
// first time it's needed.
static final function UTComp_ClientSettings Get()
{
    if (default.Instance == None)
    {
        default.Instance = new(None, "ClientSettings") class'UTComp_ClientSettings';
        default.Instance.Init();
    }
    return default.Instance;
}

function Init()
{
    local bool bChanged;

    // The server also reads these (for example in UTComp_xPawn.Setup), but
    // they belong to the players. A server can share UTCompSHO.ini with a
    // player who plays from the same install, so leave the file alone.
    if (default.bDedicatedServer)
        return;

    if (bFirstRun)
    {
        // Keep the value the game already had.
        bPlayOwnFootsteps = class'UTComp_xPawn'.default.bPlayOwnFootsteps;

        // The default hit sounds are this package's. Their names start with
        // the package name, which changes with every release, so they are
        // set here instead of in the defaults.
        FriendlySound = ThisPackageName() $ ".Sounds.HitSoundFriendly";
        EnemySound = ThisPackageName() $ ".Sounds.HitSound";
    }

    // Saved sound names include the package name of the version that saved them.
    if (FixPackageName(FriendlySound, class'Sound'))
        bChanged = true;
    if (FixPackageName(EnemySound, class'Sound'))
        bChanged = true;

    ApplyToClasses();

    if (bChanged)
        SaveConfig();
}

// Saved object names (sounds, textures) start with the package name of the
// version that saved them, for example "UTCompSHOv1.Sounds.HitSound".
// If Path names an object from another UTComp package and this package has
// an object with the same name, Path is changed to point at it.
// Returns true if Path was changed.
static final function bool FixPackageName(out string Path, class<Object> ObjectClass)
{
    local string ThisPackage, NewPath;
    local int Dot;

    Dot = InStr(Path, ".");
    if (Dot <= 0 || !(Left(Path, 6) ~= "UTComp"))
        return false;

    ThisPackage = ThisPackageName();
    if (Left(Path, Dot) ~= ThisPackage)
        return false;

    NewPath = ThisPackage $ Mid(Path, Dot);
    if (DynamicLoadObject(NewPath, ObjectClass, true) == None)
        return false;

    Path = NewPath;
    return true;
}

// The name of this package, for example "UTCompSHOv1".
static final function string ThisPackageName()
{
    local string ClassPath;

    ClassPath = string(class'UTComp_ClientSettings');
    return Left(ClassPath, InStr(ClassPath, "."));
}

// Copies the settings that other classes keep in their default values.
function ApplyToClasses()
{
    class'UTComp_Overlay'.default.DesiredOnJoinMessageTime = DesiredOnJoinMessageTime;
    class'UTComp_Overlay'.default.OverlayEnabled = OverlayEnabled;
    class'UTComp_Overlay'.default.bDrawIcons = bDrawIcons;
    class'UTComp_Overlay'.default.VertPosition = VertPosition;
    class'UTComp_Overlay'.default.HorizPosition = HorizPosition;
    class'UTComp_Overlay'.default.BGColor = BGColor;
    class'UTComp_Overlay'.default.InfoTextColor = InfoTextColor;
    class'UTComp_Overlay'.default.LocTextColor = LocTextColor;
    class'UTComp_Overlay'.default.theFontSize = theFontSize;

    class'UTComp_ScoreBoard'.default.bEnableColoredNamesOnScoreboard = bEnableColoredNamesOnScoreboard;
    class'UTComp_ScoreBoard'.default.bDrawStats = bDrawStats;
    class'UTComp_ScoreBoard'.default.bDrawPickups = bDrawPickups;
    class'UTComp_ScoreBoard'.default.bOverrideDisplayStats = bOverrideDisplayStats;

    class'UTComp_xDeathMessage'.default.drawcolorednamesindeathmessages = drawcolorednamesindeathmessages;
    class'UTComp_xDeathMessage'.default.bEnableTeamColoredDeaths = bEnableTeamColoredDeaths;
    class'UTComp_InvasionDeathMessage'.default.drawcolorednamesindeathmessages = drawcolorednamesindeathmessages;
    class'UTComp_InvasionDeathMessage'.default.bEnableTeamColoredDeaths = bEnableTeamColoredDeaths;

    class'BS_xPlayer'.default.MaxSavedMoves = MaxSavedMoves;
    class'BS_xPlayer'.default.SavedMovesWarningInterval = SavedMovesWarningInterval;

    class'UTComp_xPawn'.default.bPlayOwnFootsteps = bPlayOwnFootsteps;
}

// The reverse of ApplyToClasses(): reads the values the menus changed.
function ReadFromClasses()
{
    DesiredOnJoinMessageTime = class'UTComp_Overlay'.default.DesiredOnJoinMessageTime;
    OverlayEnabled = class'UTComp_Overlay'.default.OverlayEnabled;
    bDrawIcons = class'UTComp_Overlay'.default.bDrawIcons;
    VertPosition = class'UTComp_Overlay'.default.VertPosition;
    HorizPosition = class'UTComp_Overlay'.default.HorizPosition;
    BGColor = class'UTComp_Overlay'.default.BGColor;
    InfoTextColor = class'UTComp_Overlay'.default.InfoTextColor;
    LocTextColor = class'UTComp_Overlay'.default.LocTextColor;
    theFontSize = class'UTComp_Overlay'.default.theFontSize;

    bEnableColoredNamesOnScoreboard = class'UTComp_ScoreBoard'.default.bEnableColoredNamesOnScoreboard;
    bDrawStats = class'UTComp_ScoreBoard'.default.bDrawStats;
    bDrawPickups = class'UTComp_ScoreBoard'.default.bDrawPickups;
    bOverrideDisplayStats = class'UTComp_ScoreBoard'.default.bOverrideDisplayStats;

    drawcolorednamesindeathmessages = class'UTComp_xDeathMessage'.default.drawcolorednamesindeathmessages;
    bEnableTeamColoredDeaths = class'UTComp_xDeathMessage'.default.bEnableTeamColoredDeaths;

    MaxSavedMoves = class'BS_xPlayer'.default.MaxSavedMoves;
    SavedMovesWarningInterval = class'BS_xPlayer'.default.SavedMovesWarningInterval;

    bPlayOwnFootsteps = class'UTComp_xPawn'.default.bPlayOwnFootsteps;
}

// Saves the settings to UTCompSHO.ini, including the ones the menus changed
// in other classes' default values.
function Save()
{
    ReadFromClasses();
    ApplyToClasses(); // so classes that share a setting (the death messages) agree
    SaveConfig();
}

defaultproperties
{
	bFirstRun=True
	bStats=True
	DemoRecordingMask="%d-(%t)-%m-%p"
	ScreenShotMask="%d-(%t)-%m-%p"
	bEnableHitSounds=True
	HitSoundVolume=1.000000
	bCPMAStyleHitsounds=True
	CPMAPitchModifier=1.400000
	SavedSpectateSpeed=800.000000
	bShowSelfInTeamOverlay=True
	bEnableEnhancedNetCode=True
	ballowcoloredmessages=True
	bEnableColoredNamesInTalk=True
	CurrentSelectedColoredName=255
	colorname(0)=(B=255,G=255,R=255,A=255)
	colorname(1)=(B=255,G=255,R=255,A=255)
	colorname(2)=(B=255,G=255,R=255,A=255)
	colorname(3)=(B=255,G=255,R=255,A=255)
	colorname(4)=(B=255,G=255,R=255,A=255)
	colorname(5)=(B=255,G=255,R=255,A=255)
	colorname(6)=(B=255,G=255,R=255,A=255)
	colorname(7)=(B=255,G=255,R=255,A=255)
	colorname(8)=(B=255,G=255,R=255,A=255)
	colorname(9)=(B=255,G=255,R=255,A=255)
	colorname(10)=(B=255,G=255,R=255,A=255)
	colorname(11)=(B=255,G=255,R=255,A=255)
	colorname(12)=(B=255,G=255,R=255,A=255)
	colorname(13)=(B=255,G=255,R=255,A=255)
	colorname(14)=(B=255,G=255,R=255,A=255)
	colorname(15)=(B=255,G=255,R=255,A=255)
	colorname(16)=(B=255,G=255,R=255,A=255)
	colorname(17)=(B=255,G=255,R=255,A=255)
	colorname(18)=(B=255,G=255,R=255,A=255)
	colorname(19)=(B=255,G=255,R=255,A=255)
	FallbackCharacterName="Arclite"
	ClientSkinModeRedTeammate=3
	ClientSkinModeBlueEnemy=3
	PreferredSkinColorRedTeammate=5
	PreferredSkinColorBlueEnemy=6
	BlueEnemyUTCompSkinColor=(B=128,A=255)
	RedTeammateUTCompSkinColor=(R=128,A=255)
	bBlueEnemyModelsForced=True
	bRedTeammateModelsForced=True
	BlueEnemyModelName="Arclite"
	RedTeammateModelName="Arclite"
	bEnableDarkSkinning=True
	DesiredOnJoinMessageTime=6.000000
	OverlayEnabled=True
	bDrawIcons=True
	VertPosition=0.070000
	HorizPosition=0.003000
	BGColor=(B=10,G=10,R=10,A=155)
	InfoTextColor=(B=255,G=255,R=255,A=255)
	LocTextColor=(B=155,G=155,R=155,A=255)
	theFontSize=-5
	bEnableColoredNamesOnScoreboard=True
	bDrawStats=True
	bDrawPickups=True
	bEnableTeamColoredDeaths=True
	MaxSavedMoves=750
	SavedMovesWarningInterval=5.000000
}
