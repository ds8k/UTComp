class UTComp_HudCDeathmatch extends HudCDeathmatch;

//Variable declarations as a "header" include. Must be on top!
//Vars courtesy of HUD Scaling Fix by Azarael
var const float XShifts[9];
var const float YShifts[9];

var bool bWSD;		// Is widescreen support default in the game code?
function PostBeginPlay()
{
	SetTimer(0.1, true);
	Super.PostBeginPlay();
}

function Timer()	// Allows LevelInfo enough time to set up. In practice it shouldn't actually loop
{
    if (PlayerOwner != None && PlayerOwner.Level != None && PlayerOwner.Level.EngineVersion != "")
    {
		if (int(PlayerOwner.Level.EngineVersion) >= 3374)
		{
			bWSD = True;
		}
	
        SetTimer(0.0, false);
        return;
    }
}

/*
	COPYRIGHT NOTICE
	Below code is copyright Azarael - used with permission:
	https://steamcommunity.com/app/13230/discussions/0/611702631218438023/#c611702631227999537
*/

//Common rendering code used in all widescreen HUDs
//Courtesy of HUD Scaling Fix by Azarael, modified a bit for portability
simulated final function DrawSpriteTileWidget(Canvas C, SpriteWidget W)
{
	C.Style = W.RenderStyle;
	C.DrawColor = W.Tints[TeamIndex];

	if (W.Scale == 1.0f || W.ScaleMode == SM_None) {
		C.SetPos(
			(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot])
				* W.TextureScale * ResScaleY * HUDScale,
			(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot])
				* W.TextureScale * ResScaleY * HUDScale
		);
		C.DrawTile(
			W.WidgetTexture,
			Abs(W.TextureCoords.X2 - W.TextureCoords.X1)
				* W.TextureScale * ResScaleY * HUDScale,
			Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1)
				* W.TextureScale * ResScaleY * HUDScale,
			W.TextureCoords.X1,
			W.TextureCoords.Y1,
			W.TextureCoords.X2 - W.TextureCoords.X1,
			W.TextureCoords.Y2 - W.TextureCoords.Y1
		);
	}
	else {
		switch(W.ScaleMode) {
			case SM_Right:
				C.SetPos(
					(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot])
						* W.TextureScale * ResScaleY * HUDScale,
					(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot])
						* W.TextureScale * ResScaleY * HUDScale
				);
				C.DrawTile(
					W.WidgetTexture,
					Abs(W.TextureCoords.X2 - W.TextureCoords.X1)
						* W.TextureScale * ResScaleY * HUDScale * W.Scale,
					Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1)
						* W.TextureScale * ResScaleY * HUDScale,
					W.TextureCoords.X1,
					W.TextureCoords.Y1,
					(W.TextureCoords.X2 - W.TextureCoords.X1)
						* W.Scale,
					W.TextureCoords.Y2 - W.TextureCoords.Y1
				);
				break;

			case SM_Left:
				C.SetPos(
					(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot]
							+ (Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * (1 - W.Scale)))
						* W.TextureScale * ResScaleY * HUDScale,
					(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot])
						* W.TextureScale * ResScaleY * HUDScale
				);
				C.DrawTile(
					W.WidgetTexture,
					Abs(W.TextureCoords.X2 - W.TextureCoords.X1)
						* W.TextureScale * ResScaleY * HUDScale * W.Scale,
					Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1)
						* W.TextureScale * ResScaleY * HUDScale,
					W.TextureCoords.X1
						+ ((W.TextureCoords.X2 - W.TextureCoords.X1) * (1 - W.Scale)),
					W.TextureCoords.Y1,
					(W.TextureCoords.X2 - W.TextureCoords.X1)
						* W.Scale,
					W.TextureCoords.Y2 - W.TextureCoords.Y1
				);
				break;

			case SM_Down:
				C.SetPos(
					(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot])
						* W.TextureScale * ResScaleY * HUDScale,
					(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot])
						* W.TextureScale * ResScaleY * HUDScale
				);
				C.DrawTile(
					W.WidgetTexture,
					Abs(W.TextureCoords.X2 - W.TextureCoords.X1)
						* W.TextureScale * ResScaleY * HUDScale,
					Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1)
						* W.TextureScale * ResScaleY * HUDScale * W.Scale,
					W.TextureCoords.X1,
					W.TextureCoords.Y1,
					W.TextureCoords.X2 - W.TextureCoords.X1,
					(W.TextureCoords.Y2 - W.TextureCoords.Y1)
						* W.Scale
				);
				break;
			case SM_Up:
				C.SetPos(
					(C.ClipX * W.PosX) + (W.OffsetX - Abs(W.TextureCoords.X2 - W.TextureCoords.X1) * XShifts[W.DrawPivot])
						* W.TextureScale * ResScaleY * HUDScale,
					(C.ClipY * W.PosY) + (W.OffsetY - Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * YShifts[W.DrawPivot]
							+ Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1) * (1 - W.Scale))
						* W.TextureScale * ResScaleY * HUDScale
				);
				C.DrawTile(
					W.WidgetTexture,
					Abs(W.TextureCoords.X2 - W.TextureCoords.X1)
						* W.TextureScale * ResScaleY * HUDScale,
					Abs(W.TextureCoords.Y2 - W.TextureCoords.Y1)
						* W.TextureScale * ResScaleY * HUDScale * W.Scale,
					W.TextureCoords.X1,
					W.TextureCoords.Y1
						+ (W.TextureCoords.Y2 - W.TextureCoords.Y1) * (1 - W.Scale),
					W.TextureCoords.X2 - W.TextureCoords.X1,
					(W.TextureCoords.Y2 - W.TextureCoords.Y1)
						* W.Scale
				);
		}
	}
}

