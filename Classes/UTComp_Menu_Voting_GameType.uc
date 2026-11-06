

class UTComp_Menu_Voting_GameType extends UTComp_Menu_MainMenu;

var automated GUIListBox lb_MapList;

var automated GUIEditBox eb_MapInput;
var automated GUINumericEdit ne_NumPlayers;
var automated GUIComboBox co_GameTypeList;

var automated GUIButton bu_QuickRestart, bu_ChangeMap;

var automated GUILabel l_MapName, l_GameType, l_MaxPlayers;

var automated moCheckBox cb_UseAdvancedOptions;
var automated moCheckBox cb_Adren, cb_DD, cb_SuperWeapons, cb_WeaponStay;

var automated GUINumericEdit ne_GoalScore, ne_TimeLimit, ne_Grenades, ne_OverTime;
var automated GUILabel l_GoalScore, l_TimeLimit, l_grenades, l_OverTime;

var automated GUIButton bu_Refresh;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{

    Super.Initcomponent(MyController, MyOwner);
    ne_Grenades.SetValue(4);
    Blehz();
}

function InternalOnChange( GUIComponent C )
{
    Switch(C)
    {
       case lb_MapList:  eb_MapInput.SetText(lb_MapList.List.SelectedText()); break;
       case cb_UseAdvancedOptions: NewFunc(); break;
       case co_GameTypeList:  NewFunc(); RefreshMapList(); NE_numPlayersSetValue(); break;

    }
}

function Blehz()
{
    local UTComp_ServerReplicationInfo RepInfo;
    local int i;


    foreach PlayerOwner().DynamicActors(class'UTComp_ServerReplicationInfo', RepInfo)
        break;
    co_GameTypeList.ReadOnly(False);
    co_GameTypeList.Clear();
    for(i=0; RepInfo!=None && i<ArrayCount(RepInfo.VotingNames); i++)
    {
        if(RepInfo.VotingNames[i]!="")
            co_GameTypeList.AddItem(RepInfo.VotingNames[i]);
    }
    co_GameTypeList.ReadOnly(True);

 /*   if(RepInfo!=None && !RepInfo.bEnableWarmup)
        bu_QuickRestart.DisableMe();
    else
       bu_QuickRestart.EnableMe();  */
    ne_NumPlayers.SetValue(RepInfo.MaxPlayersClone);
    NE_NumPlayersSetValue();
    ne_NumPlayers.MaxValue=RepInfo.ServerMaxPlayers;

    l_MaxPlayers.Caption="Max Players(Max "$RepInfo.ServerMaxPlayers$")";

    bu_QuickRestart.DisableMe();
    Newfunc();
}

function NE_NumPlayersSetValue()
{
    local int i;
    local string S;
    S = co_gameTypeList.GetText();
    if(S == "1v1")
        i = 2;
    else if(S == "FFA")
        i = 8;
    else if(S == "Team Deathmatch")
        i = 8;
    else if(S == "Capture the Flag")
        i = 10;
    else if(S == "Onslaught")
        i = 12;
    else if(S == "Assault")
        i = 12;
    else if(S == "Double Domination")
        i = 8;
    else if(S == "Bombing Run")
        i =10;
    else if(S == "Clan Arena")
        i =8;
    else
        return;
    ne_numPlayers.SetValue(i);
}

