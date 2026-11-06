class NewNet_SuperShockRifle extends UTComp_SuperShockRifle
	HideDropDown
	CacheExempt;

var TimeStamp_Pawn T;
var MutUTComp M;
var float LastDT;
var UTComp_EliteScope ScopeClass;
var UTComp_Scope CurrentScope;

struct ReplicatedRotator
{
    var int Yaw;
    var int Pitch;
};

struct ReplicatedVector
{
    var float X;
    var float Y;
    var float Z;
};

replication
{
    reliable if( Role<ROLE_Authority )
        NewNet_ServerStartFire;
    unreliable if(bDemoRecording)
        SpawnBeamEffect;
}

function DisableNet()
{
    NewNet_SuperShockBeamFire(FireMode[0]).bUseEnhancedNetCode = false;
    NewNet_SuperShockBeamFire(FireMode[0]).PingDT = 0.00;
}


simulated function BringUp(optional Weapon PrevWeapon)
{
    if (PlayerController(Instigator.Controller) != None) {
        LastFOV = PlayerController(Instigator.Controller).DesiredFOV;
    }

    CurrentScope.BringUp(PrevWeapon);
    Super.BringUp();
}

simulated function bool PutDown()
{
  if (Instigator.Controller.IsA( 'PlayerController' )) {
    PlayerController(Instigator.Controller).EndZoom();
  }

  if (Super.PutDown() ) {
    CurrentScope.PutDown();
    return true;
  }

  return false;
}

simulated function SetScope()
{
    // ScopeClass = class<UTComp_EliteScope>(DynamicLoadObject("", class'Class'));
    CurrentScope = Spawn(class'UTComp_EliteScope', Self);
}

simulated function vector GetEffectStart()
{
    local Vector X,Y,Z;

    // this function should actually never be called in third person views
    // any effect that needs a 3rdp weapon offset should figure it out itself

    // 1st person
    if (Instigator.IsFirstPerson()) {
        if (WeaponCentered()) {
			return CenteredEffectStart();
        }

        GetViewAxes(X, Y, Z);
        if (class'PlayerController'.Default.bSmallWeapons) {
			return (Instigator.Location +
				Instigator.CalcDrawOffset(self) +
				SmallEffectOffset.X * X  +
				SmallEffectOffset.Y * Y * Hand +
				SmallEffectOffset.Z * Z);
        }

        return (Instigator.Location +
            Instigator.CalcDrawOffset(self) +
            EffectOffset.X * X +
            EffectOffset.Y * Y * Hand +
            EffectOffset.Z * Z);
    }

    return (Instigator.Location +
            Instigator.EyeHeight*Vect(0,0,0.5) +
            Vector(Instigator.Rotation) * 40.0);
}

//// client only ////
simulated event ClientStartFire(int Mode)
{
    if (mode == 1) {
        FireMode[mode].bIsFiring = true;
        if (Instigator.Controller.IsA( 'PlayerController' )) {
            PlayerController(Instigator.Controller).ToggleZoomWithMax(MaxZoomLevel);
        }
    } else {
        SuperClientStartFire(mode);
    }
}

simulated event SuperClientStartFire(int Mode)
{
    if(Level.NetMode!=NM_Client || !class'BS_xPlayer'.static.UseNewNet())
        super(Weapon).ClientStartFire(mode);
    else
        NewNet_ClientStartFire(mode);
}

simulated function ClientStopFire(int mode)
{
  if (mode == 1) {
    FireMode[mode].bIsFiring = false;
    if(Instigator.Controller.IsA( 'PlayerController' )) {
      PlayerController(Instigator.Controller).StopZoom();
    }
  } else {
    Super.ClientStopFire(mode);
  }
}

