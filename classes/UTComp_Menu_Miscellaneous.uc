

class UTComp_Menu_Miscellaneous extends UTComp_Menu_MainMenu;

var automated GUILabel l_ScoreboardTitle;
var automated GUILabel l_InfoTitle;
var automated GUILabel l_GenericTitle;
var automated GUILabel l_CrossScale;
var automated GUILabel l_NewNet;


var automated moCheckBox ch_UseScoreBoard;
var automated moCheckBox ch_WepStats;
var automated moCheckBox ch_PickupStats;
var automated moCheckBox ch_FootSteps;
var automated moCheckBox ch_MatchHudColor;
var automated moCheckBox ch_UseEyeHeightAlgo;
var automated moCheckBox ch_UseNewNet;

var automated GUIButton bu_adren;

var automated moComboBox co_CrosshairScale;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    super.InitComponent(MyController,MyOwner);

    ch_UseScoreboard.Checked(!class'UTComp_Settings'.default.bUseDefaultScoreboard);
    ch_WepStats.Checked(class'UTComp_Scoreboard'.default.bDrawStats);
    ch_PickupStats.Checked(class'UTComp_Scoreboard'.default.bDrawPickups);
    ch_FootSteps.Checked(class'UTComp_xPawn'.default.bPlayOwnFootSteps);
    ch_MatchHudColor.Checked(class'UTComp_HudSettings'.default.bMatchHudColor);
    ch_UseEyeHeightAlgo.Checked(class'UTComp_Settings'.default.bUseNewEyeHeightAlgorithm);
    ch_UseNewNet.Checked(class'UTComp_Settings'.default.bEnableEnhancedNetCode);
}

function InternalOnChange( GUIComponent C )
{
    switch(C)
    {
        case ch_UseScoreboard: class'UTComp_Settings'.default.bUseDefaultScoreboard=!ch_UseScoreBoard.IsChecked(); break;
        case ch_WepStats:  class'UTComp_Scoreboard'.default.bDrawStats=ch_WepStats.IsChecked();
                           BS_xPlayer(PlayerOwner()).SetBStats(class'UTComp_Scoreboard'.default.bDrawStats);break;
        case ch_PickupStats:  class'UTComp_Scoreboard'.default.bDrawPickups=ch_PickupStats.IsChecked(); break;
        case ch_FootSteps: class'UTComp_xPawn'.default.bPlayOwnFootSteps=ch_FootSteps.IsChecked(); break;
        case ch_MatchHudColor:  class'UTComp_HudSettings'.default.bMatchHudColor=ch_MatchHudColor.IsChecked(); break;
        case ch_UseEyeHeightAlgo:
            class'UTComp_Settings'.default.bUseNewEyeHeightAlgorithm=ch_UseEyeHeightAlgo.IsChecked();
            BS_xPlayer(PlayerOwner()).SetEyeHeightAlgorithm(ch_UseEyeHeightAlgo.IsChecked());
            break;
        case ch_UseNewNet:  class'UTComp_Settings'.default.bEnableEnhancedNetCode=ch_UseNewNet.IsChecked();
                            BS_xPlayer(PlayerOwner()).TurnOffNetCode(); break;
    }
    class'UTComp_Overlay'.static.StaticSaveConfig();
    class'BS_xPlayer'.static.StaticSaveConfig();
    class'UTComp_Settings'.static.staticSaveConfig();
    class'UTComp_Scoreboard'.static.StaticSaveConfig();
    class'UTComp_xPawn'.static.StaticSaveConfig();
    class'UTComp_HudCDeathMatch'.Static.StaticSaveConfig();
    class'UTComp_HudSettings'.static.StaticSaveConfig();
    BS_xPlayer(PlayerOwner()).MakeSureSaveConfig();
    BS_xPlayer(PlayerOwner()).MatchHudColor();

}

function bool InternalOnClick(GUIComponent C)
{
    switch(C)
    {
        case bu_Adren:  PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_AdrenMenu"); break;
    }
    return super.InternalOnClick(C);
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
    if (Key == 0x1B)
        return false;
    return true;
}

defaultproperties
{
    Begin Object Class=XInterface.moCheckBox Name=HudColorCheck
        Caption="Match Hud Color To Skins"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.61
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=ScoreboardCheck
        Caption="Use UTComp enhanced scoreboard."
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.33
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=StatsCheck
        Caption="Show weapon stats on scoreboard."
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.37
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=PickupCheck
        Caption="Show pickup stats on scoreboard."
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.41
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.GUIButton Name=AdrenButton
        Caption="Disable Adrenaline Combos"
        WinTop=0.49
        WinLeft=0.25
        WinWidth=0.4
        WinHeight=0.05
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.moCheckBox Name=FootCheck
        Caption="Play own footstep sounds."
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.57
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=NewNetCheck
        Caption="Enable Enhanced Netcode"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.73
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.GUILabel Name=ScoreboardLabel
        Caption="----------Scoreboard----------"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.29
        WinLeft=0.25
    End Object
    Begin Object Class=XInterface.GUILabel Name=InfoLabel
        Caption="--------Adrenaline Combos--------"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.45
        WinLeft=0.25
    End Object
    Begin Object Class=XInterface.GUILabel Name=GenericLabel
        Caption="----Generic UT2004 Settings----"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.53
        WinLeft=0.25
    End Object
    Begin Object Class=XInterface.moCheckBox Name=UseEyeHeightAlgoCheck
        Caption="Use New EyeHeight Algorithm"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.65
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.GUILabel Name=NewNetLabel
        Caption="-----------Net Code-----------"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.69
        WinLeft=0.25
    End Object
    l_ScoreboardTitle=ScoreboardLabel
    l_InfoTitle=InfoLabel
    l_GenericTitle=GenericLabel
    l_NewNet=NewNetLabel
    ch_UseScoreBoard=ScoreboardCheck
    ch_WepStats=StatsCheck
    ch_PickupStats=PickupCheck
    ch_FootSteps=FootCheck
    ch_MatchHudColor=HudColorCheck
    ch_UseEyeHeightAlgo=UseEyeHeightAlgoCheck
    ch_UseNewNet=NewNetCheck
    bu_adren=AdrenButton
}