simulated final function DrawNumericTileWidget(Canvas C, NumericWidget W, DigitSet D)
{
	local String s;
	local array<String> t;
	local int padding, length, i;
	local byte coordindex;

	C.Style = W.RenderStyle;
	C.DrawColor = W.Tints[TeamIndex];

	s = String(W.Value);
	length = Len(s);

	padding = Max(0, W.MinDigitCount - length);

	if (W.bPadWithZeroes != 0)
		length += padding;
	for (i = 0; i < length; i++) {
		if (W.bPadWithZeroes == 1 && i < padding)
			t[i] = "0";
		else {
			t[i] = "";
			EatStr(t[i], s, 1);
		}
	}

	C.SetPos(
		(C.ClipX * W.PosX) + (W.OffsetX - (D.TextureCoords[0].X2 - D.TextureCoords[0].X1) * (((length + padding) * XShifts[W.DrawPivot]) - (padding * (1 - W.bPadWithZeroes))))
			* W.TextureScale * ResScaleY * HUDScale,
		(C.ClipY * W.PosY) + (W.OffsetY - (D.TextureCoords[0].Y2 - D.TextureCoords[0].Y1) * YShifts[W.DrawPivot])
			* W.TextureScale * ResScaleY * HUDScale
	);

	for (i = 0; i < length; i++) {
		if (t[i] == "-")
			coordindex = 10;
		else coordindex = byte(t[i]);

		C.DrawTile(
			D.DigitTexture,
			(D.TextureCoords[coordindex].X2 - D.TextureCoords[coordindex].X1)
				* W.TextureScale * ResScaleY * HUDScale,
			(D.TextureCoords[coordindex].Y2 - D.TextureCoords[coordindex].Y1)
				* W.TextureScale * ResScaleY * HUDScale,
			D.TextureCoords[coordindex].X1,
			D.TextureCoords[coordindex].Y1,
			D.TextureCoords[coordindex].X2 - D.TextureCoords[coordindex].X1,
			D.TextureCoords[coordindex].Y2 - D.TextureCoords[coordindex].Y1
		);
	}
}


/*
	COPYRIGHT NOTICE
	Below code is copyright Epic Games - all rights reserved
	(Note: This package is not endorsed by Epic Games)

	It is included for technical purposes only (e.g. to enable widescreen functionality)
	There are a two specific function replacements made:
		DrawSpriteWidget -> DrawSpriteTileWidget
		DrawNumericWidget -> DrawNumericTileWidget
	Additionally, Super function calls are replaced with the appropriate "Wide" call:
		Super.AbcXYZ -> WideAbcXYZ
	Finally, there may be smaller tweaks made based on Azarael's original HUDFix Mutator
	These changes are marked with ~fox on a per-line basis detailing what changed
*/

//#include Classes\Include\_Internal\DrawAdrenaline.uci
simulated function DrawAdrenaline(Canvas C)
{
	if ( !PlayerOwner.bAdrenalineEnabled )
		return;

	DrawSpriteTileWidget( C, AdrenalineBackground );
	DrawSpriteTileWidget( C, AdrenalineBackgroundDisc );

	if( CurEnergy == MaxEnergy )
	{
		DrawSpriteTileWidget( C, AdrenalineAlert );
		AdrenalineAlert.Tints[TeamIndex] = HudColorHighLight;
	}

	DrawSpriteTileWidget( C, AdrenalineIcon );
	DrawNumericTileWidget( C, AdrenalineCount, DigitsBig);

	if(CurEnergy > LastEnergy)
		LastAdrenalineTime = Level.TimeSeconds;

	LastEnergy = CurEnergy;
	DrawHUDAnimWidget( AdrenalineIcon, default.AdrenalineIcon.TextureScale, LastAdrenalineTime, 0.6, 0.6);
	AdrenalineBackground.Tints[TeamIndex] = HudColorBlack;
	AdrenalineBackground.Tints[TeamIndex].A = 150;
}

/*
	COPYRIGHT NOTICE
	Below code is copyright Epic Games - all rights reserved
	(Note: This package is not endorsed by Epic Games)

	It is included for technical purposes only (e.g. to enable widescreen functionality)
	There are a two specific function replacements made:
		DrawSpriteWidget -> DrawSpriteTileWidget
		DrawNumericWidget -> DrawNumericTileWidget
	Additionally, Super function calls are replaced with the appropriate "Wide" call:
		Super.AbcXYZ -> WideAbcXYZ
	Finally, there may be smaller tweaks made based on Azarael's original HUDFix Mutator
	These changes are marked with ~fox on a per-line basis detailing what changed
*/

//#include Classes\Include\_Internal\DrawChargeBar.uci
simulated function DrawChargeBar(Canvas C)
{
	local float ScaleFactor;

	ScaleFactor = HUDScale * 0.135 * C.ClipX;
	ScaleFactor *= ResScaleY / ResScaleX; //Courtesy of HUD Scaling Fix by Azarael ~fox
	C.Style = ERenderStyle.STY_Alpha;
	if ( (PawnOwner.PlayerReplicationInfo == None) || (PawnOwner.PlayerReplicationInfo.Team == None)
		|| (PawnOwner.PlayerReplicationInfo.Team.TeamIndex == 1) )
		C.DrawColor = HudColorBlue;
	else
		C.DrawColor = HudColorRed;

	C.SetPos(C.ClipX - ScaleFactor - 0.0011*HUDScale*C.ClipX, (1 - 0.0975*HUDScale)*C.ClipY);
	C.DrawTile( Material'HudContent.HUD', ScaleFactor, 0.223*ScaleFactor, 0, 110, 166, 53 );

	RechargeBar.Scale = PawnOwner.Weapon.ChargeBar();
	if ( RechargeBar.Scale > 0 )
	{
		DrawSpriteTileWidget( C, RechargeBar );
		ShowReloadingPulse(RechargeBar.Scale);
	}
}

