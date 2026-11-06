
class UTComp_Menu_OpenedMenu extends UTComp_Menu_MainMenu;

var automated array<GUILabel> l_Mode;
var automated GUIImage i_UTCompLogo;
var automated GUIButton bu_Ready, bu_NotReady;

var color GoldColor;

var UTComp_ServerReplicationInfo RepInfo;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    l_Mode[2].Caption=class'MutUTComp'.default.FriendlyVersionPrefix $ class'Gameinfo'.Static.MakeColorCode(GoldColor) @ class'MutUTComp'.default.FriendlyVersionNumber;

	Super.InitComponent(myController,MyOwner);
}

function RandomCrap()
{
    if(RepInfo==None)
       foreach PlayerOwner().ViewTarget.DynamicActors(class'UTComp_ServerReplicationInfo', RepInfo)
          break;

    if (RepInfo.EnableBrightSkinsMode == 1)
        l_Mode[0].Caption = class'Gameinfo'.Static.MakeColorCode(GoldColor)$"Brightskins Mode:"$class'gameinfo'.Static.MakeColorCode(WhiteColor)$"  Brightskins Disabled";
    else if (RepInfo.EnableBrightSkinsMode == 2)
        l_Mode[0].Caption = class'Gameinfo'.Static.MakeColorCode(GoldColor)$"Brightskins Mode:"$class'gameinfo'.Static.MakeColorCode(WhiteColor)$"  Bright Epic Style Skins";
    else if (RepInfo.EnableBrightSkinsMode == 3)
        l_Mode[0].Caption = class'gameinfo'.Static.MakeColorCode(GoldColor)$"Brightskins Mode:"$class'gameinfo'.Static.MakeColorCode(WhiteColor)$"  UTComp Style Skins";
    if (RepInfo.EnableHitSoundsMode == 0)
       l_Mode[1].Caption = class'gameinfo'.Static.MakeColorCode(GoldColor)$"Hitsounds Mode:"$class'gameinfo'.Static.MakeColorCode(WhiteColor)$"  Disabled";
    else if (RepInfo.EnableHitSoundsMode == 1)
       l_Mode[1].Caption = class'gameinfo'.Static.MakeColorCode(GoldColor)$"Hitsounds Mode:"$class'gameinfo'.Static.MakeColorCode(WhiteColor)$"  Line Of Sight";
    else if (RepInfo.EnableHitSoundsMode == 2)
       l_Mode[1].Caption = class'gameinfo'.Static.MakeColorCode(GoldColor)$"Hitsounds Mode:"$class'gameinfo'.Static.MakeColorCode(WhiteColor)$"  Everywhere";
    if(RepInfo.benableDoubleDamage)
       l_Mode[3].Caption =class'gameinfo'.Static.MakeColorCode(GoldColor)$"Double Damage Mode:"$class'gameinfo'.Static.MakeColorCode(WhiteColor)$" Enabled";
    else
       l_Mode[3].Caption =class'GameInfo'.Static.MakeColorCode(GoldColor)$"Double Damage Mode:"$class'GameInfo'.Static.MakeColorCode(WhiteColor)$" Disabled";
    if(RepInfo.bEnableEnhancedNetCode)
       l_Mode[5].Caption =class'gameinfo'.Static.MakeColorCode(GoldColor)$"Enhanced Netcode:"$class'gameinfo'.Static.MakeColorCode(WhiteColor)$" Enabled";
    else
       l_Mode[5].Caption =class'GameInfo'.Static.MakeColorCode(GoldColor)$"Enhanced Netcode:"$class'GameInfo'.Static.MakeColorCode(WhiteColor)$" Disabled";

   if(!PlayerOwner().PlayerReplicationInfo.bOnlySpectator)
   {
     bu_Ready.Caption="Ready";
     bu_NotReady.Caption="Not Ready";
   }
   else
   {
     bu_Ready.Caption="Coach Red";
     bu_NotReady.Caption="Coach Blue";
   }
}

event opened(GUIComponent Sender)
{
    super.Opened(Sender);
    RandomCrap();
}

function bool InternalOnClick( GUIComponent C )
{

    switch (C)
    {
      case bu_Ready:   if(PlayerOwner().IsA('BS_xPlayer'))
                           {
                              if(PlayerOwner().PlayerReplicationInfo.bOnlySpectator)
                                BS_xPlayer(PlayerOwner()).SpecLockRed();
                              else
                                BS_xPlayer(PlayerOwner()).Ready();
                           }
                           PlayerOwner().ClientCloseMenu();
                           return false;

      case bu_NotReady:
                           if(PlayerOwner().IsA('BS_xPlayer'))
                           {
                              if(PlayerOwner().PlayerReplicationInfo.bOnlySpectator)
                                BS_xPlayer(PlayerOwner()).SpecLockBlue();
                              else
                                BS_xPlayer(PlayerOwner()).NotReady();
                           }
                           PlayerOwner().ClientCloseMenu();
                           return false;
    }

    return super.internalonclick(C);
}

defaultproperties
{
    Begin Object Class=XInterface.GUIButton Name=ReadyButton
        WinTop=0.65
        WinLeft=0.25
        WinWidth=0.2
        WinHeight=0.06
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=NotReadyButton
        WinTop=0.65
        WinLeft=0.55
        WinWidth=0.2
        WinHeight=0.06
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUILabel Name=BrightSkinsModeLabel
        TextAlign=TXTA_Center
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.494433
        WinHeight=0.049485
    End Object
    Begin Object Class=XInterface.GUILabel Name=HitSoundsModeLabel
        TextAlign=TXTA_Center
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.53
        WinHeight=24.0
    End Object
    Begin Object Class=XInterface.GUILabel Name=VersionLabel
        TextAlign=TXTA_Center
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.417011
        WinHeight=0.049485
    End Object
    Begin Object Class=XInterface.GUILabel Name=AmpModeLabel
        TextAlign=TXTA_Center
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.57
        WinHeight=24.0
    End Object
    Begin Object Class=XInterface.GUILabel Name=NetCodeModeLabel
        TextAlign=TXTA_Center
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.61
        WinHeight=24.0
    End Object
    Begin Object Class=XInterface.GUILabel Name=ServerSetLabel
        Caption="------Server Settings------"
        TextAlign=TXTA_Center
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.454433
        WinHeight=0.049485
    End Object
    Begin Object Class=XInterface.GUIImage Name=UTCompLogo
        Image=Texture'UTCompvBoM.UTCompLogo'
        ImageStyle=ISTY_Scaled
        WinTop=0.307113
        WinLeft=0.3125
        WinWidth=0.375
        WinHeight=0.125
    End Object
    Begin Object Class=XInterface.GUILabel Name=NewVersions
        Caption="Visit https://GitHub.com/Deaod/UTComp for new versions."
        TextAlign=TXTA_Center
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.727502
        WinHeight=0.05
    End Object
    l_Mode(0)=BrightSkinsModeLabel
    l_Mode(1)=HitSoundsModeLabel
    l_Mode(2)=VersionLabel
    l_Mode(3)=AmpModeLabel
    l_Mode(4)=NewVersions
    l_Mode(5)=NetCodeModeLabel
    l_Mode(6)=ServerSetLabel
    i_UTCompLogo=UTCompLogo
    bu_Ready=ReadyButton
    bu_NotReady=NotReadyButton
    GoldColor=(R=230,G=200,B=0,A=0)
}
