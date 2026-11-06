

class UTComp_Menu_Voting_Settings extends UTComp_Menu_MainMenu;

var automated GUIComboBox co_Skins, co_Hitsounds, co_TeamOverlay;
var automated GUIComboBox co_Warmup,  co_NewNet;

var automated GUIButton bu_Skins, bu_Hitsounds, bu_TeamOverlay;
var automated GUIButton bu_Warmup,  bu_newNet;

var automated GUILabel l_Skins, l_HitSounds, l_TeamOverlay, l_Warmup;
var automated GUILabel l_Restart, l_NoRestart, l_NewNet;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(myController,MyOwner);

    co_Skins.AddItem("Epic Style");
    co_Skins.AddItem("Brighter Epic Style");
    co_Skins.AddItem("UTComp Style");

    co_HitSounds.AddItem("Disabled");
    co_HitSounds.AddItem("Line-Of-Sight");
    co_HitSounds.AddItem("Everywhere");

    co_TeamOverlay.AddItem("Disabled");
    co_TeamOverlay.AddItem("Enabled");

    co_Warmup.AddItem("Disabled");
    co_Warmup.AddItem("Enabled");


    co_newnet.AddItem("Disabled");
    co_newnet.AddItem("Enabled");

    co_Skins.REadOnly(True);
    co_HitSounds.ReadOnly(True);
    co_TeamOverlay.ReadOnly(True);
    co_Warmup.ReadOnly(True);
    co_newnet.ReadOnly(True);
    Blehz();
  //  co_Amp.bVisible=False;
}

function bool InternalOnClick( GUIComponent Sender )
{

    switch (Sender)
    {
        case bu_Skins:   BS_xPlayer(PlayerOwner()).CallVote(1, co_Skins.GetIndex(), "");  PlayerOwner().ClientCloseMenu();  break;
        case bu_hitsounds:   BS_xPlayer(PlayerOwner()).CallVote(2, co_Hitsounds.GetIndex(), "");   PlayerOwner().ClientCloseMenu(); break;
        case bu_TeamOverlay:  BS_xPlayer(PlayerOwner()).CallVote(3, co_TeamOverlay.GetIndex(), "");  PlayerOwner().ClientCloseMenu();  break;
        case bu_Warmup:  BS_xPlayer(PlayerOwner()).CallVote(4, co_Warmup.GetIndex(), ""); PlayerOwner().ClientCloseMenu(); break;
        case bu_NewNet:  BS_xPlayer(PlayerOwner()).CallVote(9, co_NewNet.GetIndex(), ""); PlayerOwner().ClientCloseMenu(); break;
    }
    return super.InternalOnClick(Sender);
}



function Blehz()
{
    local UTComp_ServerReplicationInfo RepInfo;

    foreach PlayerOwner().DynamicActors(class'UTComp_ServerReplicationInfo', RepInfo)
        break;

    if(RepInfo!=None && (!RepInfo.bEnableVoting || !RepInfo.bEnableBrightskinsVoting))
        co_Skins.DisableMe();
    else
        co_Skins.EnableMe();
    if(RepInfo!=None && (!RepInfo.bEnableVoting || !RepInfo.bEnableHitsoundsVoting))
        co_Hitsounds.DisableMe();
    else
        co_HitSounds.EnableMe();
    if(RepInfo!=None && (!RepInfo.bEnableVoting || !RepInfo.bEnableTeamOverlayVoting))
        co_TeamOverlay.DisableMe();
    else
        co_TeamOverlay.EnableMe();
    if(RepInfo!=None && (!RepInfo.bEnableVoting || !RepInfo.bEnableWarmupVoting))
        co_Warmup.DisableMe();
    else
        co_Warmup.EnableMe();
    if(RepInfo!=None && (!RepInfo.bEnableVoting || !RepInfo.bEnableEnhancedNetCodeVoting))
        co_NewNet.DisableMe();
    else
        co_NewNet.EnableMe();

    if(RepInfo!=None)
    {
        co_Skins.SetIndex(RepInfo.EnableBrightSkinsMode-1);
        co_HitSounds.SetIndex(RepInfo.EnableHitSoundsMode);
        if(RepInfo.bEnableTeamOverlay)
            co_TeamOverlay.SetIndex(1);
        if(RepInfo.bEnableWarmup)
            co_Warmup.SetIndex(1);
        if(RepInfo.bEnableEnhancedNetCode)
            co_NewNet.SetIndex(1);
    }
}