/*
	COPYRIGHT NOTICE
	Below code is copyright Epic Games - all rights reserved
	(Note: This package is not endorsed by Epic Games)

	It is included for technical purposes only (e.g. to enable widescreen functionality)
	There are a two specific function replacements made:
		DrawSpriteWidget -> DrawSpriteTileWidget
		DrawNumericWidget -> DrawNumericTileWidget
	Additionally, Super function calls are replaced with the appropriate "Wide" call:
		Super.AbcXYZ -> WideAbcXYZ
	Finally, there may be smaller tweaks made based on Azarael's original HUDFix Mutator
	These changes are marked with ~fox on a per-line basis detailing what changed
*/

simulated function DrawCrossHair(Canvas C)
{
	if(class'UTComp_HudSettings'.default.bEnableUTCompCrosshairs && class'UTComp_HudSettings'.default.UTCompCrosshairs.Length>0)
        DrawUTCompCrosshair(C);
    else
        WideDrawCrosshair(C);
}

simulated function WideDrawCrosshair(Canvas C)
{
	local float NormalScale;
	local int i, CurrentCrosshair;
	local float OldScale,OldW, CurrentCrosshairScale;
	local color CurrentCrosshairColor;
	local SpriteWidget CHtexture;

	if ( PawnOwner.bSpecialCrosshair )
	{
		PawnOwner.SpecialDrawCrosshair( C );
		return;
	}

	if (!bCrosshairShow)
		return;

	if ( bUseCustomWeaponCrosshairs && (PawnOwner != None) && (PawnOwner.Weapon != None) )
	{
		CurrentCrosshair = PawnOwner.Weapon.CustomCrosshair;
		if (CurrentCrosshair == -1 || CurrentCrosshair == Crosshairs.Length)
		{
			CurrentCrosshair = CrosshairStyle;
			CurrentCrosshairColor = CrosshairColor;
			CurrentCrosshairScale = CrosshairScale;
		}
		else
		{
			CurrentCrosshairColor = PawnOwner.Weapon.CustomCrosshairColor;
			CurrentCrosshairScale = PawnOwner.Weapon.CustomCrosshairScale;
			if ( PawnOwner.Weapon.CustomCrosshairTextureName != "" )
			{
				if ( PawnOwner.Weapon.CustomCrosshairTexture == None )
				{
					PawnOwner.Weapon.CustomCrosshairTexture = Texture(DynamicLoadObject(PawnOwner.Weapon.CustomCrosshairTextureName,class'Texture'));
					if ( PawnOwner.Weapon.CustomCrosshairTexture == None )
					{
						log(PawnOwner.Weapon$" custom crosshair texture not found!");
						PawnOwner.Weapon.CustomCrosshairTextureName = "";
					}
				}
				CHTexture = Crosshairs[0];
				CHTexture.WidgetTexture = PawnOwner.Weapon.CustomCrosshairTexture;
			}
		}
	}
	else
	{
		CurrentCrosshair = CrosshairStyle;
		CurrentCrosshairColor = CrosshairColor;
		CurrentCrosshairScale = CrosshairScale;
	}

	CurrentCrosshair = Clamp(CurrentCrosshair, 0, Crosshairs.Length - 1);

	NormalScale = Crosshairs[CurrentCrosshair].TextureScale;
	if ( CHTexture.WidgetTexture == None )
		CHTexture = Crosshairs[CurrentCrosshair];
	CHTexture.TextureScale *= 0.5 * CurrentCrosshairScale;

	for( i = 0; i < ArrayCount(CHTexture.Tints); i++ )
		CHTexture.Tints[i] = CurrentCrossHairColor;

	if ( LastPickupTime > Level.TimeSeconds - 0.4 )
	{
		if ( LastPickupTime > Level.TimeSeconds - 0.2 )
			CHTexture.TextureScale *= (1 + 5 * (Level.TimeSeconds - LastPickupTime));
		else
			CHTexture.TextureScale *= (1 + 5 * (LastPickupTime + 0.4 - Level.TimeSeconds));
	}
	OldScale = HudScale;
	HudScale=1;
	OldW = C.ColorModulate.W;
	C.ColorModulate.W = 1;
	DrawSpriteTileWidget (C, CHTexture);
	C.ColorModulate.W = OldW;
	HudScale=OldScale;
	CHTexture.TextureScale = NormalScale;

	DrawEnemyName(C);
}

