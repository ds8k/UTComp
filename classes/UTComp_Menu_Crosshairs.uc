

class UTComp_Menu_Crosshairs extends UTComp_Menu_MainMenu;


#exec texture Import File=textures\64_4_circle.dds Name=BigCircle Mips=Off Alpha=1
#exec texture Import File=textures\64_3_circle.dds Name=MedCircle Mips=Off Alpha=1
#exec texture Import File=textures\64_2_circle.dds Name=SmallCircle Mips=Off Alpha=1
#exec texture Import File=textures\64_1_circle.dds Name=UberSmallCircle Mips=Off Alpha=1

#exec texture Import File=textures\32_4_circle.dds Name=BigCircle_2 Mips=Off Alpha=1
#exec texture Import File=textures\32_3_circle.dds Name=MedCircle_2 Mips=Off Alpha=1
#exec texture Import File=textures\32_2_circle.dds Name=SmallCircle_2 Mips=Off Alpha=1
#exec texture Import File=textures\32_1_circle.dds Name=UberSmallCircle_2 Mips=Off Alpha=1

#exec texture Import File=textures\32_Square_1.dds Name=BigSquare Mips=Off Alpha=1
#exec texture Import File=textures\32_Square_2.dds Name=BigSquare_2 Mips=Off Alpha=1
#exec texture Import File=textures\32_Square_3.dds Name=BigSquare_3 Mips=Off Alpha=1

#exec texture Import File=textures\32_diamond_1.dds Name=Bigdiamond Mips=Off Alpha=1
#exec texture Import File=textures\32_diamond_2.dds Name=Bigdiamond_2 Mips=Off Alpha=1
#exec texture Import File=textures\32_diamond_3.dds Name=Bigdiamond_3 Mips=Off Alpha=1

#exec texture Import File=textures\32_bracket_0.dds Name=Bigbracket Mips=Off Alpha=1
#exec texture Import File=textures\32_bracket_1.dds Name=Bigbracket_1 Mips=Off Alpha=1
#exec texture Import File=textures\32_bracket_2.dds Name=Bigbracket_2 Mips=Off Alpha=1
#exec texture Import File=textures\32_bracket_3.dds Name=Bigbracket_3 Mips=Off Alpha=1
#exec texture Import File=textures\32_bracket_4.dds Name=Bigbracket_4 Mips=Off Alpha=1
#exec texture Import File=textures\32_bracket_5.dds Name=Bigbracket_5 Mips=Off Alpha=1
#exec texture Import File=textures\32_bracket_6.dds Name=Bigbracket_6 Mips=Off Alpha=1
#exec texture Import File=textures\32_bracket_7.dds Name=Bigbracket_7 Mips=Off Alpha=1


#exec texture Import File=textures\32_VertLine.dds Name=BigHoriz Mips=Off Alpha=1
#exec texture Import File=textures\32_HorizLine.dds Name=BigVert Mips=Off Alpha=1


#exec texture Import File=textures\64_VertLine.dds Name=SmallHoriz Mips=Off Alpha=1
#exec texture Import File=textures\64_HorizLine.dds Name=SmallVert Mips=Off Alpha=1

var automated GUIListBox lb_CrossHairs;

var automated GUIComboBox co_UTCompCrosshairs;

var automated GUIButton bu_MoveUp, bu_MoveDown, bu_AddHair, bu_DeleteHair;

var automated moCheckBox ch_UseFactory, ch_SizeIncrease;

var automated GUISlider sl_SizeHair, sl_OpacityHair, sl_HorizHair, sl_VertHair;
var automated GUISlider sl_RedHair, sl_GreenHair, sl_BlueHair;

var automated GUILabel l_Size, l_Opacity, l_Horiz, l_Vert;
var automated GUILabel l_Red, l_Green, l_Blue;

var automated GUIImage i_CurrentHairBG, i_CurrentHair, i_TotalHairBG;
var automated GUIImage i_ListBoxBG;

