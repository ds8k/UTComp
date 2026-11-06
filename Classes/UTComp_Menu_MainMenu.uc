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
     Begin Object class=GUIButton name=SkinModelButton
         Caption="Skins/Models"
         WinTop=0.150000
         WinLeft=0.11250000
         WinWidth=0.180000
         WinHeight=0.060000
         OnClick=InternalOnClick
     End Object
     UTCompMenuButtons(0)=GUIButton'SkinModelButton'

     Begin Object class=GUIButton name=ColoredNameButton
         Caption="Colored Names"
         WinTop=0.150000
         WinLeft=0.31250000
         WinWidth=0.180000
         WinHeight=0.060000
         OnClick=InternalOnClick
     End Object
     UTCompMenuButtons(1)=GUIButton'ColoredNameButton'

     Begin Object class=GUIButton name=OverlayButton
         Caption="Team Overlay"
         WinTop=0.150000
         WinLeft=0.51250000
         WinWidth=0.180000
         WinHeight=0.060000
         OnClick=InternalOnClick
     End Object
     UTCompMenuButtons(2)=GUIButton'OverlayButton'

     Begin Object class=GUIButton name=CrosshairButton
         Caption="Crosshairs"
         WinTop=0.150000
         WinLeft=0.71250000
         WinWidth=0.180000
         WinHeight=0.060000
         OnClick=InternalOnClick
     End Object
     UTCompMenuButtons(3)=GUIButton'CrosshairButton'

     Begin Object class=GUIButton name=HitsoundButton
         Caption="Hitsounds"
         WinTop=0.220000
         WinLeft=0.11250000
         WinWidth=0.180000
         WinHeight=0.060000
         OnClick=InternalOnClick
     End Object
     UTCompMenuButtons(4)=GUIButton'HitsoundButton'

     Begin Object class=GUIButton name=VotingButton
         Caption="Voting"
         WinTop=0.220000
         WinLeft=0.31250000
         WinWidth=0.180000
         WinHeight=0.060000
         OnClick=InternalOnClick
     End Object
     UTCompMenuButtons(5)=GUIButton'VotingButton'

     Begin Object class=GUIButton name=AutoDemoButton
         Caption="Auto Demo/SS"
         WinTop=0.220000
         WinLeft=0.51250000
         WinWidth=0.180000
         WinHeight=0.060000
         OnClick=InternalOnClick
     End Object
     UTCompMenuButtons(6)=GUIButton'AutoDemoButton'

     Begin Object class=GUIButton name=MiscButton
         Caption="Misc"
         WinTop=0.220000
         WinLeft=0.71250000
         WinWidth=0.180000
         WinHeight=0.060000
         OnClick=InternalOnClick
     End Object
    UTCompMenuButtons(7)=GUIButton'MiscButton'

	Begin Object Class=GUITabControl Name=LoginMenuTC
		bFillSpace=True
		bDockPanels=True
		WinTop=0.072718
		WinLeft=0.134782
		WinWidth=0.725325
		WinHeight=0.208177
		bScaleToParent=True
		bAcceptsInput=True
		OnActivate=LoginMenuTC.InternalOnActivate
	End Object
	c_Main=GUITabControl'LoginMenuTC'

	Begin Object Class=FloatingImage Name=FloatingFrameBackground2
		Image=Texture'2K4Menus.NewControls.Display95'
		ImageStyle=ISTY_Stretched
		ImageRenderStyle=MSTY_Normal
		DropShadowX=0
		DropShadowY=0
		WinTop=0.270000
		WinLeft=0.075000
		WinWidth=0.850000
		WinHeight=0.580000
		RenderWeight=0.020000
		bBoundToParent=False
		bScaleToParent=False
	End Object
	i_FrameBG2=FloatingImage'UTCompvBoM.UTComp_Menu_MainMenu.FloatingFrameBackground2'

	Begin Object Class=FloatingImage Name=FloatingFrameBackground
		Image=Texture'2K4Menus.NewControls.Display99'
		ImageStyle=ISTY_Stretched
		ImageRenderStyle=MSTY_Normal
		DropShadowX=0
		DropShadowY=0
		WinTop=0.100000
		WinLeft=0.075000
		WinWidth=0.850000
		WinHeight=0.750000
		RenderWeight=0.010000
		bBoundToParent=False
		bScaleToParent=False
	End Object
	i_FrameBG=FloatingImage'UTCompvBoM.UTComp_Menu_MainMenu.FloatingFrameBackground'

	bRequire640x480=True
	bPersistent=True
	bAllowedAsLast=True
	WinTop=0.114990
	WinHeight=0.804690
}