simulated function DrawUTCompCrosshair (Canvas C)
{
    local int i;
    local float OldScale,OldW;
	local array<SpriteWidget> CHtexture;

	if ( PawnOwner.bSpecialCrosshair )
	{
		PawnOwner.SpecialDrawCrosshair( C );
		return;
	}

	if (!bCrosshairShow)
        return;

    for(i=0; i<class'UTComp_HudSettings'.default.UTCompCrosshairs.Length; i++)
    {
        CHTexture.Length=i+1;
        CHTexture[i].WidgetTexture=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex;
        CHTexture[i].RenderStyle=STY_Alpha;
        CHTexture[i].TextureCoords.X2=64;
        CHTexture[i].TextureCoords.Y2=64;
        CHTexture[i].TextureScale=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossScale*0.50;
        CHTexture[i].DrawPivot=DP_MiddleMiddle;
        CHTexture[i].PosX=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetX;
        CHTexture[i].PosY=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].OffsetY;
        CHTexture[i].ScaleMode = SM_None;
        CHTexture[i].Scale=1.00;
        CHTexture[i].Tints[0]=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor;
        CHTexture[i].Tints[1]=class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossColor;
    }

    if ( class'UTComp_HudSettings'.default.bEnableCrosshairSizing && LastPickupTime > Level.TimeSeconds - 0.4 )
	{
		if ( LastPickupTime > Level.TimeSeconds - 0.2 )
			for(i=0; i<CHTexture.Length; i++)
                CHTexture[i].TextureScale *= (1 + 5 * (Level.TimeSeconds - LastPickupTime));
		else
			for(i=0; i<CHTexture.Length; i++)
                CHTexture[i].TextureScale *= (1 + 5 * (LastPickupTime + 0.4 - Level.TimeSeconds));
	}
    OldScale = HudScale;
    HudScale=1;
    OldW = C.ColorModulate.W;
    C.ColorModulate.W = 1;
    for(i=0; i<CHTexture.Length; i++)
        DrawSpriteTileWidget (C, CHTexture[i]);
    C.ColorModulate.W = OldW;
	HudScale=OldScale;

	DrawEnemyName(C);
}
/*
	COPYRIGHT NOTICE
	Below code is copyright Epic Games - all rights reserved
	(Note: This package is not endorsed by Epic Games)

	It is included for technical purposes only (e.g. to enable widescreen functionality)
	There are a two specific function replacements made:
		DrawSpriteWidget -> DrawSpriteTileWidget
		DrawNumericWidget -> DrawNumericTileWidget
	Additionally, Super function calls are replaced with the appropriate "Wide" call:
		Super.AbcXYZ -> WideAbcXYZ
	Finally, there may be smaller tweaks made based on Azarael's original HUDFix Mutator
	These changes are marked with ~fox on a per-line basis detailing what changed
*/

/*
	COPYRIGHT NOTICE
	Below code is copyright Epic Games - all rights reserved
	(Note: This package is not endorsed by Epic Games)

	It is included for technical purposes only (e.g. to enable widescreen functionality)
	There are a two specific function replacements made:
		DrawSpriteWidget -> DrawSpriteTileWidget
		DrawNumericWidget -> DrawNumericTileWidget
	Additionally, Super function calls are replaced with the appropriate "Wide" call:
		Super.AbcXYZ -> WideAbcXYZ
	Finally, there may be smaller tweaks made based on Azarael's original HUDFix Mutator
	These changes are marked with ~fox on a per-line basis detailing what changed
*/

simulated function WideDrawHudPassA(Canvas C)
{
	local Pawn RealPawnOwner;
	local class<Ammunition> AmmoClass;

	ZoomFadeOut(C);

	if ( PawnOwner != None )
	{
		if( bShowWeaponInfo && (PawnOwner.Weapon != None) )
		{
			if ( PawnOwner.Weapon.bShowChargingBar )
				DrawChargeBar(C);

			DrawSpriteTileWidget( C, HudBorderAmmo );

			if( PawnOwner.Weapon != None )
			{
				AmmoClass = PawnOwner.Weapon.GetAmmoClass(0);
				if ( (AmmoClass != None) && (AmmoClass.Default.IconMaterial != None) )
				{
					if( (CurAmmoPrimary/MaxAmmoPrimary) < 0.15)
					{
						DrawSpriteTileWidget(C, HudAmmoALERT);
						HudAmmoALERT.Tints[TeamIndex] = HudColorTeam[TeamIndex];
						if ( AmmoClass.Default.IconFlashMaterial == None )
							AmmoIcon.WidgetTexture = Material'HudContent.Generic.HUDPulse';
						else
							AmmoIcon.WidgetTexture = AmmoClass.Default.IconFlashMaterial;
					}
					else
					{
						AmmoIcon.WidgetTexture = AmmoClass.default.IconMaterial;
					}

					AmmoIcon.TextureCoords = AmmoClass.Default.IconCoords;
					DrawSpriteTileWidget (C, AmmoIcon);
				}
			}
			DrawNumericTileWidget( C, DigitsAmmo, DigitsBig);
		}

		if ( bShowWeaponBar && (PawnOwner.Weapon != None) )
			DrawWeaponBar(C);

		if( bShowPersonalInfo )
		{
			if ( Vehicle(PawnOwner) != None && Vehicle(PawnOwner).Driver != None )
			{
				if (Vehicle(PawnOwner).bShowChargingBar)
					DrawVehicleChargeBar(C);
				RealPawnOwner = PawnOwner;
				PawnOwner = Vehicle(PawnOwner).Driver;
			}

			DrawHUDAnimWidget( HudBorderHealthIcon, default.HudBorderHealthIcon.TextureScale, LastHealthPickupTime, 0.6, 0.6);
			DrawSpriteTileWidget( C, HudBorderHealth );

			if(CurHealth/PawnOwner.HealthMax < 0.26)
			{
				HudHealthALERT.Tints[TeamIndex] = HudColorTeam[TeamIndex];
				DrawSpriteTileWidget( C, HudHealthALERT);
				HudBorderHealthIcon.WidgetTexture = Material'HudContent.Generic.HUDPulse';
			}
			else
				HudBorderHealthIcon.WidgetTexture = default.HudBorderHealth.WidgetTexture;

			DrawSpriteTileWidget( C, HudBorderHealthIcon);

			if( CurHealth < LastHealth )
				LastDamagedHealth = Level.TimeSeconds;

			DrawHUDAnimDigit( DigitsHealth, default.DigitsHealth.TextureScale, LastDamagedHealth, 0.8, default.DigitsHealth.Tints[TeamIndex], HudColorHighLight);
			DrawNumericTileWidget( C, DigitsHealth, DigitsBig);

			if(CurHealth > 999)
			{
				DigitsHealth.OffsetX=220;
				DigitsHealth.OffsetY=-35;
				DigitsHealth.TextureScale=0.39;
			}
			else
			{
				DigitsHealth.OffsetX = default.DigitsHealth.OffsetX;
				DigitsHealth.OffsetY = default.DigitsHealth.OffsetY;
				DigitsHealth.TextureScale = default.DigitsHealth.TextureScale;
			}

			if (RealPawnOwner != None)
			{
				PawnOwner = RealPawnOwner;

				DrawSpriteTileWidget( C, HudBorderVehicleHealth );

				if (CurVehicleHealth/PawnOwner.HealthMax < 0.26)
				{
					HudVehicleHealthALERT.Tints[TeamIndex] = HudColorTeam[TeamIndex];
					DrawSpriteTileWidget(C, HudVehicleHealthALERT);
					HudBorderVehicleHealthIcon.WidgetTexture = Material'HudContent.Generic.HUDPulse';
				}
				else
					HudBorderVehicleHealthIcon.WidgetTexture = default.HudBorderVehicleHealth.WidgetTexture;

				DrawSpriteTileWidget(C, HudBorderVehicleHealthIcon);

				if (CurVehicleHealth < LastVehicleHealth )
					LastDamagedVehicleHealth = Level.TimeSeconds;

				DrawHUDAnimDigit(DigitsVehicleHealth, default.DigitsVehicleHealth.TextureScale, LastDamagedVehicleHealth, 0.8, default.DigitsVehicleHealth.Tints[TeamIndex], HudColorHighLight);
				DrawNumericTileWidget(C, DigitsVehicleHealth, DigitsBig);

				if (CurVehicleHealth > 999)
				{
					//DigitsVehicleHealth.OffsetX = 220; //Replaced w/ below line ~fox
					DigitsVehicleHealth.OffsetX = 445; //Courtesy of HUD Scaling Fix by Azarael ~fox
					DigitsVehicleHealth.OffsetY = -35;
					DigitsVehicleHealth.TextureScale = 0.39;
				}
				else
				{
					DigitsVehicleHealth.OffsetX = default.DigitsVehicleHealth.OffsetX;
					DigitsVehicleHealth.OffsetY = default.DigitsVehicleHealth.OffsetY;
					DigitsVehicleHealth.TextureScale = default.DigitsVehicleHealth.TextureScale;
				}
			}

			DrawAdrenaline(C);
		}
	}

	UpdateRankAndSpread(C);
	DrawUDamage(C);

	if(bDrawTimer)
		DrawTimer(C);

	// Temp Drawwwith Hud Colors
	HudBorderShield.Tints[0] = HudColorRed;
	HudBorderShield.Tints[1] = HudColorBlue;
	HudBorderHealth.Tints[0] = HudColorRed;
	HudBorderHealth.Tints[1] = HudColorBlue;
	HudBorderVehicleHealth.Tints[0] = HudColorRed;
	HudBorderVehicleHealth.Tints[1] = HudColorBlue;
	HudBorderAmmo.Tints[0] = HudColorRed;
	HudBorderAmmo.Tints[1] = HudColorBlue;

	if( bShowPersonalInfo && (CurShield > 0) )
	{
		DrawSpriteTileWidget( C, HudBorderShield );
		DrawSpriteTileWidget( C, HudBorderShieldIcon);
		DrawNumericTileWidget( C, DigitsShield, DigitsBig);
		DrawHUDAnimWidget( HudBorderShieldIcon, default.HudBorderShieldIcon.TextureScale, LastArmorPickupTime, 0.6, 0.6);
	}

	if( Level.TimeSeconds - LastVoiceGainTime < 0.333 )
		DisplayVoiceGain(C);

	DisplayLocalMessages (C);
}