simulated event NewNet_ClientStartFire(int Mode)
{
    local ReplicatedRotator R;
    local ReplicatedVector V;
    local vector Start;
    local byte stamp;
    local bool b;
    local actor A;
    local vector HN,HL;

    if (Pawn(Owner).Controller.IsInState('GameEnded') || Pawn(Owner).Controller.IsInState('RoundEnded'))
        return;

    if (Role < ROLE_Authority) {
        if (ReadyToFire(mode) && StartFire(Mode)) {
            R.Pitch = Pawn(Owner).Controller.Rotation.Pitch;
            R.Yaw = Pawn(Owner).Controller.Rotation.Yaw;
            STart = Pawn(Owner).Location + Pawn(Owner).EyePosition();

            V.X = Start.X;
            V.Y = Start.Y;
            V.Z = Start.Z;

            if (T == None) {
                foreach DynamicActors(class'TimeStamp_Pawn', T)
                    break;
            }
            Stamp = T.TimeStamp;

            NewNet_SuperShockBeamFire(FireMode[mode]).DoInstantFireEffect();

            A = Trace(HN,HL,Start+Vector(Pawn(Owner).Controller.Rotation)*40000.0,Start,true);
            if (A != None && (A.IsA('xPawn') || A.IsA('Vehicle'))) {
                b=true;
            }

            NewNet_ServerStartFire(Mode, stamp, T.DT, R, V,b,A);
        }
    } else {
        StartFire(Mode);
    }
}

simulated function bool AltReadyToFire(int Mode)
{
    local int alt;
    local float f;

    // There is a very slight descynchronization error on the server
    // with weapons due to differing deltatimes which accrues to a pretty big
    // error if people just hold down the button...
    // This will never cause the weapon to actually fire slower
    f = 0.015;

    if (!ReadyToFire(Mode))
        return false;

    if ( Mode == 0 )
        alt = 1;
    else
        alt = 0;

    if ( ((FireMode[alt] != FireMode[Mode]) && FireMode[alt].bModeExclusive && FireMode[alt].bIsFiring)
		|| !FireMode[Mode].AllowFire()
		|| (FireMode[Mode].NextFireTime > Level.TimeSeconds + FireMode[Mode].PreFireTime - f) )
    {
        return false;
    }

	return true;
}

simulated event RenderOverlays(Canvas C)
{
    local float ZoomLevel;

    if (PlayerController(Instigator.Controller) == None) return;

    if (CurrentScope == None) SetScope();

    if (
        zoomed &&
        FOVAdj != 0.0 &&
        !PlayerController(Instigator.Controller).bZooming
    ) {
        ZoomLevel = PlayerController(Instigator.Controller).ZoomLevel;
        ZoomLevel += FOVAdj;

        if (ZoomLevel > MaxZoomLevel) ZoomLevel = MaxZoomLevel;

        if (ZoomLevel <= 0.0) {
            PlayerController(Instigator.Controller).ZoomLevel = 0;
            PlayerController(Instigator.Controller).EndZoom();
            zoomed=false;
        } else {
            PlayerController(Instigator.Controller).DesiredFOV = FClamp(90.0 - (ZoomLevel * 88.0), 1, 170);
            PlayerController(Instigator.Controller).ZoomLevel = ZoomLevel;
        }

        FOVAdj = 0.0;
    }

    if (LastFOV > PlayerController(Instigator.Controller).DesiredFOV) {
        PlaySound(Sound'WeaponSounds.LightningGun.LightningZoomIn', SLOT_Misc,,, ,,false);
    } else if (LastFOV < PlayerController(Instigator.Controller).DesiredFOV) {
        PlaySound(Sound'WeaponSounds.LightningGun.LightningZoomOut', SLOT_Misc,, ,,,false);   
    }

    LastFOV = PlayerController(Instigator.Controller).DesiredFOV;

    if (PlayerController(Instigator.Controller).DesiredFOV == PlayerController(Instigator.Controller).DefaultFOV) {
        Super.RenderOverlays(C);
        CurrentScope.RenderNormal(C);
        zoomed = false;
    } else {
        CurrentScope.RenderZoom(C);
        zoomed = true;
    }
}

simulated function WeaponTick(float deltatime)
{
   lastDT = deltatime;
   Super.tick(deltatime);
}

//// client & server ////
simulated function bool StartFire(int Mode)
{
    if (bWaitForCombo && (Bot(Instigator.Controller) != None) ) {
		if ( (ComboTarget == None) || ComboTarget.bDeleteMe )
			bWaitForCombo = false;
		else
			return false;
	}

    if (!ReadyToFire(Mode))
        return false;

    FireMode[Mode].bIsFiring = true;
    FireMode[Mode].NextFireTime = Level.TimeSeconds-LastDT*0.5 + FireMode[Mode].PreFireTime;

    if (Instigator.IsLocallyControlled()) {
        if (FireMode[Mode].PreFireTime > 0.0 || FireMode[Mode].bFireOnRelease) {
            FireMode[Mode].PlayPreFire();
        }

        FireMode[Mode].FireCount = 0;
    }

    return true;
}