function NewFunc()
{
    local UTComp_ServerReplicationInfo RepInfo;
    local array<string> Parts;
    local int i;
    local bool MutsFound, ddFound;

    foreach PlayerOwner().DynamicActors(class'UTComp_ServerReplicationInfo', RepInfo)
        break;

    if(RepInfo==None || RepInfo.bEnableAdvancedVotingOptions)
        cb_UseAdvancedOptions.EnableMe();
    else
        cb_UseAdvancedOptions.DisableMe();

    if(cb_UseAdvancedOptions.IsChecked() && (RepInfo==None || RepInfo.bEnableAdvancedVotingOptions))
    {
         ne_GoalScore.EnableMe();
         ne_TimeLimit.EnableMe();
         ne_Grenades.EnableMe();
         ne_OverTime.EnableMe();
         cb_Adren.EnableMe();
         cb_DD.EnableMe();
         cb_SuperWeapons.EnableMe();
         cb_WeaponStay.EnableMe();
         l_GoalScore.EnableMe();
         l_TimeLimit.EnableMe();
         l_Grenades.EnableMe();
         l_OverTime.EnableMe();
    }
    else
    {
         ne_GoalScore.disableme();
         ne_TimeLimit.disableme();
         ne_Grenades.DisableMe();
         ne_OverTime.DisableMe();
         cb_Adren.disableme();
         cb_DD.disableme();
         cb_SuperWeapons.disableme();
         cb_WeaponStay.disableme();
         l_GoalScore.disableme();
         l_TimeLimit.disableme();
         l_Grenades.disableme();
         l_OverTime.disableme();
    }

    if(RepInfo==None)
        return;

    if(co_GameTypeList.GetIndex()>=0 &&  co_GameTypeList.GetIndex()<ArrayCount(RepInfo.VotingOptions))
        Split(RepInfo.VotingOptions[co_GameTypeList.GetIndex()], "?", Parts);
    for(i=0; i<Parts.Length; i++)
    {
        if(Left(Parts[i],10)~="GoalScore=")
        {
            ne_GoalScore.SetValue(int(Right(Parts[i], Len(Parts[i])-10)));
        }
        else if(Left(Parts[i],10)~="TimeLimit=")
        {
            ne_TimeLimit.SetValue(int(Right(Parts[i], Len(Parts[i])-10)));
        }
        else if(Left(Parts[i],16)~="GrenadesOnSpawn=")
        {
            ne_Grenades.SetValue(int(Right(Parts[i], Len(Parts[i])-16)));
        }
        else if(Left(Parts[i],20)~="TimedOverTimeLength=")
        {
            ne_OverTime.SetValue(int(Right(Parts[i], Len(Parts[i])-20)));
        }
        else if(Left(Parts[i],8)~="Mutator=")
        {
            cb_Adren.Checked(!InStrNonCaseSensitive(Parts[i], "xGame.MutNoAdrenaline"));
            cb_SuperWeapons.Checked(!InStrNonCaseSensitive(Parts[i], "xWeapons.MutNoSuperWeapon"));
            MutsFound=True;
        }
        else if(Left(Parts[i],13)~="DoubleDamage=")
        {
             cb_DD.Checked(Right(Parts[i], Len(Parts[i])-13)~="True");
             ddFound=True;
        }
        else if(Left(Parts[i],11)~="WeaponStay=")
        {
             cb_WeaponStay.Checked(Right(Parts[i], Len(Parts[i])-11)~="True");
        }
    }
    if(!MutsFound)
    {
       cb_Adren.Checked(True);
       cb_SuperWeapons.Checked(True);
    }
    if(!ddFound)
    {
        cb_DD.Checked(RepInfo==None || RepInfo.bEnableDoubleDamage);
    }
}

simulated function bool InStrNonCaseSensitive(String S, string S2)
{                                //S2 in S
    local int i;
    for(i=0; i<=(Len(S)-Len(S2)); i++)
    {
        if(Mid(S, i, Len(s2))~=S2)
            return true;
    }
    return false;
}


function bool InternalOnClick( GUIComponent Sender )
{

    local UTComp_ServerReplicationInfo RepInfo;
    foreach PlayerOwner().DynamicActors(class'UTComp_ServerReplicationInfo', RepInfo)
        break;

    switch (Sender)
    {
        case bu_ChangeMap:    ne_NumPlayers.SetValue(Min(int(ne_NumPlayers.Value), RepInfo.ServerMaxPlayers));
                              if(eb_MapInput.GetText()!="")
                                  BS_xPlayer(PlayerOwner()).CallVote(6, co_GameTypeList.GetIndex(), eb_MapInput.GetText(), int(ne_NumPlayers.Value), ConstructMapTravelText());
                              else
                                  BS_xPlayer(PlayerOwner()).CallVote(6, co_GameTypeList.GetIndex(), lb_MapList.List.SelectedText(), int(ne_NumPlayers.Value), ConstructMapTravelText());
                              PlayerOwner().ClientCloseMenu();  break;
        case  bu_QuickRestart:  BS_xPlayer(PlayerOwner()).CallVote(5);
                              PlayerOwner().ClientCloseMenu();  break;
        case bu_Refresh:  RefreshMapList(); break;

    }
    return super.InternalOnClick(Sender);
}