simulated function DrawHudPassA(Canvas C)
{
	WideDrawHudPassA(C);
}

/*
	COPYRIGHT NOTICE
	Below code is copyright Epic Games - all rights reserved
	(Note: This package is not endorsed by Epic Games)

	It is included for technical purposes only (e.g. to enable widescreen functionality)
	There are a two specific function replacements made:
		DrawSpriteWidget -> DrawSpriteTileWidget
		DrawNumericWidget -> DrawNumericTileWidget
	Additionally, Super function calls are replaced with the appropriate "Wide" call:
		Super.AbcXYZ -> WideAbcXYZ
	Finally, there may be smaller tweaks made based on Azarael's original HUDFix Mutator
	These changes are marked with ~fox on a per-line basis detailing what changed
*/

simulated function DrawTimer(Canvas C)
{
	local GameReplicationInfo GRI;
	local int Minutes, Hours, Seconds;
	local UTComp_Warmup uWarmup;

	GRI = PlayerOwner.GameReplicationInfo;
    if(BS_xPlayer(PlayerOwner)!=None)
    {
        if(BS_xPlayer(PlayerOwner).uWarmup!=None)
           uWarmup=BS_xPlayer(PlayerOwner).uWarmup;
    }

    if (GRI.TimeLimit==0)
        Seconds=GRI.ElapsedTime;
    else if(GRI.RemainingTime>0 || GRI.ElapsedTime<60 || (uWarmup!=None && uWarmup.bInWarmup))
        Seconds=GRI.RemainingTime;
    else
        Seconds=GRI.ElapsedTime-GRI.TimeLimit*60-1;

	TimerBackground.Tints[TeamIndex] = HudColorBlack;
	TimerBackground.Tints[TeamIndex].A = 150;

	DrawSpriteTileWidget( C, TimerBackground);
	DrawSpriteTileWidget( C, TimerBackgroundDisc);
	DrawSpriteTileWidget( C, TimerIcon);

	TimerMinutes.OffsetX = default.TimerMinutes.OffsetX - 80;
	TimerSeconds.OffsetX = default.TimerSeconds.OffsetX - 80;
	TimerDigitSpacer[0].OffsetX = Default.TimerDigitSpacer[0].OffsetX;
	TimerDigitSpacer[1].OffsetX = Default.TimerDigitSpacer[1].OffsetX;

	if( Seconds > 3600 )
	{
		Hours = Seconds / 3600;
		Seconds -= Hours * 3600;

		DrawNumericTileWidget( C, TimerHours, DigitsBig);
		TimerHours.Value = Hours;

		if(Hours>9)
		{
			TimerMinutes.OffsetX = default.TimerMinutes.OffsetX;
			TimerSeconds.OffsetX = default.TimerSeconds.OffsetX;
		}
		else
		{
			TimerMinutes.OffsetX = default.TimerMinutes.OffsetX -40;
			TimerSeconds.OffsetX = default.TimerSeconds.OffsetX -40;
			TimerDigitSpacer[0].OffsetX = Default.TimerDigitSpacer[0].OffsetX - 32;
			TimerDigitSpacer[1].OffsetX = Default.TimerDigitSpacer[1].OffsetX - 32;
		}
		DrawSpriteTileWidget( C, TimerDigitSpacer[0]);
	}
	DrawSpriteTileWidget( C, TimerDigitSpacer[1]);

	Minutes = Seconds / 60;
	Seconds -= Minutes * 60;

	TimerMinutes.Value = Min(Minutes, 60);
	TimerSeconds.Value = Min(Seconds, 60);

	DrawNumericTileWidget( C, TimerMinutes, DigitsBig);
	DrawNumericTileWidget( C, TimerSeconds, DigitsBig);
}

