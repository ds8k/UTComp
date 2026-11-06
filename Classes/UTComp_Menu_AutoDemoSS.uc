

class UTComp_Menu_AutoDemoSS extends UTComp_Menu_MainMenu;

var automated moCheckBox ch_AutoDemo;
var automated moCheckBox ch_AutoSS;

var automated GUIComboBox co_DemoMask;
var automated GUIComboBox co_SSMask;


var automated GUILabel l_AutoDemoMask;
var automated GUILabel l_AutoSSMask;

var automated GUILabel l_SSHeading, l_DemoHeading;


function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    Super.InitComponent(myController,MyOwner);

    ch_AutoDemo.Checked(class'UTComp_Settings'.default.bEnableUTCompAutoDemorec);
    ch_AutoSS.Checked(class'UTComp_Settings'.default.bEnableAutoScreenshot);

    co_DemoMask.AddItem(class'UTComp_Settings'.default.DemoRecordingMask);

    co_SSMask.AddItem(class'UTComp_Settings'.default.ScreenShotMask);

    DisableStuff();
}

function DisableStuff()
{
    if(!ch_AutoDemo.IsChecked())
        co_DemoMask.DisableMe();
    else
        co_DemoMask.EnableMe();
    if(!ch_AutoSS.IsChecked())
        co_SSMask.DisableMe();
    else
        co_SSMask.EnableMe();
}


function InternalOnChange( GUIComponent C )
{
    switch(C)
    {
        case co_SSMask:   class'UTComp_Settings'.default.ScreenShotMask=co_SSMask.GetText(); break;
        case co_DemoMask:   class'UTComp_Settings'.default.DemoRecordingMask=co_DemoMask.GetText(); break;
        case ch_AutoDemo:   class'UTComp_Settings'.default.bEnableUTCompAutoDemorec=ch_AutoDemo.IsChecked(); break;
        case ch_AutoSS:   class'UTComp_Settings'.default.bEnableAutoScreenshot=ch_AutoSS.IsChecked(); break;
    }
    BS_xPlayer(PlayerOwner()).MakeSureSaveConfig();
    class'BS_xPlayer'.Static.StaticSaveConfig();
    class'UTComp_Settings'.static.staticSaveConfig();
    DisableStuff();
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
    if (Key == 0x1B)
        return false;
    class'UTComp_Settings'.default.ScreenShotMask=co_SSMask.GetText();
    class'UTComp_Settings'.default.DemoRecordingMask=co_DemoMask.GetText();
    BS_xPlayer(PlayerOwner()).MakeSureSaveConfig();
    class'BS_xPlayer'.Static.StaticSaveConfig();
    class'UTComp_Settings'.static.staticSaveConfig();
}

defaultproperties
{
    Begin Object Class=XInterface.moCheckBox Name=AutoDemoCheck
        Caption="Automatically record a demo of each match."
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.412083
        WinLeft=0.14
        WinWidth=0.74
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=AutoSSCheck
        Caption="Automatically take a screenshot at the end of each match."
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.589168
        WinLeft=0.14
        WinWidth=0.74
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.GUIComboBox Name=AutoDemoInput
        WinTop=0.46
        WinLeft=0.4375
        WinWidth=0.32
        WinHeight=0.035
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIComboBox Name=AutoSSInput
        WinTop=0.645418
        WinLeft=0.4375
        WinWidth=0.32
        WinHeight=0.035
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUILabel Name=DemoMaskLabel
        Caption="Demo Mask:"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.45
        WinLeft=0.225
    End Object
    Begin Object Class=XInterface.GUILabel Name=SSMaskLabel
        Caption="Screenshot Mask:"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.632918
        WinLeft=0.225
    End Object
    Begin Object Class=XInterface.GUILabel Name=SSHeadingLabel
        Caption="--- Auto Screenshot ---"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.514167
        WinLeft=0.342188
    End Object
    Begin Object Class=XInterface.GUILabel Name=DemnoHeadingLabel
        Caption="--- Auto Demo Recording---"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.3475
        WinLeft=0.326563
    End Object
    ch_AutoDemo=AutoDemoCheck
    ch_AutoSS=AutoSSCheck
    co_DemoMask=AutoDemoInput
    co_SSMask=AutoSSInput
    l_AutoDemoMask=DemoMaskLabel
    l_AutoSSMask=SSMaskLabel
    l_SSHeading=SSHeadingLabel
    l_DemoHeading=DemnoHeadingLabel
}
