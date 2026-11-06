

class UTComp_Menu_ColorNames extends UTComp_Menu_MainMenu;

var automated GUILabel l_ColorNameLetters[20];
var automated GUILabel l_LetterSelection;
var automated moCheckBox ch_ColorChat, ch_ColorScoreboard, ch_ColorQ3, ch_EnemyNames/*, ch_ColorRedBlue, ch_ColorDeath*/;
var automated GUIComboBox co_SavedNames;
var automated GUIButton bu_SaveName, bu_DeleteName, bu_ResetWhite, bu_Apply;
var automated GUISlider sl_RedColor, sl_BlueColor, sl_GreenColor;
var automated GUILabel l_RedLabel, l_BlueLabel, l_GreenLabel;
var automated GUISlider sl_LetterSelect;
var automated moComboBox co_DeathSelect;

event Opened(GUIComponent Sender)
{
    InitSliderAndLetters();
    super.Opened(Sender);
}

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
     local int i;

     Super.InitComponent(myController,MyOwner);

     for(i=0; i<class'UTComp_Settings'.default.ColoredName.Length; i++)
         co_SavedNames.AddItem(BS_xPlayer(PlayerOwner()).FindColoredName(i));
     co_SavedNames.ReadOnly(True);

     InitSliderAndLetters();

     SetColorSliders(0);

     ch_ColorChat.Checked(class'UTComp_Settings'.default.bEnableColoredNamesInTalk);
     ch_ColorScoreboard.Checked(class'UTComp_ScoreBoard'.default.bEnableColoredNamesOnScoreboard);
     ch_ColorQ3.Checked(class'UTComp_Settings'.default.bAllowColoredMessages);
     ch_EnemyNames.Checked(class'UTComp_Settings'.default.bEnableColoredNamesOnEnemies);
   //  ch_ColorRedBlue.Checked(class'UTComp_xDeathMessage'.default.bEnableTeamColoredDeaths);
   //  ch_ColorDeath.Checked(class'UTComp_xDeathMessage'.default.drawcolorednamesindeathmessages);
     co_DeathSelect.AddItem("Disabled");
     co_DeathSelect.AddItem("Colored Names");
     co_DeathSelect.AddItem("Red/Blue Colored Names");
     co_DeathSelect.ReadOnly(True);

     if(class'UTComp_xDeathMessage'.default.bEnableTeamColoredDeaths)
         co_DeathSelect.SetIndex(2);
     else if(class'UTComp_xDeathMessage'.default.drawcolorednamesindeathmessages)
         co_DeathSelect.SetIndex(1);
}

function InitSliderAndLetters()
{
     local int i;

     for(i=0; i<Len(PlayerOwner().PlayerReplicationInfo.PlayerName); i++)
     {
          class'UTComp_Settings'.default.ColorName[i].A=255;     //make sure someone didnt change this
          l_ColorNameLetters[i].TextFont="UT2LargeFont";
          l_ColorNameLetters[i].WinTop=0.50;
          l_ColorNameLetters[i].WinWidth=0.029;
          l_ColorNameLetters[i].WinLeft=(0.50-(0.50*0.030*Len(PlayerOwner().PlayerReplicationInfo.PlayerName))+(0.030*i));
          l_ColorNameLetters[i].StyleName="TextLabel";
          l_ColorNameLetters[i].Caption=Right(Left(PlayerOwner().PlayerReplicationInfo.PlayerName, (i+1)), 1);
          l_ColorNameLetters[i].TextColor=class'UTComp_Settings'.default.ColorName[i];
          l_ColorNameLetters[i].TextAlign=TXTA_Center;
     }
     for(i=Len(PlayerOwner().PlayerReplicationInfo.PlayerName); i<20; i++)
          l_ColorNameLetters[i].Caption="";

      sl_LetterSelect.MinValue=1;
      sl_LetterSelect.WinLeft=(0.50-(0.50*0.030*Len(PlayerOwner().PlayerReplicationInfo.PlayerName)));
      sl_LetterSelect.MaxValue=Min((Len(PlayerOwner().PlayerReplicationInfo.PlayerName)), 20);
      sl_LetterSelect.WinWidth=(0.0297*Min((Len(PlayerOwner().PlayerReplicationInfo.PlayerName)), 20));
      sl_LetterSelect.BarStyle=None;
      sl_LetterSelect.FillImage=None;
}