/*
	COPYRIGHT NOTICE
	Below code is copyright Epic Games - all rights reserved
	(Note: This package is not endorsed by Epic Games)

	It is included for technical purposes only (e.g. to enable widescreen functionality)
	There are a two specific function replacements made:
		DrawSpriteWidget -> DrawSpriteTileWidget
		DrawNumericWidget -> DrawNumericTileWidget
	Additionally, Super function calls are replaced with the appropriate "Wide" call:
		Super.AbcXYZ -> WideAbcXYZ
	Finally, there may be smaller tweaks made based on Azarael's original HUDFix Mutator
	These changes are marked with ~fox on a per-line basis detailing what changed
*/

//#include Classes\Include\_Internal\DrawUDamage.uci
simulated function DrawUDamage(Canvas C)
{
	local xPawn P;

	if (Vehicle(PawnOwner) != None)
		P = xPawn(Vehicle(PawnOwner).Driver);
	else
		P = xPawn(PawnOwner);

	if (P != None && P.UDamageTime > Level.TimeSeconds)
	{
		 if (P.UDamageTime > Level.TimeSeconds + 15 )
			UDamageIcon.TextureScale = default.UDamageIcon.TextureScale * FMin((P.UDamageTime - Level.TimeSeconds)* 0.0333,1);

		 DrawSpriteTileWidget(C, UDamageIcon);
		 UDamageTime.Value = P.UDamageTime - Level.TimeSeconds ;
		 DrawNumericTileWidget(C, UDamageTime, DigitsBig);
	}
}

/*
	COPYRIGHT NOTICE
	Below code is copyright Epic Games - all rights reserved
	(Note: This package is not endorsed by Epic Games)

	It is included for technical purposes only (e.g. to enable widescreen functionality)
	There are a two specific function replacements made:
		DrawSpriteWidget -> DrawSpriteTileWidget
		DrawNumericWidget -> DrawNumericTileWidget
	Additionally, Super function calls are replaced with the appropriate "Wide" call:
		Super.AbcXYZ -> WideAbcXYZ
	Finally, there may be smaller tweaks made based on Azarael's original HUDFix Mutator
	These changes are marked with ~fox on a per-line basis detailing what changed
*/

//#include Classes\Include\_Internal\DrawVehicleChargeBar.uci
simulated function WideDrawVehicleChargeBar(Canvas C)
{
	local float ScaleFactor;

	ScaleFactor = HUDScale * 0.135 * C.ClipX;
	ScaleFactor *= ResScaleY / ResScaleX; //Courtesy of HUD Scaling Fix by Azarael ~fox
	C.Style = ERenderStyle.STY_Alpha;
	if ( (PawnOwner.PlayerReplicationInfo == None) || (PawnOwner.PlayerReplicationInfo.Team == None)
		|| (PawnOwner.PlayerReplicationInfo.Team.TeamIndex == 1) )
		C.DrawColor = HudColorBlue;
	else
		C.DrawColor = HudColorRed;

	C.SetPos(C.ClipX - ScaleFactor - 0.0011*HUDScale*C.ClipX, (1 - 0.0975*HUDScale)*C.ClipY);
	C.DrawTile( Material'HudContent.HUD', ScaleFactor, 0.223*ScaleFactor, 0, 110, 166, 53 );

	DrawSpriteTileWidget(C, RechargeBar);
	RechargeBar.Scale = Vehicle(PawnOwner).ChargeBar();
	ShowReloadingPulse(RechargeBar.Scale);
}

simulated function DrawVehicleChargeBar(Canvas C)
{
	WideDrawVehicleChargeBar(C);
}

/*
	COPYRIGHT NOTICE
	Below code is copyright Epic Games - all rights reserved
	(Note: This package is not endorsed by Epic Games)

	It is included for technical purposes only (e.g. to enable widescreen functionality)
	There are a two specific function replacements made:
		DrawSpriteWidget -> DrawSpriteTileWidget
		DrawNumericWidget -> DrawNumericTileWidget
	Additionally, Super function calls are replaced with the appropriate "Wide" call:
		Super.AbcXYZ -> WideAbcXYZ
	Finally, there may be smaller tweaks made based on Azarael's original HUDFix Mutator
	These changes are marked with ~fox on a per-line basis detailing what changed
*/

