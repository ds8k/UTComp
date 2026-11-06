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

    ch_booster.Checked(!class'UTComp_Settings'.default.bDisableBooster);
    ch_speed.Checked(!class'UTComp_Settings'.default.bDisableSpeed);
    ch_berserk.Checked(!class'UTComp_Settings'.default.bDisableBerserk);
    ch_invis.Checked(!class'UTComp_Settings'.default.bDisableInvis);
}

function InternalOnChange( GUIComponent C )
{
    switch(C)
    {
        case ch_booster: class'UTComp_Settings'.default.bDisableBooster=!ch_booster.IsChecked(); break;
        case ch_invis:  class'UTComp_Settings'.default.bDisableInvis=!ch_Invis.IsChecked();
        case ch_speed:  class'UTComp_Settings'.default.bDisableSpeed=!ch_Speed.IsChecked(); break;
        case ch_berserk: class'UTComp_Settings'.default.bDisableberserk=!ch_Berserk.IsChecked(); break;
    }
    class'UTComp_Settings'.static.staticSaveConfig();
}

defaultproperties
{
    Begin Object Class=XInterface.moCheckBox Name=BoosterCheck
        Caption="Enable Booster Combo"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.43
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=InvisCheck
        Caption="Enable Invisibility Combo"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.48
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=SpeedCheck
        Caption="Enable Speed Combo"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.53
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=BerserkCheck
        Caption="Enable Berserk Combo"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.58
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.GUILabel Name=AdrenLabel
        Caption="----Adrenaline Combo Settings----"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.36
        WinLeft=0.25
    End Object
    ch_booster=BoosterCheck
    ch_invis=InvisCheck
    ch_speed=SpeedCheck
    ch_berserk=BerserkCheck
    l_adren=AdrenLabel
}