function NewNet_ServerStartFire(byte Mode, byte ClientTimeStamp, float DT, ReplicatedRotator R, ReplicatedVector V, bool bBelievesHit, actor A/*, bool bBelievesHit, ReplicatedVector BelievedHLDelta, Actor A, vector HN, vector HL*/)
{
	if ((Instigator != None) && (Instigator.Weapon != self)) {
		if ( Instigator.Weapon == None )
			Instigator.ServerChangedWeapon(None,self);
		else
			Instigator.Weapon.SynchronizeWeapon(self);
		return;
	}

    if (M==None) {
        foreach DynamicActors(class'MutUTComp', M)
            break;
    }

    NewNet_SuperShockBeamFire(FireMode[Mode]).PingDT = M.ClientTimeStamp - M.GetStamp(ClientTimeStamp)-DT + 0.5*M.AverDT;
    NewNet_SuperShockBeamFire(FireMode[Mode]).AverDT = M.AverDT;

    NewNet_SuperShockBeamFire(FireMode[Mode]).bBelievesHit = bBelievesHit;
    if (bBelievesHit) {
        NewNet_SuperShockBeamFire(FireMode[Mode]).BelievedHitActor = A;
    }

    NewNet_SuperShockBeamFire(FireMode[Mode]).bFirstGo = true;
    NewNet_SuperShockBeamFire(FireMode[Mode]).bUseEnhancedNetCode = true;
    if ((FireMode[Mode].NextFireTime <= Level.TimeSeconds + FireMode[Mode].PreFireTime) && StartFire(Mode)) {
        FireMode[Mode].ServerStartFireTime = Level.TimeSeconds;
        FireMode[Mode].bServerDelayStartFire = false;
        NewNet_SuperShockBeamFire(FireMode[Mode]).SavedVec.X = V.X;
        NewNet_SuperShockBeamFire(FireMode[Mode]).SavedVec.Y = V.Y;
        NewNet_SuperShockBeamFire(FireMode[Mode]).SavedVec.Z = V.Z;
        NewNet_SuperShockBeamFire(FireMode[Mode]).SavedRot.Yaw = R.Yaw;
        NewNet_SuperShockBeamFire(FireMode[Mode]).SavedRot.Pitch = R.Pitch;
        NewNet_SuperShockBeamFire(FireMode[Mode]).bUseReplicatedInfo=IsReasonable(NewNet_SuperShockBeamFire(FireMode[Mode]).SavedVec);
    } else if (FireMode[Mode].AllowFire()) {
        FireMode[Mode].bServerDelayStartFire = true;
	} else {
		ClientForceAmmoUpdate(Mode, AmmoAmount(Mode));
    }
}

function bool IsReasonable(Vector V)
{
    local vector LocDiff;
    local float clErr;

    if (Owner == none || Pawn(Owner) == none) {
        return true;
    }

    LocDiff = V - (Pawn(Owner).Location + Pawn(Owner).EyePosition());
    clErr = (LocDiff dot LocDiff);

    return clErr < 1250.0;
}

simulated function SpawnBeamEffect(vector HitLocation, vector HitNormal, vector Start, rotator Dir, int reflectnum)
{
    local ShockBeamEffect Beam;

    if (bClientDemoNetFunc) {
        Start.Z = Start.Z - 64.0;
    }

    if (
        Instigator.PlayerReplicationInfo.Team != None &&
        Instigator.PlayerReplicationInfo.Team.TeamIndex == 1
    ) {
        Beam = Spawn(class'NewNet_Client_BlueSuperShockBeam',,, Start, Dir);
        if (Beam == none) return;
        Beam.CoilClass = class'NewNet_Client_ShockBeamCoilBlue';
    } else {
        Beam = Spawn(class'NewNet_Client_SuperShockBeamEffect',,, Start, Dir);
        if (Beam == none) return;
        Beam.CoilClass = class'NewNet_Client_ShockBeamCoilB';
    }

    if (ReflectNum != 0) Beam.Instigator = None; // prevents client side repositioning of beam start
    Beam.AimAt(HitLocation, HitNormal);
}

defaultproperties
{
    FireModeClass(0)=Class'UTCompvBoM.NewNet_SuperShockBeamFire'
    FireModeClass(1)=Class'UTCompvBoM.UTComp_Zoom'
}