event Opened(GUIComponent Sender)
{
     super.Opened(Sender);
     Blehz();
}

defaultproperties
{
    Begin Object Class=XInterface.GUIComboBox Name=SkinsComboBox
        WinTop=0.4
        WinLeft=0.382187
        WinWidth=0.25
        WinHeight=0.03
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIComboBox Name=HitsoundsComboBox
        WinTop=0.45
        WinLeft=0.382187
        WinWidth=0.25
        WinHeight=0.03
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIComboBox Name=TeamOverlayComboBox
        WinTop=0.5
        WinLeft=0.382187
        WinWidth=0.25
        WinHeight=0.03
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIComboBox Name=WarmupComboBox
        WinTop=0.622918
        WinLeft=0.382187
        WinWidth=0.25
        WinHeight=0.035
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIComboBox Name=NewNetComboBox
        WinTop=0.672918
        WinLeft=0.382187
        WinWidth=0.25
        WinHeight=0.035
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=SkinsButton
        Caption="Call Vote"
        WinTop=0.395
        WinLeft=0.665625
        WinWidth=0.1175
        WinHeight=0.0425
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=HitsoundsButton
        Caption="Call Vote"
        WinTop=0.445
        WinLeft=0.665625
        WinWidth=0.1175
        WinHeight=0.0425
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=TeamOverlayButton
        Caption="Call Vote"
        WinTop=0.495
        WinLeft=0.665625
        WinWidth=0.1175
        WinHeight=0.0425
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=WarmupButton
        Caption="Call Vote"
        WinTop=0.615834
        WinLeft=0.665625
        WinWidth=0.1175
        WinHeight=0.0475
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=NewNetButton
        Caption="Call Vote"
        WinTop=0.665834
        WinLeft=0.665625
        WinWidth=0.1175
        WinHeight=0.0475
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUILabel Name=TeamOverlayLabel
        Caption="Team Overlay"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.495
        WinLeft=0.162
    End Object
    Begin Object Class=XInterface.GUILabel Name=WarmupLabel
        Caption="Warmup"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.611668
        WinLeft=0.160125
    End Object
    Begin Object Class=XInterface.GUILabel Name=NewNetLabel
        Caption="Enhanced Netcode"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.661667
        WinLeft=0.160125
    End Object
    Begin Object Class=XInterface.GUILabel Name=DemnoHeadingLabel
        Caption="--- These settings require a map reload to take effect ---"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.562085
        WinLeft=0.176562
    End Object
    Begin Object Class=XInterface.GUILabel Name=SkinsLabel
        Caption="Skins"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.395
        WinLeft=0.162
    End Object
    Begin Object Class=XInterface.GUILabel Name=HitsoundsLabel
        Caption="Hitsounds"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.445
        WinLeft=0.162
    End Object
    Begin Object Class=XInterface.GUILabel Name=RestartLabel
        Caption="--- These settings are applied instantly after the vote passes ---"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.332917
        WinLeft=0.11875
    End Object
    co_Skins=SkinsComboBox
    co_Hitsounds=HitsoundsComboBox
    co_TeamOverlay=TeamOverlayComboBox
    co_Warmup=WarmupComboBox
    co_NewNet=NewNetComboBox
    bu_Skins=SkinsButton
    bu_Hitsounds=HitsoundsButton
    bu_TeamOverlay=TeamOverlayButton
    bu_Warmup=WarmupButton
    bu_newNet=NewNetButton
    l_Skins=SkinsLabel
    l_HitSounds=HitsoundsLabel
    l_TeamOverlay=TeamOverlayLabel
    l_Warmup=WarmupLabel
    l_Restart=DemnoHeadingLabel
    l_NoRestart=RestartLabel
    l_NewNet=NewNetLabel
}
