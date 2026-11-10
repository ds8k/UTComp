//-----------------------------------------------------------
//
//-----------------------------------------------------------
class UTComp_menu_AdrenMenu extends UTComp_Menu_MainMenu;

var automated moCheckBox ch_booster;
var automated moCheckBox ch_invis;
var automated moCheckBox ch_speed;
var automated moCheckBox ch_berserk;

var automated GUILAbel l_adren;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    super.InitComponent(MyController,MyOwner);

    ch_booster.Checked(!class'UTComp_ClientSettings'.static.Get().bDisableBooster);
    ch_speed.Checked(!class'UTComp_ClientSettings'.static.Get().bDisableSpeed);
    ch_berserk.Checked(!class'UTComp_ClientSettings'.static.Get().bDisableBerserk);
    ch_invis.Checked(!class'UTComp_ClientSettings'.static.Get().bDisableInvis);
}

function InternalOnChange( GUIComponent C )
{
    switch(C)
    {
        case ch_booster: class'UTComp_ClientSettings'.static.Get().bDisableBooster=!ch_booster.IsChecked(); break;
        case ch_invis:  class'UTComp_ClientSettings'.static.Get().bDisableInvis=!ch_Invis.IsChecked();
        case ch_speed:  class'UTComp_ClientSettings'.static.Get().bDisableSpeed=!ch_Speed.IsChecked(); break;
        case ch_berserk: class'UTComp_ClientSettings'.static.Get().bDisableberserk=!ch_Berserk.IsChecked(); break;
    }
    class'UTComp_ClientSettings'.static.Get().Save();
}

defaultproperties
{
	Begin Object Class=moCheckBox Name=BoosterCheck
		Caption="Enable Booster Combo"
		OnCreateComponent=BoosterCheck.InternalOnCreateComponent
		WinTop=0.430000
		WinLeft=0.250000
		OnChange=UTComp_Menu_AdrenMenu.InternalOnChange
	End Object
	ch_booster=moCheckBox'UTCompvBoM.UTComp_Menu_AdrenMenu.BoosterCheck'

	Begin Object Class=moCheckBox Name=InvisCheck
		Caption="Enable Invisibility Combo"
		OnCreateComponent=InvisCheck.InternalOnCreateComponent
		WinTop=0.480000
		WinLeft=0.250000
		OnChange=UTComp_Menu_AdrenMenu.InternalOnChange
	End Object
	ch_invis=moCheckBox'UTCompvBoM.UTComp_Menu_AdrenMenu.InvisCheck'

	Begin Object Class=moCheckBox Name=SpeedCheck
		Caption="Enable Speed Combo"
		OnCreateComponent=SpeedCheck.InternalOnCreateComponent
		WinTop=0.530000
		WinLeft=0.250000
		OnChange=UTComp_Menu_AdrenMenu.InternalOnChange
	End Object
	ch_speed=moCheckBox'UTCompvBoM.UTComp_Menu_AdrenMenu.SpeedCheck'

	Begin Object Class=moCheckBox Name=BerserkCheck
		Caption="Enable Berserk Combo"
		OnCreateComponent=BerserkCheck.InternalOnCreateComponent
		WinTop=0.580000
		WinLeft=0.250000
		OnChange=UTComp_Menu_AdrenMenu.InternalOnChange
	End Object
	ch_berserk=moCheckBox'UTCompvBoM.UTComp_Menu_AdrenMenu.BerserkCheck'

	Begin Object Class=GUILabel Name=AdrenLabel
		Caption="----Adrenaline Combo Settings----"
		TextColor=(B=0,G=200,R=230)
		WinTop=0.360000
		WinLeft=0.250000
	End Object
	l_adren=GUILabel'UTCompvBoM.UTComp_Menu_AdrenMenu.AdrenLabel'

}