var automated array<GUIImage> i_TotalHair;

struct UTCompCrosshair
{
    var string xHairName;
    var texture xHairTexture;
};

var array<UTCompCrosshair> UTCompNewHairs;

function InitComponent(GUIController MyController, GUIComponent MyOwner)
{
    local array<CacheManager.CrosshairRecord> CustomCrosshairs;
    local int i;

    Super.InitComponent(myController,MyOwner);
    class'CacheManager'.static.GetCrosshairList(CustomCrosshairs);

    //Select xHair combobox
    for(i=0; i<CustomCrosshairs.Length; i++)
        co_UTCompCrosshairs.AddItem(CustomCrosshairs[i].FriendlyName, CustomCrosshairs[i].CrosshairTexture);
    for(i=0; i<UTCompNewHairs.Length; i++)
        co_UTCompCrosshairs.AddItem(UTCompNewHairs[i].xHairName, UTCompNewHairs[i].xHairTexture);
    co_UTCompCrosshairs.ReadOnly(True);

    //ListBox of current xhairs
    lb_Crosshairs.List.bDropSource=True;
	lb_Crosshairs.List.bDropTarget=True;
	lb_Crosshairs.List.bMultiSelect=False;
    for(i=0; i<class'UTComp_HudSettings'.default.UTCompCrosshairs.Length; i++)
        lb_Crosshairs.List.Add(FindDescriptionFor(class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex), class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex);

    ch_UseFactory.Checked(class'UTComp_HudSettings'.default.bEnableUTCompCrosshairs);
    ch_SizeIncrease.Checked(class'UTComp_HudSettings'.default.bEnableCrosshairSizing);

    if(class'UTComp_HudSettings'.default.UTCompCrosshairs.Length>0)
    {
        sl_SizeHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossScale);
        sl_OpacityHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossColor.A);
        sl_HorizHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].OffsetX);
        sl_VertHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].OffsetY);
        sl_RedHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossColor.R);
        sl_GreenHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossColor.G);
        sl_BlueHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossColor.B);
    }

    i_CurrentHair.WinWidth=(0.10*class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossScale);
    i_CurrentHair.WinHeight=(0.10*class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossScale);
    i_CurrentHair.WinTop=0.480+(sl_VertHair.Value-0.50);
    i_CurrentHair.WinLeft=0.784+(sl_HorizHair.Value-0.50);

    if(class'UTComp_HudSettings'.default.UTCompCrosshairs.Length>0)
    {
        i_CurrentHair.Image=class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossTex;
        i_CurrentHair.ImageColor=class'UTComp_HudSettings'.default.UTCompCrosshairs[0].CrossColor;
    }

    RefreshFullCrossHair();
    DisableStuff();
}

function RefreshFullCrossHair()
{
    local int i;

    for(i=0; i<class'UTComp_HudSettings'.default.UTCompCrosshairs.Length && i<12; i++)
    {
        i_totalhair[i].WinWidth=(0.10*class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossScale);
        i_totalhair[i].WinHeight=(0.10*class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossScale);
        i_totalhair[i].WinTop=0.680+(class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetY-0.50);
        i_totalhair[i].WinLeft=0.784+(class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetX-0.50);
        i_totalhair[i].Image=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex;
        i_totalhair[i].ImageColor=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor;
    }
    for(i=class'UTComp_HudSettings'.default.UTCompCrosshairs.Length; i<12; i++)
        i_totalhair[i].Image=None;
}

function string FindDescriptionFor(Texture T)
{
    local array<CacheManager.CrosshairRecord> CustomCrosshairs;
    local int i;

    class'CacheManager'.static.GetCrosshairList(CustomCrosshairs);

    for(i=0; i<CustomCrosshairs.Length; i++)
        if(T==CustomCrosshairs[i].CrosshairTexture)
            return CustomCrosshairs[i].FriendlyName;
    for(i=0; i<UTCompNewHairs.Length; i++)
        if(T==UTCompNewHairs[i].xHairTexture)
            return UTCompNewHairs[i].xHairName;
    return string(T);
}

