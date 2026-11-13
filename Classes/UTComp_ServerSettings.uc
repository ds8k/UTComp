//-----------------------------------------------------------
// A copy of the MutUTComp server settings that doesn't depend on the
// package name.
//
// MutUTComp's settings are saved as [<Package>.MutUTComp] in the server's
// UT2004.ini, so every new version (a new package name) would start from the
// default settings. WebAdmin can only edit that section, so it stays the main
// copy. This class keeps a second copy in the same ini (UT2004.ini, or the
// file given with -ini=), as [ServerSettings UTComp_ServerSettings]:
//   - MutUTComp saves its settings here at the start of every map and when
//     they change (map change, votes; WebAdmin changes are picked up at the
//     next map change).
//   - The first time a new version runs, MutUTComp copies them from here into
//     its own section (see MutUTComp.ImportServerSettings).
// Being in the server's own ini, each server in an install keeps its own copy.
//
// The variables below are generated from MutUTComp's config variables; keep
// them, SaveFrom() and ApplyTo() in step when MutUTComp gets a new setting.
//-----------------------------------------------------------
class UTComp_ServerSettings extends Object
    Config
    PerObjectConfig;

var config bool bSaved;            // true once a server has saved settings here
var config string SavedByPackage;  // the package that saved them, e.g. UTCompSHOv1

var config bool bEnableVoting;
var config bool bEnableBrightskinsVoting;
var config bool bEnableHitsoundsVoting;
var config bool bEnableWarmupVoting;
var config bool bEnableTeamOverlayVoting;
var config bool bEnableMapVoting;
var config bool bEnableGametypeVoting;
var config bool bEnableTimedOvertimeVoting;
var config float VotingPercentRequired;
var config float VotingTimeLimit;
var config bool bEnableDoubleDamage;
var config byte EnableBrightSkinsMode;
var config bool bEnableClanSkins;
var config bool bEnableTeamOverlay;
var config byte EnableHitSoundsMode;
var config bool bEnableScoreboard;
var config bool bEnableWarmup;
var config float WarmupReadyPercentRequired;
var config bool bEnableWeaponStats;
var config bool bEnablePowerupStats;
var config bool bShowTeamScoresInServerBrowser;
var config byte ServerMaxPlayers;
var config bool bEnableAdvancedVotingOptions;
var config array<string> AlwaysUseThisMutator;
var config bool bEnableAutoDemoRec;
var config string AutoDemoRecMask;
var config byte EnableWarmupWeaponsMode;
var config int WarmupTime;
var config int WarmupHealth;
var config bool bForceMapVoteMatchPrefix;
var config bool bEnableTimedOvertime;
var config int TimedOverTimeLength;
var config int NumGrenadesOnSpawn;
var config bool bShieldFix;
var config bool bAllowRestartVoteEvenIfMapVotingIsTurnedOff;
var config int MaxMultiDodges;
var config int MinNetSpeed;
var config int MaxNetSpeed;
var config array<MutUTComp.MapVotePair> VotingGametype;
var config bool bEnableEnhancedNetCode;
var config bool bEnableEnhancedNetCodeVoting;

// The one settings object, kept in the class defaults (see Get()).
var UTComp_ServerSettings Instance;

static final function UTComp_ServerSettings Get()
{
    if (default.Instance == None)
        default.Instance = new(None, "ServerSettings") class'UTComp_ServerSettings';
    return default.Instance;
}