function RefreshMapList()
{
    local int i;
    local UTComp_ServerReplicationInfo RepInfo;
    local string filter;
    local class<GameInfo> G;
    local array<string> Parts;
    local string S;

    foreach PlayerOwner().DynamicActors(class'UTComp_ServerReplicationInfo', RepInfo)
        break;

    lb_MapList.List.Clear();
    if(RepInfo!=None)
    {
        Split(RepInfo.VotingOptions[co_GameTypeList.GetIndex()], "?", parts);
        for(i=0; i<parts.length; i++)
        {
            if(Left(parts[i], 5) ~="Game=")
                S=right(parts[i], len(parts[i])-5);
        }
        G=class<GameInfo>(DynamicLoadObject(S, class'class', true));
        if(S!="" && G!=None)
            filter=G.default.MapPrefix;
    }

    for(i=0; i<BS_xPlayer(PlayerOwner()).UTCompPRI.UTCompMapListclient.Length; i++)
    {
    //   Log("Adding"@BS_xPlayer(PlayerOwner()).UTCompPRI.UTCompMapListclient[i]);
       if(filter == "" || Left(BS_xPlayer(PlayerOwner()).UTCompPRI.UTCompMapListclient[i], len(filter))~=filter)
           lb_MapList.List.Add(BS_xPlayer(PlayerOwner()).UTCompPRI.UTCompMapListclient[i]);
    }
    if(BS_xPlayer(PlayerOwner()).UTCompPRI.TotalMapsToBeReceived<BS_xPlayer(PlayerOwner()).UTCompPRI.UTCompMapListclient.Length)
    {
  //      lb_MapList.DisableMe();
    }
    else
        lb_MapList.EnableMe();
}

function string ConstructMapTravelText()
{
    local string S;

    if(!cb_UseAdvancedOptions.IsChecked())
        return "";

     S=S$"?DoubleDamage="$GetTrueFalse(cb_DD.IsChecked());
     S=S$"?Adren="$GetTrueFalse(!cb_Adren.IsChecked());
     S=S$"?Timelimit="$ne_TimeLimit.Value;
     S=S$"?TimedOverTimeLength="$ne_OverTime.Value;
     S=S$"?GrenadesOnSpawn="$ne_Grenades.Value;
     S=S$"?GoalScore="$ne_GoalScore.Value;
     S=S$"?SuperWeps="$GetTrueFalse(!cb_SuperWeapons.IsChecked());
     S=S$"?WeaponStay="$GetTrueFalse(cb_WeaponStay.IsChecked());
     return S;
}

function string GetTrueFalse(bool b)
{
   if(b)
       return "true";
   return "false";
}

event Opened(GUIComponent Sender)
{
    super.Opened(Sender);
    cb_UseAdvancedOptions.Checked(False);
    refreshmaplist();
    Blehz();
    eb_MapInput.SetText(lb_MapList.List.SelectedText());
}

