

class UTComp_Menu_HitSounds extends UTComp_Menu_MainMenu;

var automated GUISlider sl_Volume;
var automated GUISlider sl_Pitch;

var automated moCheckBox ch_CPMAStyle;
var automated moCheckBox ch_EnableHitSounds;

var automated GUIComboBox co_EnemySound;
var automated GUIComboBox co_FriendlySound;

var automated GUILabel l_Volume;
var automated GUILabel l_Pitch;
var automated GUILabel l_EnemySound;
var automated GUILabel l_FriendlySound;


function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    super.InitComponent(MyController,MyOwner);

    sl_Volume.Value=class'UTComp_Settings'.default.HitSoundVolume;
    sl_Pitch.Value=class'UTComp_Settings'.default.CPMAPitchModifier;

    ch_CPMAStyle.Checked(class'UTComp_Settings'.default.bCPMAStyleHitsounds);
    ch_EnableHitSounds.Checked(class'UTComp_Settings'.default.bEnableHitSounds);

    co_EnemySound.AddItem((class'UTComp_Settings'.default.EnemySound));
    co_FriendlySound.AddItem((class'UTComp_Settings'.default.FriendlySound));

    DisableStuff();
}

function DisableStuff()
{
    local UTComp_ServerReplicationInfo RepInfo;

    foreach PlayerOwner().DynamicActors(class'UTComp_ServerReplicationInfo', RepInfo)
        break;

    if(!ch_EnableHitSounds.IsChecked() || (RepInfo!=None && RepInfo.EnableHitSoundsMode==0))
    {
        sl_volume.DisableMe();
        sl_Pitch.DisableMe();
        co_EnemySound.DisableMe();
        co_FriendlySound.DisableMe();
        ch_CPMAStyle.DisableMe();
    }
    else
    {
        sl_volume.EnableMe();
        if(ch_CPMAStyle.IsChecked())
        {
            sl_Pitch.EnableMe();
        }
        else
        {
            sl_Pitch.DisableMe();
        }
        co_EnemySound.EnableMe();
        co_FriendlySound.EnableMe();
        ch_CPMAStyle.EnableMe();
    }
}

function InternalOnChange( GUIComponent C )
{
    switch(C)
    {
        case ch_EnableHitSounds: class'UTComp_Settings'.default.bEnableHitSounds=ch_enableHitSounds.IsChecked(); break;
        case sl_Volume:  class'UTComp_Settings'.default.HitSoundVolume=sl_Volume.Value; break;
        case sl_Pitch:  class'UTComp_Settings'.default.CPMAPitchModifier=sl_Pitch.Value; break;
    //    case co_EnemySound:  class'UTComp_Settings'.default.EnemySound=Sound(DynamicLoadObject(co_EnemySound.GetText(), class'Sound', True)); break;
   //    case co_FriendlySound:  class'UTComp_Settings'.default.FriendlySound=Sound(DynamicLoadObject(co_FriendlySound.GetText(), class'Sound', True)); break;
        case co_EnemySound:  class'UTComp_Settings'.default.EnemySound=co_EnemySound.GetText(); break;
        case co_FriendlySound:  class'UTComp_Settings'.default.FriendlySound=co_FriendlySound.GetText(); break;
        case ch_CPMAStyle:   class'UTComp_Settings'.default.bCPMAStyleHitSounds=ch_CPMAStyle.IsChecked(); break;
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
  //  class'UTComp_Settings'.default.EnemySound=Sound(DynamicLoadObject(co_EnemySound.GetText(), class'Sound', True));
 //   class'UTComp_Settings'.default.FriendlySound=Sound(DynamicLoadObject(co_FriendlySound.GetText(), class'Sound', True));
    class'UTComp_Settings'.default.EnemySound=co_EnemySound.GetText();
    class'UTComp_Settings'.default.FriendlySound=co_FriendlySound.GetText();
    BS_xPlayer(PlayerOwner()).MakeSureSaveConfig();
    BS_xPlayer(PlayerOwner()).LoadedFriendlySound = None;
    BS_xPlayer(PlayerOwner()).LoadedEnemySound = none;
    class'UTComp_Settings'.static.staticSaveConfig();
    class'BS_xPlayer'.Static.StaticSaveConfig();

    return true;
}

defaultproperties
{
    Begin Object Class=XInterface.GUISlider Name=HitSoundVolume
        MaxValue=4.0
        WinTop=0.44
        WinLeft=0.25
        WinWidth=0.5
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=PitchMod
        MinValue=1.0
        MaxValue=3.0
        Value=1.0
        WinTop=0.59
        WinLeft=0.25
        WinWidth=0.5
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.moCheckBox Name=CPMAstyle
        Caption="CPMA Style Hitsounds"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.49
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=EnableHit
        Caption="Enable Hitsounds"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.36
        WinLeft=0.25
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.GUIComboBox Name=EnemySound
        WinTop=0.654
        WinLeft=0.4125
        WinWidth=0.34
        WinHeight=0.03
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIComboBox Name=TeammateSound
        WinTop=0.704
        WinLeft=0.4125
        WinWidth=0.34
        WinHeight=0.03
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUILabel Name=VolumeLabel
        Caption="Hitsound Volume"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.39
        WinLeft=0.25
    End Object
    Begin Object Class=XInterface.GUILabel Name=PitchLabel
        Caption="CPMA Pitch Modifier"
        TextColor=(R=230,G=200,B=0,A=255)
        WinTop=0.54
        WinLeft=0.25
    End Object
    Begin Object Class=XInterface.GUILabel Name=EnemySoundLabel
        Caption="Enemy Sound"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.64
        WinLeft=0.25
    End Object
    Begin Object Class=XInterface.GUILabel Name=FriendlySoundLabel
        Caption="Team Sound"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.69
        WinLeft=0.25
    End Object
    sl_Volume=HitSoundVolume
    sl_Pitch=PitchMod
    ch_CPMAStyle=CPMAstyle
    ch_EnableHitSounds=EnableHit
    co_EnemySound=EnemySound
    co_FriendlySound=TeammateSound
    l_Volume=VolumeLabel
    l_Pitch=PitchLabel
    l_EnemySound=EnemySoundLabel
    l_FriendlySound=FriendlySoundLabel
}