// Saves MutUTComp's current settings (its default values, which WebAdmin and
// the votes change) to the server's ini.
function SaveFrom(MutUTComp M)
{
    bEnableVoting = M.default.bEnableVoting;
    bEnableBrightskinsVoting = M.default.bEnableBrightskinsVoting;
    bEnableHitsoundsVoting = M.default.bEnableHitsoundsVoting;
    bEnableWarmupVoting = M.default.bEnableWarmupVoting;
    bEnableTeamOverlayVoting = M.default.bEnableTeamOverlayVoting;
    bEnableMapVoting = M.default.bEnableMapVoting;
    bEnableGametypeVoting = M.default.bEnableGametypeVoting;
    bEnableTimedOvertimeVoting = M.default.bEnableTimedOvertimeVoting;
    VotingPercentRequired = M.default.VotingPercentRequired;
    VotingTimeLimit = M.default.VotingTimeLimit;
    bEnableDoubleDamage = M.default.bEnableDoubleDamage;
    EnableBrightSkinsMode = M.default.EnableBrightSkinsMode;
    bEnableClanSkins = M.default.bEnableClanSkins;
    bEnableTeamOverlay = M.default.bEnableTeamOverlay;
    EnableHitSoundsMode = M.default.EnableHitSoundsMode;
    bEnableScoreboard = M.default.bEnableScoreboard;
    bEnableWarmup = M.default.bEnableWarmup;
    WarmupReadyPercentRequired = M.default.WarmupReadyPercentRequired;
    bEnableWeaponStats = M.default.bEnableWeaponStats;
    bEnablePowerupStats = M.default.bEnablePowerupStats;
    bShowTeamScoresInServerBrowser = M.default.bShowTeamScoresInServerBrowser;
    ServerMaxPlayers = M.default.ServerMaxPlayers;
    bEnableAdvancedVotingOptions = M.default.bEnableAdvancedVotingOptions;
    AlwaysUseThisMutator = M.default.AlwaysUseThisMutator;
    bEnableAutoDemoRec = M.default.bEnableAutoDemoRec;
    AutoDemoRecMask = M.default.AutoDemoRecMask;
    EnableWarmupWeaponsMode = M.default.EnableWarmupWeaponsMode;
    WarmupTime = M.default.WarmupTime;
    WarmupHealth = M.default.WarmupHealth;
    bForceMapVoteMatchPrefix = M.default.bForceMapVoteMatchPrefix;
    bEnableTimedOvertime = M.default.bEnableTimedOvertime;
    TimedOverTimeLength = M.default.TimedOverTimeLength;
    NumGrenadesOnSpawn = M.default.NumGrenadesOnSpawn;
    bShieldFix = M.default.bShieldFix;
    bAllowRestartVoteEvenIfMapVotingIsTurnedOff = M.default.bAllowRestartVoteEvenIfMapVotingIsTurnedOff;
    MaxMultiDodges = M.default.MaxMultiDodges;
    MinNetSpeed = M.default.MinNetSpeed;
    MaxNetSpeed = M.default.MaxNetSpeed;
    VotingGametype = M.default.VotingGametype;
    bEnableEnhancedNetCode = M.default.bEnableEnhancedNetCode;
    bEnableEnhancedNetCodeVoting = M.default.bEnableEnhancedNetCodeVoting;

    SavedByPackage = string(M.Class);
    SavedByPackage = Left(SavedByPackage, InStr(SavedByPackage, "."));
    bSaved = true;
    SaveConfig();
}

