

class UTComp_Menu_TeamOverlay extends UTComp_Menu_MainMenu;

var automated moCheckBox ch_Enable, ch_ShowSelf, ch_Icons;

var automated GUISlider sl_redBG, sl_blueBG, sl_greenBG;
var automated GUISlider sl_redName, sl_blueName, sl_greenName;
var automated GUISlider sl_redLoc, sl_blueLoc, sl_greenLoc;

var automated GUILabel l_redBG, l_blueBG, l_greenBG;
var automated GUILabel l_redName, l_blueName, l_greenName;
var automated GUILabel l_redLoc, l_blueLoc, l_greenLoc;

var automated GUILabel l_BGColor, l_NameColor, l_LocColor;
var automated GUILabel l_Horiz, l_Vert, l_Size;

var automated GUISlider sl_Horiz, sl_Vert, sl_Size;

var interaction overl;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    super.InitComponent(MyController,MyOwner);

    ch_Enable.Checked(class'UTComp_Overlay'.default.OverlayEnabled);
    ch_ShowSelf.Checked(class'UTComp_Settings'.default.bShowSelfInTeamOverlay);
    ch_Icons.Checked(class'UTComp_Overlay'.default.bDrawIcons);

    sl_redBG.SetValue(class'UTComp_Overlay'.default.BGColor.R);
    sl_greenBG.SetValue(class'UTComp_Overlay'.default.BGColor.G);
    sl_blueBG.SetValue(class'UTComp_Overlay'.default.BGColor.B);

    sl_redName.SetValue(class'UTComp_Overlay'.default.InfoTextColor.R);
    sl_greenName.SetValue(class'UTComp_Overlay'.default.InfoTextColor.G);
    sl_blueName.SetValue(class'UTComp_Overlay'.default.InfoTextColor.B);

    sl_redLoc.SetValue(class'UTComp_Overlay'.default.LocTextColor.R);
    sl_greenLoc.SetValue(class'UTComp_Overlay'.default.LocTextColor.G);
    sl_blueLoc.SetValue(class'UTComp_Overlay'.default.LocTextColor.B);

    sl_Horiz.SetValue(class'UTComp_Overlay'.default.HorizPosition);
    sl_Vert.SetValue(class'UTComp_Overlay'.default.VertPosition);
    sl_Size.SetValue(class'UTComp_Overlay'.default.theFontSize);

    FindCurrentOverlay();
    DisableStuff();
}

function DisableStuff()
{
    local UTComp_ServerReplicationInfo RepInfo;

    foreach PlayerOwner().DynamicActors(class'UTComp_ServerReplicationInfo', RepInfo)
        break;

    if(ch_Enable.IsChecked() && (RepInfo==None || RepInfo.bEnableTeamOverlay))
    {
        sl_Horiz.EnableMe();
        sl_Vert.EnableMe();
        sl_Size.EnableMe();

        sl_RedLoc.EnableMe();
        sl_GreenLoc.EnableMe();
        sl_BlueLoc.EnableMe();

        sl_RedName.EnableMe();
        sl_GreenName.EnableMe();
        sl_BlueName.EnableMe();

        sl_RedBG.EnableMe();
        sl_GreenBG.EnableMe();
        sl_BlueBG.EnableMe();

        ch_ShowSelf.EnableMe();
        ch_Icons.EnableMe();
    }
    else
    {
        sl_Horiz.DisableMe();
        sl_Vert.DisableMe();
        sl_Size.DisableMe();

        sl_RedLoc.DisableMe();
        sl_GreenLoc.DisableMe();
        sl_BlueLoc.DisableMe();

        sl_RedName.DisableMe();
        sl_GreenName.DisableMe();
        sl_BlueName.DisableMe();

        sl_RedBG.DisableMe();
        sl_GreenBG.DisableMe();
        sl_BlueBG.DisableMe();

        ch_ShowSelf.DisableMe();
        ch_Icons.DisableMe();
    }
}

function FindCurrentOverlay()
{
  local int i;
  local PlayerController PC;
  local bool bFindInteraction;

  bFindInteraction = false;

  ForEach AllObjects(class'PlayerController',PC)
  {
    if ( Viewport(PC.Player) != None )
    {
      While (!bFindInteraction)
      {
        overl = PC.Player.LocalInteractions[i];
        if (overl == none)
          break;
        else
        if (overl.IsA('UTComp_Overlay'))
          bFindInteraction = true;
	i++;
      }
      if (!bFindInteraction)
	overl = None;
    }
  }
}