simulated function WideDrawWeaponBar(Canvas C)
{
	local int i, Count, Pos;
	local float IconOffset;
	//local float HudScaleOffset, HudMinScale; //Removed, no longer needed ~fox

	local Weapon Weapons[WEAPON_BAR_SIZE];
	local byte ExtraWeapon[WEAPON_BAR_SIZE];
	local Inventory Inv;
	local Weapon W, PendingWeapon;

	//HudMinScale=0.5; // //Removed, no longer needed ~fox
	// CurHudScale = HudScale;
	//no weaponbar for vehicles
	if (Vehicle(PawnOwner) != None)
	return;

	if (PawnOwner.PendingWeapon != None)
		PendingWeapon = PawnOwner.PendingWeapon;
	else
		PendingWeapon = PawnOwner.Weapon;

	// fill:
	for( Inv=PawnOwner.Inventory; Inv!=None; Inv=Inv.Inventory )
	{
		W = Weapon( Inv );
		Count++;
		if ( Count > 100 )
			break;

		if( (W == None) || (W.IconMaterial == None) )
			continue;

		if ( W.InventoryGroup == 0 )
			Pos = 8;
		else if ( W.InventoryGroup < 10 )
			Pos = W.InventoryGroup-1;
		else
			continue;

		if ( Weapons[Pos] != None )
			ExtraWeapon[Pos] = 1;
		else
			Weapons[Pos] = W;
	}

	if ( PendingWeapon != None )
	{
		if ( PendingWeapon.InventoryGroup == 0 )
			Weapons[8] = PendingWeapon;
		else if ( PendingWeapon.InventoryGroup < 10 )
			Weapons[PendingWeapon.InventoryGroup-1] = PendingWeapon;
	}

	// Draw:
	for( i=0; i<WEAPON_BAR_SIZE; i++ )
	{
		W = Weapons[i];

		// Keep weaponbar organized when scaled
		//HudScaleOffset= 1-(HudScale-HudMinScale)/HudMinScale; //Removed, no longer needed ~fox
		//BarBorder[i].PosX =  default.BarBorder[i].PosX+( BarBorderScaledPosition[i] - default.BarBorder[i].PosX) *HudScaleOffset; //Replaced w/ below line ~fox
		BarBorder[i].PosX = 0.5 - ((0.5 - default.BarBorder[i].PosX) * HudScale * (ResScaleY/ResScaleX)); //Courtesy of HUD Scaling Fix by Azarael ~fox

		BarWeaponIcon[i].PosX = BarBorder[i].PosX;

		IconOffset = (default.BarBorder[i].TextureCoords.X2 - default.BarBorder[i].TextureCoords.X1) *0.5 ;
		BarWeaponIcon[i].OffsetX =	IconOffset;

		BarBorder[i].Tints[0] = HudColorRed;
		BarBorder[i].Tints[1] = HudColorBlue;
		BarBorder[i].OffsetY = 0;
		BarWeaponIcon[i].OffsetY = default.BarWeaponIcon[i].OffsetY;

		if( W == none )
		{
			BarWeaponStates[i].HasWeapon = false;
			if ( bShowMissingWeaponInfo )
			{
				if ( BarWeaponIcon[i].Tints[TeamIndex] != HudColorBlack )
				{
					BarWeaponIcon[i].WidgetTexture = default.BarWeaponIcon[i].WidgetTexture;
					BarWeaponIcon[i].TextureCoords = default.BarWeaponIcon[i].TextureCoords;
					BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale;
					BarWeaponIcon[i].Tints[TeamIndex] = HudColorBlack;
					BarWeaponIconAnim[i] = 0;
				}
				DrawSpriteTileWidget( C, BarBorder[i] );
				DrawSpriteTileWidget( C, BarWeaponIcon[i] ); // FIXME- have combined version
			}
	   }
		else
		{
			if( !BarWeaponStates[i].HasWeapon )
			{
				// just picked this weapon up!
				BarWeaponStates[i].PickupTimer = Level.TimeSeconds;
				BarWeaponStates[i].HasWeapon = true;
			}

			BarBorderAmmoIndicator[i].PosX = BarBorder[i].PosX;
			BarBorderAmmoIndicator[i].OffsetY = 0;
			BarWeaponIcon[i].WidgetTexture = W.IconMaterial;
			BarWeaponIcon[i].TextureCoords = W.IconCoords;

			BarBorderAmmoIndicator[i].Scale = W.AmmoStatus();
			BarWeaponIcon[i].Tints[TeamIndex] = HudColorNormal;

			if( BarWeaponIconAnim[i] == 0 )
			{
				if ( BarWeaponStates[i].PickupTimer > Level.TimeSeconds - 0.6 )
				{
				   if ( BarWeaponStates[i].PickupTimer > Level.TimeSeconds - 0.3 )
				   {
					   	BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale * (1 + 1.3 * (Level.TimeSeconds - BarWeaponStates[i].PickupTimer));
						BarWeaponIcon[i].OffsetX =	IconOffset - IconOffset * ( Level.TimeSeconds - BarWeaponStates[i].PickupTimer );
				   }
				   else
				   {
						BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale * (1 + 1.3 * (BarWeaponStates[i].PickupTimer + 0.6 - Level.TimeSeconds));
						BarWeaponIcon[i].OffsetX = IconOffset - IconOffset * (BarWeaponStates[i].PickupTimer + 0.6 - Level.TimeSeconds);
				   }
				}
				else
				{
					BarWeaponIconAnim[i] = 1;
					BarWeaponIcon[i].TextureScale = default.BarWeaponIcon[i].TextureScale;
				}
			}

			if (W == PendingWeapon)
			{
				// Change color to highlight and possibly changeTexture or animate it
				BarBorder[i].Tints[TeamIndex] = HudColorHighLight;
				BarBorder[i].OffsetY = -10;
				BarBorderAmmoIndicator[i].OffsetY = -10;
				BarWeaponIcon[i].OffsetY += -10;
			}
			if ( ExtraWeapon[i] == 1 )
			{
				if ( W == PendingWeapon )
				{
					BarBorder[i].Tints[0] = HudColorRed;
					BarBorder[i].Tints[1] = HudColorBlue;
					BarBorder[i].OffsetY = 0;
					BarBorder[i].TextureCoords.Y1 = 80;
					DrawSpriteTileWidget( C, BarBorder[i] );
					BarBorder[i].TextureCoords.Y1 = 39;
					BarBorder[i].OffsetY = -10;
					BarBorder[i].Tints[TeamIndex] = HudColorHighLight;
				}
				else
				{
					BarBorder[i].OffsetY = -52;
					BarBorder[i].TextureCoords.Y2 = 48;
					DrawSpriteTileWidget( C, BarBorder[i] );
					BarBorder[i].TextureCoords.Y2 = 93;
					BarBorder[i].OffsetY = 0;
				}
			}
			DrawSpriteTileWidget( C, BarBorder[i] );
			DrawSpriteTileWidget( C, BarBorderAmmoIndicator[i] );
			DrawSpriteTileWidget( C, BarWeaponIcon[i] );
	   }
	}
}

