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

    ch_AutoDemo.Checked(class'UTComp_ClientSettings'.static.Get().bEnableUTCompAutoDemorec);
    ch_AutoSS.Checked(class'UTComp_ClientSettings'.static.Get().bEnableAutoScreenshot);

    co_DemoMask.AddItem(class'UTComp_ClientSettings'.static.Get().DemoRecordingMask);

    co_SSMask.AddItem(class'UTComp_ClientSettings'.static.Get().ScreenShotMask);

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
        case co_SSMask:   class'UTComp_ClientSettings'.static.Get().ScreenShotMask=co_SSMask.GetText(); break;
        case co_DemoMask:   class'UTComp_ClientSettings'.static.Get().DemoRecordingMask=co_DemoMask.GetText(); break;
        case ch_AutoDemo:   class'UTComp_ClientSettings'.static.Get().bEnableUTCompAutoDemorec=ch_AutoDemo.IsChecked(); break;
        case ch_AutoSS:   class'UTComp_ClientSettings'.static.Get().bEnableAutoScreenshot=ch_AutoSS.IsChecked(); break;
    }
    BS_xPlayer(PlayerOwner()).MakeSureSaveConfig();
    class'BS_xPlayer'.Static.StaticSaveConfig();
    class'UTComp_ClientSettings'.static.Get().Save();
    DisableStuff();
}

function bool InternalOnKeyEvent(out byte Key, out byte State, float delta)
{
    if (Key == 0x1B)
        return false;
    class'UTComp_ClientSettings'.static.Get().ScreenShotMask=co_SSMask.GetText();
    class'UTComp_ClientSettings'.static.Get().DemoRecordingMask=co_DemoMask.GetText();
    BS_xPlayer(PlayerOwner()).MakeSureSaveConfig();
    class'BS_xPlayer'.Static.StaticSaveConfig();
    class'UTComp_ClientSettings'.static.Get().Save();
}

defaultproperties
{
	Begin Object Class=moCheckBox Name=AutoDemoCheck
		Caption="Automatically record a demo of each match."
		OnCreateComponent=AutoDemoCheck.InternalOnCreateComponent
		WinTop=0.412083
		WinLeft=0.140000
		WinWidth=0.740000
		OnChange=UTComp_Menu_AutoDemoSS.InternalOnChange
	End Object
	ch_AutoDemo=moCheckBox'UTCompvBoM.UTComp_Menu_AutoDemoSS.AutoDemoCheck'

	Begin Object Class=moCheckBox Name=AutoSSCheck
		Caption="Automatically take a screenshot at the end of each match."
		OnCreateComponent=AutoSSCheck.InternalOnCreateComponent
		WinTop=0.589168
		WinLeft=0.140000
		WinWidth=0.740000
		OnChange=UTComp_Menu_AutoDemoSS.InternalOnChange
	End Object
	ch_AutoSS=moCheckBox'UTCompvBoM.UTComp_Menu_AutoDemoSS.AutoSSCheck'

	Begin Object Class=GUIComboBox Name=AutoDemoInput
		WinTop=0.460000
		WinLeft=0.437500
		WinWidth=0.320000
		WinHeight=0.035000
		OnChange=UTComp_Menu_AutoDemoSS.InternalOnChange
		OnKeyEvent=UTComp_Menu_AutoDemoSS.InternalOnKeyEvent
	End Object
	co_DemoMask=GUIComboBox'UTCompvBoM.UTComp_Menu_AutoDemoSS.AutoDemoInput'

	Begin Object Class=GUIComboBox Name=AutoSSInput
		WinTop=0.645418
		WinLeft=0.437500
		WinWidth=0.320000
		WinHeight=0.035000
		OnChange=UTComp_Menu_AutoDemoSS.InternalOnChange
		OnKeyEvent=UTComp_Menu_AutoDemoSS.InternalOnKeyEvent
	End Object
	co_SSMask=GUIComboBox'UTCompvBoM.UTComp_Menu_AutoDemoSS.AutoSSInput'

	Begin Object Class=GUILabel Name=DemoMaskLabel
		Caption="Demo Mask:"
		TextColor=(B=255,G=255,R=255)
		WinTop=0.450000
		WinLeft=0.225000
	End Object
	l_AutoDemoMask=GUILabel'UTCompvBoM.UTComp_Menu_AutoDemoSS.DemoMaskLabel'

	Begin Object Class=GUILabel Name=SSMaskLabel
		Caption="Screenshot Mask:"
		TextColor=(B=255,G=255,R=255)
		WinTop=0.632918
		WinLeft=0.225000
	End Object
	l_AutoSSMask=GUILabel'UTCompvBoM.UTComp_Menu_AutoDemoSS.SSMaskLabel'

	Begin Object Class=GUILabel Name=SSHeadingLabel
		Caption="--- Auto Screenshot ---"
		TextColor=(B=0,G=200,R=230)
		WinTop=0.514167
		WinLeft=0.342188
	End Object
	l_SSHeading=GUILabel'UTCompvBoM.UTComp_Menu_AutoDemoSS.SSHeadingLabel'

	Begin Object Class=GUILabel Name=DemnoHeadingLabel
		Caption="--- Auto Demo Recording---"
		TextColor=(B=0,G=200,R=230)
		WinTop=0.347500
		WinLeft=0.326563
	End Object
	l_DemoHeading=GUILabel'UTCompvBoM.UTComp_Menu_AutoDemoSS.DemnoHeadingLabel'

}
