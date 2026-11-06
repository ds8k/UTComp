
class UTComp_Menu_MainMenu extends PopupPageBase;

var automated array<GUIButton> UTCompMenuButtons;
var automated GUITabControl c_Main;
var automated FloatingImage i_FrameBG2;

function InitComponent(GUIController MyController, GUIComponent MyComponent)
{
	super.InitComponent(MyController, MyComponent);
}

function bool InternalOnClick(GUIComponent C)
{
    if(C==UTCompMenuButtons[0])
        PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_BrightSkins");

    else if(C==UTCompMenuButtons[1])
        PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_ColorNames");

    else if(C==UTCompMenuButtons[2])
        PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_TeamOverlay");

    else if(C==UTCompMenuButtons[3])
        PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_Crosshairs");

    else if(C==UTCompMenuButtons[4])
        PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_Hitsounds");

    else if(C==UTCompMenuButtons[5])
        PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_Voting");

    else if(C==UTCompMenuButtons[6])
        PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_AutoDemoSS");

    else if(C==UTCompMenuButtons[7])
        PlayerOwner().ClientReplaceMenu("UTCompvBoM.UTComp_Menu_Miscellaneous");

    return false;
}

function OnClose(optional bool bCancelled)
{
   if(PlayerOwner().IsA('BS_xPlayer'))
   {
      BS_xPlayer(PlayerOwner()).ReSkinAll();
      BS_xPlayer(PlayerOwner()).InitializeScoreboard();
      BS_xPlayer(PlayerOwner()).MatchHudColor();
   }
   super.OnClose(bCancelled);
}

defaultproperties
{
    Begin Object Class=XInterface.GUIButton Name=SkinModelButton
        Caption="Skins/Models"
        WinTop=0.15
        WinLeft=0.1125
        WinWidth=0.18
        WinHeight=0.06
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=ColoredNameButton
        Caption="Colored Names"
        WinTop=0.15
        WinLeft=0.3125
        WinWidth=0.18
        WinHeight=0.06
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=OverlayButton
        Caption="Team Overlay"
        WinTop=0.15
        WinLeft=0.5125
        WinWidth=0.18
        WinHeight=0.06
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=CrosshairButton
        Caption="Crosshairs"
        WinTop=0.15
        WinLeft=0.7125
        WinWidth=0.18
        WinHeight=0.06
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=HitsoundButton
        Caption="Hitsounds"
        WinTop=0.22
        WinLeft=0.1125
        WinWidth=0.18
        WinHeight=0.06
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=VotingButton
        Caption="Voting"
        WinTop=0.22
        WinLeft=0.3125
        WinWidth=0.18
        WinHeight=0.06
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=AutoDemoButton
        Caption="Auto Demo/SS"
        WinTop=0.22
        WinLeft=0.5125
        WinWidth=0.18
        WinHeight=0.06
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=MiscButton
        Caption="Misc"
        WinTop=0.22
        WinLeft=0.7125
        WinWidth=0.18
        WinHeight=0.06
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUITabControl Name=LoginMenuTC
        bFillSpace=True
        bDockPanels=True
        WinTop=0.072718
        WinLeft=0.134782
        WinWidth=0.725325
        WinHeight=0.208177
        bScaleToParent=True
        bAcceptsInput=True
        OnActivate=InternalOnActivate
    End Object
    Begin Object Class=XInterface.FloatingImage Name=FloatingFrameBackground
        Image=Texture'2K4Menus.NewControls.Display99'
        ImageStyle=ISTY_Stretched
        ImageRenderStyle=MSTY_Normal
        DropShadowX=0
        DropShadowY=0
        WinTop=0.1
        WinLeft=0.075
        WinWidth=0.85
        WinHeight=0.75
        RenderWeight=0.01
        bBoundToParent=False
        bScaleToParent=False
    End Object
    Begin Object Class=XInterface.FloatingImage Name=FloatingFrameBackground2
        Image=Texture'2K4Menus.NewControls.Display95'
        ImageStyle=ISTY_Stretched
        ImageRenderStyle=MSTY_Normal
        DropShadowX=0
        DropShadowY=0
        WinTop=0.27
        WinLeft=0.075
        WinWidth=0.85
        WinHeight=0.58
        RenderWeight=0.02
        bBoundToParent=False
        bScaleToParent=False
    End Object
    UTCompMenuButtons(0)=SkinModelButton
    UTCompMenuButtons(1)=ColoredNameButton
    UTCompMenuButtons(2)=OverlayButton
    UTCompMenuButtons(3)=CrosshairButton
    UTCompMenuButtons(4)=HitsoundButton
    UTCompMenuButtons(5)=VotingButton
    UTCompMenuButtons(6)=AutoDemoButton
    UTCompMenuButtons(7)=MiscButton
    c_Main=LoginMenuTC
    i_FrameBG2=FloatingFrameBackground2
    i_FrameBG=FloatingFrameBackground
    bRequire640x480=True
    bPersistent=True
    bAllowedAsLast=True
    WinTop=0.11499
    WinHeight=0.80469
}