// Copies these settings into MutUTComp's default values and into the running
// mutator M. References to the package that saved them are changed to M's
// package.
function ApplyTo(MutUTComp M)
{
    local string ThisPackage;
    local int i;

    M.default.bEnableVoting = bEnableVoting;
    M.bEnableVoting = bEnableVoting;
    M.default.bEnableBrightskinsVoting = bEnableBrightskinsVoting;
    M.bEnableBrightskinsVoting = bEnableBrightskinsVoting;
    M.default.bEnableHitsoundsVoting = bEnableHitsoundsVoting;
    M.bEnableHitsoundsVoting = bEnableHitsoundsVoting;
    M.default.bEnableWarmupVoting = bEnableWarmupVoting;
    M.bEnableWarmupVoting = bEnableWarmupVoting;
    M.default.bEnableTeamOverlayVoting = bEnableTeamOverlayVoting;
    M.bEnableTeamOverlayVoting = bEnableTeamOverlayVoting;
    M.default.bEnableMapVoting = bEnableMapVoting;
    M.bEnableMapVoting = bEnableMapVoting;
    M.default.bEnableGametypeVoting = bEnableGametypeVoting;
    M.bEnableGametypeVoting = bEnableGametypeVoting;
    M.default.bEnableTimedOvertimeVoting = bEnableTimedOvertimeVoting;
    M.bEnableTimedOvertimeVoting = bEnableTimedOvertimeVoting;
    M.default.VotingPercentRequired = VotingPercentRequired;
    M.VotingPercentRequired = VotingPercentRequired;
    M.default.VotingTimeLimit = VotingTimeLimit;
    M.VotingTimeLimit = VotingTimeLimit;
    M.default.bEnableDoubleDamage = bEnableDoubleDamage;
    M.bEnableDoubleDamage = bEnableDoubleDamage;
    M.default.EnableBrightSkinsMode = EnableBrightSkinsMode;
    M.EnableBrightSkinsMode = EnableBrightSkinsMode;
    M.default.bEnableClanSkins = bEnableClanSkins;
    M.bEnableClanSkins = bEnableClanSkins;
    M.default.bEnableTeamOverlay = bEnableTeamOverlay;
    M.bEnableTeamOverlay = bEnableTeamOverlay;
    M.default.EnableHitSoundsMode = EnableHitSoundsMode;
    M.EnableHitSoundsMode = EnableHitSoundsMode;
    M.default.bEnableScoreboard = bEnableScoreboard;
    M.bEnableScoreboard = bEnableScoreboard;
    M.default.bEnableWarmup = bEnableWarmup;
    M.bEnableWarmup = bEnableWarmup;
    M.default.WarmupReadyPercentRequired = WarmupReadyPercentRequired;
    M.WarmupReadyPercentRequired = WarmupReadyPercentRequired;
    M.default.bEnableWeaponStats = bEnableWeaponStats;
    M.bEnableWeaponStats = bEnableWeaponStats;
    M.default.bEnablePowerupStats = bEnablePowerupStats;
    M.bEnablePowerupStats = bEnablePowerupStats;
    M.default.bShowTeamScoresInServerBrowser = bShowTeamScoresInServerBrowser;
    M.bShowTeamScoresInServerBrowser = bShowTeamScoresInServerBrowser;
    M.default.ServerMaxPlayers = ServerMaxPlayers;
    M.ServerMaxPlayers = ServerMaxPlayers;
    M.default.bEnableAdvancedVotingOptions = bEnableAdvancedVotingOptions;
    M.bEnableAdvancedVotingOptions = bEnableAdvancedVotingOptions;
    M.default.AlwaysUseThisMutator = AlwaysUseThisMutator;
    M.AlwaysUseThisMutator = AlwaysUseThisMutator;
    M.default.bEnableAutoDemoRec = bEnableAutoDemoRec;
    M.bEnableAutoDemoRec = bEnableAutoDemoRec;
    M.default.AutoDemoRecMask = AutoDemoRecMask;
    M.AutoDemoRecMask = AutoDemoRecMask;
    M.default.EnableWarmupWeaponsMode = EnableWarmupWeaponsMode;
    M.EnableWarmupWeaponsMode = EnableWarmupWeaponsMode;
    M.default.WarmupTime = WarmupTime;
    M.WarmupTime = WarmupTime;
    M.default.WarmupHealth = WarmupHealth;
    M.WarmupHealth = WarmupHealth;
    M.default.bForceMapVoteMatchPrefix = bForceMapVoteMatchPrefix;
    M.bForceMapVoteMatchPrefix = bForceMapVoteMatchPrefix;
    M.default.bEnableTimedOvertime = bEnableTimedOvertime;
    M.bEnableTimedOvertime = bEnableTimedOvertime;
    M.default.TimedOverTimeLength = TimedOverTimeLength;
    M.TimedOverTimeLength = TimedOverTimeLength;
    M.default.NumGrenadesOnSpawn = NumGrenadesOnSpawn;
    M.NumGrenadesOnSpawn = NumGrenadesOnSpawn;
    M.default.bShieldFix = bShieldFix;
    M.bShieldFix = bShieldFix;
    M.default.bAllowRestartVoteEvenIfMapVotingIsTurnedOff = bAllowRestartVoteEvenIfMapVotingIsTurnedOff;
    M.bAllowRestartVoteEvenIfMapVotingIsTurnedOff = bAllowRestartVoteEvenIfMapVotingIsTurnedOff;
    M.default.MaxMultiDodges = MaxMultiDodges;
    M.MaxMultiDodges = MaxMultiDodges;
    M.default.MinNetSpeed = MinNetSpeed;
    M.MinNetSpeed = MinNetSpeed;
    M.default.MaxNetSpeed = MaxNetSpeed;
    M.MaxNetSpeed = MaxNetSpeed;
    M.default.VotingGametype = VotingGametype;
    M.VotingGametype = VotingGametype;
    M.default.bEnableEnhancedNetCode = bEnableEnhancedNetCode;
    M.bEnableEnhancedNetCode = bEnableEnhancedNetCode;
    M.default.bEnableEnhancedNetCodeVoting = bEnableEnhancedNetCodeVoting;
    M.bEnableEnhancedNetCodeVoting = bEnableEnhancedNetCodeVoting;

    ThisPackage = string(M.Class);
    ThisPackage = Left(ThisPackage, InStr(ThisPackage, "."));

    // Game type votes add these mutators, so an older UTComp here (for example
    // "UTCompSHOv1.MutUTComp") would load that version as well.
    for (i = 0; i < M.AlwaysUseThisMutator.Length; i++)
        if (Left(M.AlwaysUseThisMutator[i], 6) ~= "UTComp" && Right(M.AlwaysUseThisMutator[i], 10) ~= ".MutUTComp")
            M.AlwaysUseThisMutator[i] = string(M.Class);

    if (SavedByPackage != "" && !(SavedByPackage ~= ThisPackage))
        for (i = 0; i < M.VotingGametype.Length; i++)
            M.VotingGametype[i].GametypeOptions = Repl(M.VotingGametype[i].GametypeOptions, SavedByPackage $ ".", ThisPackage $ ".");

    M.default.AlwaysUseThisMutator = M.AlwaysUseThisMutator;
    M.default.VotingGametype = M.VotingGametype;
}

defaultproperties
{
}