defaultproperties
{
    Begin Object Class=XInterface.GUIEditBox Name=MapInputEditBox
        WinTop=0.4625
        WinLeft=0.559687
        WinWidth=0.25
        WinHeight=0.03
        OnActivate=InternalActivate
        OnDeActivate=InternalDeactivate
        OnKeyType=InternalOnKeyType
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUINumericEdit Name=MaxPlayersNE
        MinValue=2
        WinTop=0.414046
        WinLeft=0.604999
        WinWidth=0.20625
        WinHeight=0.03
        OnDeActivate=ValidateValue
    End Object
    Begin Object Class=XInterface.GUIComboBox Name=MapInputComboBox
        WinTop=0.362994
        WinLeft=0.560311
        WinWidth=0.25
        WinHeight=0.035
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=quickrestartButton
        Caption="Just Restart Map"
        WinTop=0.705418
        WinLeft=0.379687
        WinWidth=0.2175
        WinHeight=0.0475
        bVisible=False
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=ChangeMapButton
        Caption="Call Vote"
        WinTop=0.740469
        WinLeft=0.456252
        WinWidth=0.262813
        WinHeight=0.0475
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIListBox Name=MapListBox
        bVisibleWhenEmpty=True
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.35
        WinLeft=0.11875
        WinWidth=0.214061
        WinHeight=0.385937
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=AdrenCheck
        Caption="Adren"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.549998
        WinLeft=0.598437
        WinWidth=0.239062
    End Object
    Begin Object Class=XInterface.moCheckBox Name=WeaponStayCheck
        Caption="WeaponStay"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.65
        WinLeft=0.35
        WinWidth=0.24
    End Object
    Begin Object Class=XInterface.moCheckBox Name=DDCheck
        Caption="DD"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.6
        WinLeft=0.35
        WinWidth=0.24
    End Object
    Begin Object Class=XInterface.moCheckBox Name=SuperWeaponsCheck
        Caption="SuperWeapons"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.55
        WinLeft=0.35
        WinWidth=0.24
    End Object
    Begin Object Class=XInterface.moCheckBox Name=AdvancedOptionsCheck
        Caption="Advanced Options"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.5
        WinLeft=0.35
        WinWidth=0.24
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.GUINumericEdit Name=GoalScoreNE
        MinValue=0
        WinTop=0.598331
        WinLeft=0.736247
        WinWidth=0.103125
        WinHeight=0.03
        OnDeActivate=ValidateValue
    End Object
    Begin Object Class=XInterface.GUINumericEdit Name=timelimitNE
        MinValue=1
        WinTop=0.648331
        WinLeft=0.736247
        WinWidth=0.103125
        WinHeight=0.03
        OnDeActivate=ValidateValue
    End Object
    Begin Object Class=XInterface.GUINumericEdit Name=GrenadeNE
        MinValue=0
        MaxValue=8
        WinTop=0.698331
        WinLeft=0.736247
        WinWidth=0.103125
        WinHeight=0.03
        OnDeActivate=ValidateValue
    End Object
    Begin Object Class=XInterface.GUINumericEdit Name=OvertimeNE
        MinValue=0
        MaxValue=10
        WinTop=0.696269
        WinLeft=0.48781
        WinWidth=0.103125
        WinHeight=0.03
        OnDeActivate=ValidateValue
    End Object
    Begin Object Class=XInterface.GUIButton Name=RefreshButton
        Caption="Refresh Maps"
        WinTop=0.738752
        WinLeft=0.110936
        WinWidth=0.2175
        WinHeight=0.0475
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUILabel Name=MapNameLabel
        Caption="Map Name"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.45125
        WinLeft=0.352313
    End Object
    Begin Object Class=XInterface.GUILabel Name=gametypeLabel
        Caption="Gametype"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.349704
        WinLeft=0.353875
    End Object
    Begin Object Class=XInterface.GUILabel Name=MaxPlayersLabe
        Caption="Max Players"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.400713
        WinLeft=0.353438
    End Object
    Begin Object Class=XInterface.GUILabel Name=timelimitLabel
        Caption="Time Limit"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.636583
        WinLeft=0.598313
    End Object
    Begin Object Class=XInterface.GUILabel Name=grenadeLabel
        Caption="Grenades"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.685449
        WinLeft=0.598313
    End Object
    Begin Object Class=XInterface.GUILabel Name=OvertimeLabel
        Caption="OT Length"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.683387
        WinLeft=0.34675
    End Object
    Begin Object Class=XInterface.GUILabel Name=GoalScoreLabel
        Caption="GoalScore"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.5845
        WinLeft=0.598313
    End Object
    lb_MapList=MapListBox
    eb_MapInput=MapInputEditBox
    ne_NumPlayers=MaxPlayersNE
    co_GameTypeList=MapInputComboBox
    bu_QuickRestart=quickrestartButton
    bu_ChangeMap=ChangeMapButton
    l_MapName=MapNameLabel
    l_GameType=gametypeLabel
    l_MaxPlayers=MaxPlayersLabe
    cb_UseAdvancedOptions=AdvancedOptionsCheck
    cb_Adren=AdrenCheck
    cb_DD=DDCheck
    cb_SuperWeapons=SuperWeaponsCheck
    cb_WeaponStay=WeaponStayCheck
    ne_GoalScore=GoalScoreNE
    ne_TimeLimit=timelimitNE
    ne_Grenades=GrenadeNE
    ne_OverTime=OvertimeNE
    l_GoalScore=GoalScoreLabel
    l_TimeLimit=timelimitLabel
    l_grenades=grenadeLabel
    l_OverTime=OvertimeLabel
    bu_Refresh=RefreshButton
}