function SpecialInitSliderAndLetters(int j)
{
     local int i;

     for(i=0; i<Len(class'UTComp_Settings'.default.ColoredName[j].SavedName); i++)
     {
          class'UTComp_Settings'.default.ColorName[i].A=255;     //make sure someone didnt change this
          l_ColorNameLetters[i].TextFont="UT2LargeFont";
          l_ColorNameLetters[i].WinTop=0.50;
          l_ColorNameLetters[i].WinWidth=0.029;
          l_ColorNameLetters[i].WinLeft=(0.50-(0.50*0.030*Len(class'UTComp_Settings'.default.ColoredName[j].SavedName))+(0.030*i));
          l_ColorNameLetters[i].StyleName="TextLabel";
          l_ColorNameLetters[i].Caption=Right(Left(class'UTComp_Settings'.default.ColoredName[j].SavedName, (i+1)), 1);
          l_ColorNameLetters[i].TextColor=class'UTComp_Settings'.default.ColoredName[j].SavedColor[i];
          l_ColorNameLetters[i].TextAlign=TXTA_Center;
     }
     for(i=Len(class'UTComp_Settings'.default.ColoredName[j].SavedName); i<20; i++)
          l_ColorNameLetters[i].Caption="";

      sl_LetterSelect.MinValue=1;
      sl_LetterSelect.WinLeft=(0.50-(0.50*0.030*Len(PlayerOwner().PlayerReplicationInfo.PlayerName)));
      sl_LetterSelect.MaxValue=Min((Len(PlayerOwner().PlayerReplicationInfo.PlayerName)), 20);
      sl_LetterSelect.WinWidth=(0.0297*Min((Len(PlayerOwner().PlayerReplicationInfo.PlayerName)), 20));
      sl_LetterSelect.BarStyle=None;
      sl_LetterSelect.FillImage=None;
}
function SetColorSliders(byte offset)
{
    sl_RedColor.SetValue(class'UTComp_Settings'.default.colorname[offset].R);
    sl_BlueColor.SetValue(class'UTComp_Settings'.default.colorname[offset].B);
    sl_GreenColor.SetValue(class'UTComp_Settings'.default.colorname[offset].G);
}

function InternalOnChange( GUIComponent C )
{

    switch(C)
    {
    case ch_ColorChat: class'UTComp_Settings'.default.bEnableColoredNamesInTalk=ch_ColorChat.IsChecked();  break;
    case ch_ColorScoreboard: class'UTComp_ScoreBoard'.default.bEnableColoredNamesOnScoreboard=ch_ColorScoreboard.IsChecked(); break;
    case ch_ColorQ3: class'UTComp_Settings'.default.bAllowColoredMessages=ch_ColorQ3.IsChecked(); break;
    case ch_EnemyNames: class'UTComp_Settings'.default.bEnableColoredNamesOnEnemies=ch_EnemyNames.IsChecked(); break;
  //  case ch_ColorRedBlue: class'UTComp_xDeathMessage'.default.bEnableTeamColoredDeaths=ch_ColorRedBlue.IsChecked(); break;
 //   case ch_ColorDeath: class'UTComp_xDeathMessage'.default.drawcolorednamesindeathmessages=ch_ColorDeath.IsChecked(); break;
    case co_DeathSelect:  class'UTComp_xDeathMessage'.default.bEnableTeamColoredDeaths=(co_DeathSelect.GetIndex()==2);
                          class'UTComp_xDeathMessage'.default.drawcolorednamesindeathmessages=(co_DeathSelect.GetIndex()==1); break;
    case sl_LetterSelect: SetColorSliders(sl_LetterSelect.Value-1); break;

    case sl_RedColor:   class'UTComp_Settings'.default.ColorName[sl_LetterSelect.Value-1].R=sl_RedColor.Value;
                        BS_xPlayer(PlayerOwner()).SetColoredNameOldStyle();
                        l_ColorNameLetters[sl_LetterSelect.Value-1].TextColor.R=sl_RedColor.Value;  break;
    case sl_BlueColor:  class'UTComp_Settings'.default.ColorName[sl_LetterSelect.Value-1].B=sl_BlueColor.Value;
                        BS_xPlayer(PlayerOwner()).SetColoredNameOldStyle();
                        l_ColorNameLetters[sl_LetterSelect.Value-1].TextColor.B=sl_BlueColor.Value;  break;
    case sl_GreenColor: class'UTComp_Settings'.default.ColorName[sl_LetterSelect.Value-1].G=sl_GreenColor.Value;
                        BS_xPlayer(PlayerOwner()).SetColoredNameOldStyle();
                        l_ColorNameLetters[sl_LetterSelect.Value-1].TextColor.G=sl_GreenColor.Value;  break;

    case co_SavedNames:   /* BS_xPlayer(PlayerOwner()).default.CurrentSelectedColoredName=co_savedNames.GetIndex();
                           BS_xPlayer(PlayerOwner()).SetInitialColoredName();
                           InitSliderAndLetters();*/   break;
    }
    BS_xPlayer(PlayerOwner()).MakeSureSaveConfig();
    class'BS_xPlayer'.Static.StaticSaveConfig();
    class'UTComp_ScoreBoard'.Static.StaticSaveConfig();
    class'UTComp_xDeathMessage'.Static.StaticSaveConfig();
    class'UTComp_Settings'.static.staticSaveConfig();
}

