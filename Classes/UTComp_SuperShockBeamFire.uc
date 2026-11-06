class UTComp_SuperShockBeamFire extends SuperShockBeamFire;

var() class<DamageType> DamageTypeHeadShot;
var() float HeadShotRadius;

simulated function bool AllowMultiHit()
{
    return true;
}

event ModeDoFire()
{
    local UTComp_PRI uPRI;

    FireRate=0.70;

    if(weapon.owner.IsA('xPawn') && xPawn(Weapon.Owner).Controller!=None)
    {
        uPRI=class'UTComp_Util'.static.GetUTCompPRIFor(xPawn(Weapon.Owner).Controller);
        if(uPRI!=None)
            uPRI.NormalWepStatsPrim[1]+=1;
    }

    Super.ModeDoFire();
}

defaultproperties
{
    DamageTypeHeadShot=Class'UTCompvBoM.UTComp_SSRHeadshot'
    HeadShotRadius=7.0
    FireRate=0.7
}