function UpdateOverlay()
{
  if(overl==None)
  {
    FindCurrentOverlay();
    return;
  }
  utcomp_Overlay(overl).vertPosition=Class'utcomp_Overlay'.default.VertPosition;
  utcomp_Overlay(overl).horizposition=Class'utcomp_Overlay'.default.HorizPosition;
  utcomp_Overlay(overl).BGColor=Class'utcomp_Overlay'.default.BGColor;
  utcomp_Overlay(overl).infotextcolor=Class'utcomp_Overlay'.default.infotextColor;
  utcomp_Overlay(overl).loctextcolor=Class'utcomp_Overlay'.default.loctextColor;
  utcomp_Overlay(overl).OverlayEnabled=Class'utcomp_Overlay'.default.overlayenabled;
  utcomp_Overlay(overl).bDrawIcons=Class'utcomp_Overlay'.default.bDrawIcons;
  utcomp_Overlay(overl).theFontSize=Class'utcomp_overlay'.default.theFontSize;
}

function InternalOnChange( GUIComponent C )
{
    switch(C)
    {
    case ch_Enable: class'UTComp_Overlay'.default.OverlayEnabled=ch_Enable.IsChecked(); break;
    case ch_ShowSelf: BS_xPlayer(PlayerOwner()).SetShowSelf(ch_ShowSelf.IsChecked()); break;
    case ch_Icons: class'UTComp_Overlay'.default.bDrawIcons=ch_Icons.IsChecked(); break;

    case sl_redBG: class'UTComp_Overlay'.default.BGColor.R=sl_redBG.Value; break;
    case sl_greenBG: class'UTComp_Overlay'.default.BGColor.G=sl_GreenBG.Value; break;
    case sl_blueBG: class'UTComp_Overlay'.default.BGColor.B=sl_BlueBG.Value; break;

    case sl_redName: class'UTComp_Overlay'.default.InfoTextColor.R=sl_RedName.Value; break;
    case sl_greenName: class'UTComp_Overlay'.default.InfoTextColor.G=sl_GreenName.Value; break;
    case sl_blueName: class'UTComp_Overlay'.default.InfoTextColor.B=sl_BlueName.Value;break;

    case sl_redLoc: class'UTComp_Overlay'.default.LocTextColor.R=sl_RedLoc.Value;break;
    case sl_greenLoc: class'UTComp_Overlay'.default.LocTextColor.G=sl_GreenLoc.Value; break;
    case sl_blueLoc: class'UTComp_Overlay'.default.LocTextColor.B=sl_BlueLoc.Value;break;

    case sl_Horiz: class'UTComp_Overlay'.default.HorizPosition=sl_Horiz.Value; break;
    case sl_Vert: class'UTComp_Overlay'.default.VertPosition=sl_Vert.Value;break;
    case sl_Size: class'UTComp_Overlay'.default.theFontSize=sl_Size.Value;break;
    }
    class'UTComp_Overlay'.Static.StaticSaveConfig();
    class'UTComp_Settings'.static.staticSaveConfig();
    class'BS_xPlayer'.Static.StaticSaveConfig();
    BS_xPlayer(PlayerOwner()).MakeSureSaveConfig();
    UpdateOverlay();
    DisableStuff();
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
    if (Key == 0x1B)
        return false;
    return true;
}

