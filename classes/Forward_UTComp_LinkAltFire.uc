//-----------------------------------------------------------
//
//-----------------------------------------------------------
class Forward_UTComp_LinkAltFire extends UTComp_LinkAltFire;

function Projectile SpawnProjectile(Vector Start, Rotator Dir)
{
    local LinkProjectile Proj;
    local UTComp_PRI uPRI;

    if(weapon.owner.IsA('xPawn') && xPawn(Weapon.Owner).Controller!=None)
    {
        uPRI=class'UTComp_Util'.static.GetUTCompPRIFor(xPawn(Weapon.Owner).Controller);
        if(uPRI!=None)
            uPRI.NormalWepStatsPrim[9]+=2;
    }

    // super function
    Start += Vector(Dir) * 10.0 * LinkGun(Weapon).Links;
    Proj = Weapon.Spawn(class'UTCompv18bK.Forward_LinkProjectile',,, Start, Dir);
    if ( Proj != None )
    {
		Proj.Links = LinkGun(Weapon).Links;
		Proj.LinkAdjust();
	}
    return Proj;
}

DefaultProperties
{
   ProjectileClass = class'UTCompv18bK.forward_linkProjectile'
}