simulated function DrawWeaponBar(Canvas C)
{
	if (bWSD)
	{
		Super.DrawWeaponBar( C );
		return;
	}

	WideDrawWeaponBar(C);
}

/*
	COPYRIGHT NOTICE
	Below code is copyright Epic Games - all rights reserved
	(Note: This package is not endorsed by Epic Games)

	It is included for technical purposes only (e.g. to enable widescreen functionality)
	There are a two specific function replacements made:
		DrawSpriteWidget -> DrawSpriteTileWidget
		DrawNumericWidget -> DrawNumericTileWidget
	Additionally, Super function calls are replaced with the appropriate "Wide" call:
		Super.AbcXYZ -> WideAbcXYZ
	Finally, there may be smaller tweaks made based on Azarael's original HUDFix Mutator
	These changes are marked with ~fox on a per-line basis detailing what changed
*/

/*
	COPYRIGHT NOTICE
	Below code is copyright Epic Games - all rights reserved
	(Note: This package is not endorsed by Epic Games)

	It is included for technical purposes only (e.g. to enable widescreen functionality)
	There are a two specific function replacements made:
		DrawSpriteWidget -> DrawSpriteTileWidget
		DrawNumericWidget -> DrawNumericTileWidget
	Additionally, Super function calls are replaced with the appropriate "Wide" call:
		Super.AbcXYZ -> WideAbcXYZ
	Finally, there may be smaller tweaks made based on Azarael's original HUDFix Mutator
	These changes are marked with ~fox on a per-line basis detailing what changed
*/

simulated function WideUpdateRankAndSpread(Canvas C)
{
	local int i;

	if ( (Scoreboard == None) || !Scoreboard.UpdateGRI() )
		return;

	for( i=0 ; i<PlayerOwner.GameReplicationInfo.PRIArray.Length ; i++ )
		 if(PawnOwnerPRI == PlayerOwner.GameReplicationInfo.PRIArray[i])
		 {
			myRank.Value = (i+1);
			break;
		 }

	myScore.Value = Min (PawnOwnerPRI.Score, 999);	// max display space
	if ( PawnOwnerPRI == PlayerOwner.GameReplicationInfo.PRIArray[0] )
	{
		if ( PlayerOwner.GameReplicationInfo.PRIArray.Length > 1 )
			mySpread.Value = Min (PawnOwnerPRI.Score - PlayerOwner.GameReplicationInfo.PRIArray[1].Score, 999);
		else
			mySpread.Value = 0;
	}
	else
		mySpread.Value = Min (PawnOwnerPRI.Score - PlayerOwner.GameReplicationInfo.PRIArray[0].Score, 999);

	if( bShowPoints )
	{
		DrawSpriteTileWidget( C, MyScoreBackground );
		MyScoreBackground.Tints[TeamIndex] = HudColorBlack;
		MyScoreBackground.Tints[TeamIndex].A = 150;

		DrawNumericTileWidget (C, myScore, DigitsBig);
		if ( C.ClipX >= 640 )
			DrawNumericTileWidget (C, mySpread, DigitsBig);
		DrawNumericTileWidget (C, myRank, DigitsBig);
	}
}

simulated function UpdateRankAndSpread(Canvas C)
{
	WideUpdateRankAndSpread(C);
}


//All values below courtesy of HUD Scaling Fix by Azarael
//Note: Parser can't process includes inside a 

simulated function UpdatePrecacheMaterials()
{
	local int i;

    for (i=0; i<class'UTComp_HudSettings'.default.UTCompCrosshairs.Length && class'UTComp_HudSettings'.default.bEnableUTCompCrosshairs; i++ )
		Level.AddPrecacheMaterial(class'UTComp_HudSettings'.default.UTCompCrosshairs[i].CrossTex);

    super.UpdatePrecacheMaterials();
}

exec function NextStats()
{
    if (ScoreBoard == none || bShowScoreBoard == false)
        Super.NextStats();
    else
        ScoreBoard.NextStats();
}

function DisplayEnemyName(Canvas C, PlayerReplicationInfo PRI)
{
	PlayerOwner.ReceiveLocalizedMessage(class'UTComp_PlayerNameMessage',0,PRI);
}

defaultproperties
{
	XShifts(1)=0.500000
	XShifts(2)=1.000000
	XShifts(3)=1.000000
	XShifts(4)=1.000000
	XShifts(5)=0.500000
	XShifts(8)=0.500000
	YShifts(3)=0.500000
	YShifts(4)=1.000000
	YShifts(5)=1.000000
	YShifts(6)=1.000000
	YShifts(7)=0.500000
	YShifts(8)=0.500000
}