function InternalOnChange( GUIComponent C )
{
    Switch(C)
    {
    case ch_UseFactory: class'UTComp_HudSettings'.default.bEnableUTCompCrosshairs=ch_UseFactory.IsChecked();  break;
    case ch_SizeIncrease: class'UTComp_HudSettings'.default.bEnableCrosshairSizing=ch_SizeIncrease.IsChecked(); break;

        case sl_SizeHair: if(lb_CrossHairs.List.Index>=0)
                          class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossScale=sl_SizeHair.Value; break;
        case sl_OpacityHair: if(lb_CrossHairs.List.Index>=0)
                             class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.A=sl_OpacityHair.Value; break;
        case sl_HorizHair: if(lb_CrossHairs.List.Index>=0)
                           class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].OffsetX=sl_HorizHair.Value; break;
        case sl_VertHair: if(lb_CrossHairs.List.Index>=0)
                          class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].OffsetY=sl_VertHair.Value; break;
        case sl_RedHair: if(lb_CrossHairs.List.Index>=0)
                         class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.R=sl_RedHair.Value; break;
        case sl_GreenHair: if(lb_CrossHairs.List.Index>=0)
                           class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.G=sl_GreenHair.Value; break;
        case sl_BlueHair: if(lb_CrossHairs.List.Index>=0)
                          class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.B=sl_BlueHair.Value; break;

    case lb_CrossHairs:  UpdateSliders();
                         co_UTCompCrosshairs.SetIndex(co_UTCompCrosshairs.FindIndex(FindDescriptionFor(Texture(lb_CrossHairs.List.GetObject()))));
                         break;

    case co_UTCompCrosshairs:   if(lb_CrossHairs.List.Index>=0)
                          {
                              class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossTex=texture(co_UTCompCrosshairs.GetObject());
                              lb_CrossHairs.List.SetObjectAtIndex(lb_CrossHairs.List.Index,co_UTCompCrosshairs.GetObject());
                              lb_CrossHairs.List.SetItemAtIndex(lb_CrossHairs.List.Index,FindDescriptionFor(Texture(co_UTCompCrosshairs.GetObject())));
                              break;
                          }
    }
    class'UTComp_HudSettings'.static.StaticSaveConfig();
    UpdateImages();
    RefreshFullCrossHair();
    DisableStuff();
}

function DisableStuff()
{
     if(ch_UseFactory.IsChecked())
     {
         sl_SizeHair.EnableMe();
         sl_OpacityHair.EnableMe();
         sl_HorizHair.EnableMe();
         sl_VertHair.EnableMe();
         sl_RedHair.EnableMe();
         sl_GreenHair.EnableMe();
         sl_BlueHair.EnableMe();

         lb_CrossHairs.EnableMe();
         co_UTCompCrosshairs.EnableMe();
         bu_MoveUp.EnableMe();
         bu_MoveDown.EnableMe();
         bu_AddHair.EnableMe();
         bu_DeleteHair.EnableMe();
     }
     else
     {
         sl_SizeHair.DisableMe();
         sl_OpacityHair.DisableMe();
         sl_HorizHair.DisableMe();
         sl_VertHair.DisableMe();
         sl_RedHair.DisableMe();
         sl_GreenHair.DisableMe();
         sl_BlueHair.DisableMe();

         lb_CrossHairs.DisableMe();
         co_UTCompCrosshairs.DisableMe();
         bu_MoveUp.DisableMe();
         bu_MoveDown.DisableMe();
         bu_AddHair.DisableMe();
         bu_DeleteHair.DisableMe();
    }
    if(class'UTComp_HudSettings'.default.UTCompCrosshairs.Length==0)
    {
         sl_SizeHair.DisableMe();
         sl_OpacityHair.DisableMe();
         sl_HorizHair.DisableMe();
         sl_VertHair.DisableMe();
         sl_RedHair.DisableMe();
         sl_GreenHair.DisableMe();
         sl_BlueHair.DisableMe();

         lb_CrossHairs.DisableMe();
         co_UTCompCrosshairs.DisableMe();
         bu_MoveUp.DisableMe();
         bu_MoveDown.DisableMe();
         bu_DeleteHair.DisableMe();
    }
}