function bool InternalOnClick( GUIComponent Sender )
{
    local int i;

    switch (Sender)
    {

    case bu_SaveName:
                       BS_xPlayer(PlayerOwner()).SaveNewColoredName();
                       co_SavedNames.ReadOnly(False);
                       co_SavedNames.AddItem(BS_xPlayer(PlayerOwner()).AddNewColoredName(class'UTComp_Settings'.default.ColoredName.Length-1));
                       co_SavedNames.ReadOnly(True); break;


    case bu_DeleteName:  if(class'UTComp_Settings'.default.ColoredName.Length>co_SavedNames.GetIndex() && co_SavedNames.GetIndex()>=0)
                             class'UTComp_Settings'.default.ColoredName.Remove(co_SavedNames.GetIndex(), 1);
                        // BS_xPlayer(PlayerOwner()).ColoredName=class'UTComp_Settings'.default.ColoredName;
                         co_SavedNames.ReadOnly(False);
                         co_SavedNames.RemoveItem(co_SavedNames.GetIndex());
                         co_SavedNames.ReadOnly(True); break;

    case bu_ResetWhite:   for(i=0; i<20; i++)
                          {
                              class'UTComp_Settings'.default.colorname[i].R=255;
                              class'UTComp_Settings'.default.colorname[i].G=255;
                              class'UTComp_Settings'.default.colorname[i].B=255;
                              l_ColorNameLetters[i].TextColor.R=255;
                              l_ColorNameLetters[i].TextColor.G=255;
                              l_ColorNameLetters[i].TextColor.B=255;
                          }   break;
    case bu_Apply:
                    BS_xPlayer(PlayerOwner()).SetColoredNameOldStyleCustom(,co_SavedNames.GetIndex());
                    class'UTComp_Settings'.default.CurrentSelectedColoredName=co_savedNames.GetIndex();
                    SpecialInitSliderAndLetters(co_SavedNames.GetIndex());
                    SetColorSliders(sl_LetterSelect.Value-1);  break;
    }
    BS_xPlayer(PlayerOwner()).MakeSureSaveConfig();
    class'BS_xPlayer'.Static.StaticSaveConfig();
    class'UTComp_Settings'.static.staticSaveConfig();

    Super.InternalOnClick(Sender);
    return true;
}