defaultproperties
{
    Begin Object Class=XInterface.GUISlider Name=RedBGSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.515
        WinLeft=0.2
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=BlueBGSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.595
        WinLeft=0.2
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=GreenBGSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.555
        WinLeft=0.2
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=RedNameSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.665
        WinLeft=0.6
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=BlueNameSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.745
        WinLeft=0.6
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=GreenNameSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.705
        WinLeft=0.6
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=RedLocSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.665
        WinLeft=0.2
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=BlueLocSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.745
        WinLeft=0.2
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=GreenLocSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.705
        WinLeft=0.2
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=SliderHoriz
        MaxValue=0.75
        WinTop=0.35
        WinLeft=0.56
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=SliderVert
        MaxValue=1.0
        WinTop=0.41
        WinLeft=0.56
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=SliderSize
        MinValue=-7.0
        MaxValue=0.0
        bIntSlider=True
        WinTop=0.47
        WinLeft=0.56
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.moCheckBox Name=CheckEnable
        Caption="Enable Overlay"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.35
        WinLeft=0.15
        WinWidth=0.3
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=CheckShowSelf
        Caption="Show Self"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.4
        WinLeft=0.15
        WinWidth=0.3
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=CheckIcons
        Caption="Enable Icons"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.45
        WinLeft=0.15
        WinWidth=0.3
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.GUILabel Name=RedBGLabel
        Caption="Red"
        TextColor=(R=255,G=0,B=64,A=255)
        WinTop=0.5
        WinLeft=0.12
    End Object
    Begin Object Class=XInterface.GUILabel Name=BlueBGLabel
        Caption="Blue"
        TextColor=(R=0,G=0,B=255,A=255)
        WinTop=0.58
        WinLeft=0.12
    End Object
    Begin Object Class=XInterface.GUILabel Name=GreenBGLabel
        Caption="Green"
        TextColor=(R=0,G=255,B=64,A=255)
        WinTop=0.54
        WinLeft=0.12
    End Object
    Begin Object Class=XInterface.GUILabel Name=RedNameLabel
        Caption="Red"
        TextColor=(R=255,G=0,B=64,A=255)
        WinTop=0.65
        WinLeft=0.52
    End Object
    Begin Object Class=XInterface.GUILabel Name=BlueNameLabel
        Caption="Blue"
        TextColor=(R=0,G=0,B=255,A=255)
        WinTop=0.73
        WinLeft=0.52
    End Object
    Begin Object Class=XInterface.GUILabel Name=GreenNameLabel
        Caption="Green"
        TextColor=(R=0,G=255,B=64,A=255)
        WinTop=0.69
        WinLeft=0.52
    End Object
    Begin Object Class=XInterface.GUILabel Name=RedLocLabel
        Caption="Red"
        TextColor=(R=255,G=0,B=64,A=255)
        WinTop=0.65
        WinLeft=0.12
    End Object
    Begin Object Class=XInterface.GUILabel Name=BlueLocLabel
        Caption="Blue"
        TextColor=(R=0,G=0,B=255,A=255)
        WinTop=0.73
        WinLeft=0.12
    End Object
    Begin Object Class=XInterface.GUILabel Name=GreenLocLabel
        Caption="Green"
        TextColor=(R=0,G=255,B=64,A=255)
        WinTop=0.69
        WinLeft=0.12
    End Object
    Begin Object Class=XInterface.GUILabel Name=BGColorLabel
        Caption="Background Color"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.475
        WinLeft=0.12
    End Object
    Begin Object Class=XInterface.GUILabel Name=NameColorLabel
        Caption="Name color"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.615
        WinLeft=0.52
    End Object
    Begin Object Class=XInterface.GUILabel Name=LocColorLabel
        Caption="Location color"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.615
        WinLeft=0.12
    End Object
    Begin Object Class=XInterface.GUILabel Name=SizeLabel
        Caption="Size:"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.425
        WinLeft=0.55
    End Object
    Begin Object Class=XInterface.GUILabel Name=VertLabel
        Caption="Vertical Location:"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.365
        WinLeft=0.55
    End Object
    Begin Object Class=XInterface.GUILabel Name=HorizLabel
        Caption="Horizontal Location:"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.31
        WinLeft=0.55
    End Object
    ch_Enable=CheckEnable
    ch_ShowSelf=CheckShowSelf
    ch_Icons=CheckIcons
    sl_redBG=RedBGSlider
    sl_blueBG=BlueBGSlider
    sl_greenBG=GreenBGSlider
    sl_redName=RedNameSlider
    sl_blueName=BlueNameSlider
    sl_greenName=GreenNameSlider
    sl_redLoc=RedLocSlider
    sl_blueLoc=BlueLocSlider
    sl_greenLoc=GreenLocSlider
    l_redBG=RedBGLabel
    l_blueBG=BlueBGLabel
    l_greenBG=GreenBGLabel
    l_redName=RedNameLabel
    l_blueName=BlueNameLabel
    l_greenName=GreenNameLabel
    l_redLoc=RedLocLabel
    l_blueLoc=BlueLocLabel
    l_greenLoc=GreenLocLabel
    l_BGColor=BGColorLabel
    l_NameColor=NameColorLabel
    l_LocColor=LocColorLabel
    l_Horiz=HorizLabel
    l_Vert=VertLabel
    l_Size=SizeLabel
    sl_Horiz=SliderHoriz
    sl_Vert=SliderVert
    sl_Size=SliderSize
}