function UpdateSliders()
{
    if(lb_CrossHairs.List.Index<0)
         return;
    sl_SizeHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossScale);
    sl_OpacityHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.A);
    sl_HorizHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].OffsetX);
    sl_VertHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].OffsetY);
    sl_RedHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.R);
    sl_GreenHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.G);
    sl_BlueHair.SetValue(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index].CrossColor.B);

}

function UpdateImages()
{
    if(lb_Crosshairs.List.Index>=0)
    {
        i_CurrentHair.WinWidth=(0.10*class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].CrossScale);
        i_CurrentHair.WinHeight=(0.10*class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].CrossScale);
        i_CurrentHair.WinTop=0.480+(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].OffsetY-0.50);
        i_CurrentHair.WinLeft=0.784+(class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].OffsetX-0.50);

        if(class'UTComp_HudSettings'.default.UTCompCrosshairs.Length>0)
        {
            i_CurrentHair.Image=class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].CrossTex;
            i_CurrentHair.ImageColor=class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_Crosshairs.List.Index].CrossColor;
        }
    }
}

function SetupNewHair(int i)
{
    class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossScale=1.0;
    class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor.A=255;
    class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetX=0.50;
    class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetY=0.50;
    class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor.R=255;
    class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor.G=255;
    class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor.B=255;
}

function bool InternalOnClick( GUIComponent Sender )
{
    local int i;

    switch (Sender)
    {
        case bu_AddHair:   i=class'UTComp_HudSettings'.default.UTCompCrosshairs.Length;
                       class'UTComp_HudSettings'.default.UTCompCrosshairs.Length=i+1;
                       class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex=Texture(lb_Crosshairs.List.GetObject());
                       SetupNewHair(i);
                       UpdateSliders();
                       lb_Crosshairs.List.Add("New", None);
                       break;
        case bu_DeleteHair: i=lb_Crosshairs.List.Index;
                        if(i<class'UTComp_HudSettings'.default.UTCompCrosshairs.Length && i>=0)
                        {
                            class'UTComp_HudSettings'.default.UTCompCrosshairs.Remove(i,1);
                            lb_Crosshairs.List.Clear();
                            for(i=0; i<class'UTComp_HudSettings'.default.UTCompCrosshairs.Length; i++)
                               lb_Crosshairs.List.Add(FindDescriptionFor(class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex), class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex);
                        }
                        DisableStuff();
                        break;
        case bu_MoveUp:  if(lb_CrossHairs.List.Index>0)
                         {
                             lb_CrossHairs.List.Swap(lb_CrossHairs.List.Index,lb_CrossHairs.List.Index-1);
                             class'UTComp_HudSettings'.default.TempXHair=class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index];
                             class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index]=class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index-1];
                             class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index-1]=class'UTComp_HudSettings'.default.TempXHair;
                         }
                         break;
        case bu_MoveDown: if(class'UTComp_HudSettings'.default.UTCompCrosshairs.Length>lb_CrossHairs.List.Index+1 && lb_CrossHairs.List.Index>=0)
                          {
                             lb_CrossHairs.List.Swap(lb_CrossHairs.List.Index,lb_CrossHairs.List.Index+1);
                             class'UTComp_HudSettings'.default.TempXHair=class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index];
                             class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index]=class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index+1];
                             class'UTComp_HudSettings'.default.UTCompCrosshairs[lb_CrossHairs.List.Index+1]=class'UTComp_HudSettings'.default.TempXHair;
                          }
                          break;
    }
    UpdateImages();
    RefreshFullCrossHair();
    DisableStuff();
    return super.InternalOnClick(Sender);
}

