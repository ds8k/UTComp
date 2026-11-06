class UTComp_SuperShockRifle extends SuperShockRifle
    HideDropDown
	CacheExempt;

var bool bCantFire;
var float  FOVAdj;
var float  MaxZoomLevel;
var() bool zoomed;
var transient float LastFOV;

replication
{
reliable if( Role==ROLE_Authority )
    LockOut, UnLock; //, InstaFireRate;
}

simulated function LockOut()
{
    bCantFire=true;
}

simulated function UnLock()
{
    bCantFire=false;
}

exec function ZOOMIN()
{
  FOVAdj = +0.025;
}

exec function ZOOMOUT()
{
  FOVAdj = -0.025;
}

simulated function PostBeginPlay()
{
    Super.PostBeginPlay();
    MaxZoomLevel = ( 90 * 8.3 - 90 ) / ( 8.3 * 88 );
}

simulated function bool ReadyToFire(int Mode)
{
    if (bCantFire)
	    return false;
	return super.ReadyToFire(mode);
}

defaultproperties
{
}
