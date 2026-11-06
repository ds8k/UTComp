

class UTComp_Menu_Voting extends UTComp_Menu_MainMenu;

var automated GUIButton bu_GameTypeMenu, bu_MapChangeMenu, bu_UTComp_SettingsMenu;

var automated GUILabel l_VotingLabel;

function bool InternalOnClick(GUIComponent C)
{
    switch(C)
    {
        case bu_GameTypeMenu:  PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_Voting_GameType"); break;
        case bu_MapChangeMenu:  PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_Voting_Map");  break;
        case bu_UTComp_SettingsMenu:  PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_Voting_Settings");    break;
    }
    Blehz();
    return super.InternalOnClick(C);
}

event Opened(guicomponent sender)
{
    Super.Opened(sender);

   Blehz();
}

function Blehz()
{
        local UTComp_ServerReplicationInfo RepInfo;

    foreach PlayerOwner().DynamicActors(class'UTComp_ServerReplicationInfo', RepInfo)
         break;
    if((RepInfo.bEnableMapVoting==false && RepInfo.bAllowRestartVoteEvenIfMapVotingIsTurnedOff == false) || RepInfo.bEnableVoting==false)
        bu_MapChangeMenu.DisableMe();
    else
        bu_MapChangeMenu.EnableMe();
    if(RepInfo.bEnableVoting==False)
        bu_UTComp_SettingsMenu.DisableMe();
    else
        bu_UTComp_SettingsMenu.EnableMe();
    if(RepInfo.bEnableMapVoting==False || RepInfo.bEnableVoting==False || RepInfo.bEnableGameTypeVoting==False)
        bu_GameTypeMenu.DisableMe();
    else
        bu_GameTypeMenu.EnableMe();
}

defaultproperties
{
    Begin Object Class=XInterface.GUIButton Name=GameTypeButton
        Caption="Gametype"
        WinTop=0.572916
        WinLeft=0.3125
        WinWidth=0.18
        WinHeight=0.123437
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=MapChangeButton
        Caption="Change Map"
        WinTop=0.449999
        WinLeft=0.315625
        WinWidth=0.373751
        WinHeight=0.123437
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=UTComp_SettingsButton
        Caption="Settings"
        WinTop=0.572916
        WinLeft=0.512501
        WinWidth=0.18
        WinHeight=0.123437
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUILabel Name=DemnoHeadingLabel
        Caption="------- Select your voting type -------"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.385
        WinLeft=0.28125
    End Object
    bu_GameTypeMenu=GameTypeButton
    bu_MapChangeMenu=MapChangeButton
    bu_UTComp_SettingsMenu=UTComp_SettingsButton
    l_VotingLabel=DemnoHeadingLabel
}