defaultproperties
{
    Begin Object Class=XInterface.GUIImage Name=TotalHairImage0
        ImageStyle=ISTY_Scaled
        ImageAlign=IMGA_Center
        X1=0
        Y1=0
        X2=64
        Y2=64
    End Object
    Begin Object Class=XInterface.GUISlider Name=VertCrossSlider
        MinValue=0.4
        MaxValue=0.6
        Value=0.5
        WinTop=0.655
        WinLeft=0.41
        WinWidth=0.25
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=RedCrossSlider
        MaxValue=255.0
        Value=255.0
        bIntSlider=True
        WinTop=0.415
        WinLeft=0.41
        WinWidth=0.25
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=GreenCrossSlider
        MaxValue=255.0
        Value=255.0
        bIntSlider=True
        WinTop=0.455
        WinLeft=0.41
        WinWidth=0.25
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=HorizCrossSlider
        MinValue=0.4
        MaxValue=0.6
        Value=0.5
        WinTop=0.615
        WinLeft=0.41
        WinWidth=0.25
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=BlueCrossSlider
        MaxValue=255.0
        Value=255.0
        bIntSlider=True
        WinTop=0.495
        WinLeft=0.41
        WinWidth=0.25
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=SizeCrossSlider
        MaxValue=4.0
        Value=1.0
        WinTop=0.575
        WinLeft=0.41
        WinWidth=0.25
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUISlider Name=OpacityCrossSlider
        MaxValue=255.0
        Value=255.0
        bIntSlider=True
        WinTop=0.535
        WinLeft=0.41
        WinWidth=0.25
        OnClick=InternalOnClick
        OnMousePressed=InternalOnMousePressed
        OnMouseRelease=InternalOnMouseRelease
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
        OnCapturedMouseMove=InternalCapturedMouseMove
    End Object
    Begin Object Class=XInterface.GUIComboBox Name=CrosshairCombo
        WinTop=0.366666
        WinLeft=0.350001
        WinWidth=0.248444
        WinHeight=0.035
        OnChange=InternalOnChange
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIListBox Name=CrosshairListBox
        bVisibleWhenEmpty=True
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.392917
        WinLeft=0.14
        WinWidth=0.16
        WinHeight=0.264375
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=UseFactoryCheck
        Caption="Use Crosshair Factory"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.324583
        WinLeft=0.126562
        WinWidth=0.35
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.moCheckBox Name=SizeIncreaseCheck
        Caption="Crosshair Size Increase"
        OnCreateComponent=InternalOnCreateComponent
        WinTop=0.32875
        WinLeft=0.548751
        WinWidth=0.35
        OnChange=InternalOnChange
    End Object
    Begin Object Class=XInterface.GUIButton Name=AddHairButton
        Caption="Add"
        WinTop=0.688559
        WinLeft=0.126562
        WinWidth=0.08
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=DeleteHairButton
        Caption="Delete"
        WinTop=0.688559
        WinLeft=0.206562
        WinWidth=0.08
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=MoveUpHairButton
        Caption="Up"
        WinTop=0.734384
        WinLeft=0.126562
        WinWidth=0.08
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIButton Name=MoveDownHairButton
        Caption="Down"
        WinTop=0.734384
        WinLeft=0.206562
        WinWidth=0.08
        OnClick=InternalOnClick
        OnKeyEvent=InternalOnKeyEvent
    End Object
    Begin Object Class=XInterface.GUIImage Name=ListBoxBackgroundImage
        Image=Texture'2K4Menus.Controls.thinpipe_b'
        ImageStyle=ISTY_Stretched
        WinTop=0.372917
        WinLeft=0.12
        WinWidth=0.2
        WinHeight=0.304688
    End Object
    Begin Object Class=XInterface.GUILabel Name=RedCrossLabel
        Caption="Red"
        TextColor=(R=255,G=0,B=64,A=255)
        WinTop=0.4
        WinLeft=0.34
    End Object
    Begin Object Class=XInterface.GUILabel Name=GreenCrossLabel
        Caption="Green"
        TextColor=(R=0,G=255,B=64,A=255)
        WinTop=0.44
        WinLeft=0.34
    End Object
    Begin Object Class=XInterface.GUILabel Name=BlueCrossLabel
        Caption="Blue"
        TextColor=(R=0,G=0,B=255,A=255)
        WinTop=0.48
        WinLeft=0.34
    End Object
    Begin Object Class=XInterface.GUILabel Name=OpacityCrossLabel
        Caption="Alpha"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.52
        WinLeft=0.34
    End Object
    Begin Object Class=XInterface.GUILabel Name=SizeCrossLabel
        Caption="Size"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.56
        WinLeft=0.34
    End Object
    Begin Object Class=XInterface.GUILabel Name=HorizCrossLabel
        Caption="Left"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.6
        WinLeft=0.34
    End Object
    Begin Object Class=XInterface.GUILabel Name=VertCrossLabel
        Caption="Up"
        TextColor=(R=255,G=255,B=255,A=255)
        WinTop=0.64
        WinLeft=0.34
    End Object
    Begin Object Class=XInterface.GUIImage Name=CurrentHairBackgroundImage
        Image=Texture'2K4Menus.Controls.thinpipe_b'
        ImageStyle=ISTY_Stretched
        WinTop=0.372917
        WinLeft=0.68
        WinWidth=0.2
        WinHeight=0.2
    End Object
    Begin Object Class=XInterface.GUIImage Name=TotalHairBackgroundImage
        Image=Texture'2K4Menus.Controls.thinpipe_b'
        ImageStyle=ISTY_Stretched
        WinTop=0.58335
        WinLeft=0.68
        WinWidth=0.2
        WinHeight=0.2
    End Object
    Begin Object Class=XInterface.GUIImage Name=CurrentHAirImage
        ImageStyle=ISTY_Scaled
        ImageAlign=IMGA_Center
        X1=0
        Y1=0
        X2=64
        Y2=64
    End Object
    lb_CrossHairs=CrosshairListBox
    co_UTCompCrosshairs=CrosshairCombo
    bu_MoveUp=MoveUpHairButton
    bu_MoveDown=MoveDownHairButton
    bu_AddHair=AddHairButton
    bu_DeleteHair=DeleteHairButton
    ch_UseFactory=UseFactoryCheck
    ch_SizeIncrease=SizeIncreaseCheck
    sl_SizeHair=SizeCrossSlider
    sl_OpacityHair=OpacityCrossSlider
    sl_HorizHair=HorizCrossSlider
    sl_VertHair=VertCrossSlider
    sl_RedHair=RedCrossSlider
    sl_GreenHair=GreenCrossSlider
    sl_BlueHair=BlueCrossSlider
    l_Size=SizeCrossLabel
    l_Opacity=OpacityCrossLabel
    l_Horiz=HorizCrossLabel
    l_Vert=VertCrossLabel
    l_Red=RedCrossLabel
    l_Green=GreenCrossLabel
    l_Blue=BlueCrossLabel
    i_CurrentHairBG=CurrentHairBackgroundImage
    i_CurrentHair=CurrentHAirImage
    i_TotalHairBG=TotalHairBackgroundImage
    i_ListBoxBG=ListBoxBackgroundImage
    i_TotalHair(0)=TotalHairImage0
    i_TotalHair(1)=TotalHairImage0
    i_TotalHair(2)=TotalHairImage0
    i_TotalHair(3)=TotalHairImage0
    i_TotalHair(4)=TotalHairImage0
    i_TotalHair(5)=TotalHairImage0
    i_TotalHair(6)=TotalHairImage0
    i_TotalHair(7)=TotalHairImage0
    i_TotalHair(8)=TotalHairImage0
    i_TotalHair(9)=TotalHairImage0
    i_TotalHair(10)=TotalHairImage0
    i_TotalHair(11)=TotalHairImage0
    UTCompNewHairs(0)=(xHairName="Big Circle(0)",xHairTexture=Texture'UTCompvBoM.BigCircle')
    UTCompNewHairs(1)=(xHairName="Big Circle(1)",xHairTexture=Texture'UTCompvBoM.MedCircle')
    UTCompNewHairs(2)=(xHairName="Big Circle(2)",xHairTexture=Texture'UTCompvBoM.SmallCircle')
    UTCompNewHairs(3)=(xHairName="Big Circle(3)",xHairTexture=Texture'UTCompvBoM.UberSmallCircle')
    UTCompNewHairs(4)=(xHairName="Small Circle(0)",xHairTexture=Texture'UTCompvBoM.BigCircle_2')
    UTCompNewHairs(5)=(xHairName="Small Circle(1)",xHairTexture=Texture'UTCompvBoM.MedCircle_2')
    UTCompNewHairs(6)=(xHairName="Small Circle(2)",xHairTexture=Texture'UTCompvBoM.SmallCircle_2')
    UTCompNewHairs(7)=(xHairName="Small Circle(3)",xHairTexture=Texture'UTCompvBoM.UberSmallCircle_2')
    UTCompNewHairs(8)=(xHairName="Big Square(0)",xHairTexture=Texture'UTCompvBoM.BigSquare')
    UTCompNewHairs(9)=(xHairName="Big Square(1)",xHairTexture=Texture'UTCompvBoM.BigSquare_2')
    UTCompNewHairs(10)=(xHairName="Big Square(2)",xHairTexture=Texture'UTCompvBoM.BigSquare_3')
    UTCompNewHairs(11)=(xHairName="Big diamond(0)",xHairTexture=Texture'UTCompvBoM.Bigdiamond')
    UTCompNewHairs(12)=(xHairName="Big Diamond(1)",xHairTexture=Texture'UTCompvBoM.Bigdiamond_2')
    UTCompNewHairs(13)=(xHairName="Big Diamond(2)",xHairTexture=Texture'UTCompvBoM.Bigdiamond_3')
    UTCompNewHairs(14)=(xHairName="Big Horiz",xHairTexture=Texture'UTCompvBoM.SmallVert')
    UTCompNewHairs(15)=(xHairName="Small Horiz",xHairTexture=Texture'UTCompvBoM.BigVert')
    UTCompNewHairs(16)=(xHairName="Big Vert",xHairTexture=Texture'UTCompvBoM.SmallHoriz')
    UTCompNewHairs(17)=(xHairName="Small Vert",xHairTexture=Texture'UTCompvBoM.BigHoriz')
    UTCompNewHairs(18)=(xHairName="Big 'L'(0)",xHairTexture=Texture'UTCompvBoM.Bigbracket')
    UTCompNewHairs(19)=(xHairName="Big 'L'(1)",xHairTexture=Texture'UTCompvBoM.Bigbracket_1')
    UTCompNewHairs(20)=(xHairName="Big 'L'(2)",xHairTexture=Texture'UTCompvBoM.Bigbracket_2')
    UTCompNewHairs(21)=(xHairName="Big 'L'(3)",xHairTexture=Texture'UTCompvBoM.Bigbracket_3')
    UTCompNewHairs(22)=(xHairName="Big 'L'(4)",xHairTexture=Texture'UTCompvBoM.Bigbracket_4')
    UTCompNewHairs(23)=(xHairName="Big 'L'(5)",xHairTexture=Texture'UTCompvBoM.Bigbracket_5')
    UTCompNewHairs(24)=(xHairName="Big 'L'(6)",xHairTexture=Texture'UTCompvBoM.Bigbracket_6')
    UTCompNewHairs(25)=(xHairName="Big 'L'(7)",xHairTexture=Texture'UTCompvBoM.Bigbracket_7')
}
