//-----------------------------------------------------------
//
//-----------------------------------------------------------
class UTComp_Settings extends Info
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

defaultproperties
{
	bFirstRun=True
	bStats=True
	DemoRecordingMask="%d-(%t)-%m-%p"
	ScreenShotMask="%d-(%t)-%m-%p"
	FriendlySound="UTCompvBoM.Sounds.HitSoundFriendly"
	EnemySound="UTCompvBoM.Sounds.HitSound"
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
}