defaultproperties
{
    Begin Object Class=XInterface.GUISlider Name=LetterSlider
        Value=1.0
        bIntSlider=True
        WinTop=0.535
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=GreenSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.65
        WinLeft=0.6
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=BlueSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.7
        WinLeft=0.6
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=RedSlider
        MaxValue=255.0
        bIntSlider=True
        WinTop=0.6
        WinLeft=0.6
        WinWidth=0.3
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.moCheckBox Name=ColorChatCheck
        Caption="Show colored names in chat messages"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.33
        WinLeft=0.2
        WinWidth=0.6
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=ColorScoreboardCheck
        Caption="Show colored names on scoreboard"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.365
        WinLeft=0.2
        WinWidth=0.6
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=Colorq3Check
        Caption="Show colored text in chat messages(Q3 Style)"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.433814
        WinLeft=0.2
        WinWidth=0.6
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=EnemyNamesCheck
        Caption="Show colored enemy names on targeting"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.4
        WinLeft=0.2
        WinWidth=0.6
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.GUIComboBox Name=ComboSaved
        WinTop=0.61232
        WinLeft=0.140625
        WinWidth=0.3
        WinHeight=0.031875
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=ButtonSave
        Caption="Save"
        WinTop=0.65
        WinLeft=0.142187
        WinWidth=0.133437
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=ButtonDelete
        Caption="Delete"
        WinTop=0.65
        WinLeft=0.303125
        WinWidth=0.133125
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=ButtonWhite
        Caption="Reset entire name to white"
        WinTop=0.739585
        WinLeft=0.540625
        WinWidth=0.344063
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=ButtonApply
        Caption="Use This Name"
        WinTop=0.695833
        WinLeft=0.140625
        WinWidth=0.297188
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.moComboBox Name=ColorDeathCombo
        Caption="Death Message Color:"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.46799
        WinLeft=0.168749
        WinWidth=0.660936
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label0
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label1
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label2
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label3
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label4
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label5
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label6
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label7
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label8
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label9
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label10
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label11
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label12
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label13
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label14
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label15
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label16
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label17
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label18
    End Object
    Begin Object Class=XInterface.GUILabel Name=Label19
    End Object
    Begin Object Class=XInterface.GUILabel Name=RedLabel
        Caption="Red"
        TextColor=(R=255,G=0,B=64,A=255)
        WinTop=0.5875
        WinLeft=0.528125
    End Object
    Begin Object Class=XInterface.GUILabel Name=BlueLabel
        Caption="Blue"
        TextColor=(R=0,G=0,B=255,A=255)
        WinTop=0.685414
        WinLeft=0.528125
    End Object
    Begin Object Class=XInterface.GUILabel Name=GreenLabel
        Caption="Green"
        TextColor=(R=0,G=255,B=64,A=255)
        WinTop=0.635417
        WinLeft=0.528125
    End Object
    l_ColorNameLetters(0)=Label0
    l_ColorNameLetters(1)=Label1
    l_ColorNameLetters(2)=Label2
    l_ColorNameLetters(3)=Label3
    l_ColorNameLetters(4)=Label4
    l_ColorNameLetters(5)=Label5
    l_ColorNameLetters(6)=Label6
    l_ColorNameLetters(7)=Label7
    l_ColorNameLetters(8)=Label8
    l_ColorNameLetters(9)=Label9
    l_ColorNameLetters(10)=Label10
    l_ColorNameLetters(11)=Label11
    l_ColorNameLetters(12)=Label12
    l_ColorNameLetters(13)=Label13
    l_ColorNameLetters(14)=Label14
    l_ColorNameLetters(15)=Label15
    l_ColorNameLetters(16)=Label16
    l_ColorNameLetters(17)=Label17
    l_ColorNameLetters(18)=Label18
    l_ColorNameLetters(19)=Label19
    ch_ColorChat=ColorChatCheck
    ch_ColorScoreboard=ColorScoreboardCheck
    ch_ColorQ3=Colorq3Check
    ch_EnemyNames=EnemyNamesCheck
    co_SavedNames=ComboSaved
    bu_SaveName=ButtonSave
    bu_DeleteName=ButtonDelete
    bu_ResetWhite=ButtonWhite
    bu_Apply=ButtonApply
    sl_RedColor=RedSlider
    sl_BlueColor=BlueSlider
    sl_GreenColor=GreenSlider
    l_RedLabel=RedLabel
    l_BlueLabel=BlueLabel
    l_GreenLabel=GreenLabel
    sl_LetterSelect=LetterSlider
    co_DeathSelect=ColorDeathCombo
}
