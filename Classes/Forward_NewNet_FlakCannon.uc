//-----------------------------------------------------------
//
//-----------------------------------------------------------
class Forward_NewNet_FlakCannon extends NewNet_FlakCannon
HideDropDown
CacheExempt;

defaultproperties
{
    FireModeClass[0] = Class'UTCompvBoM.Forward_NewNet_FlakFire'
    FireModeClass[1] = Class'UTCompvBoM.Forward_newNet_FlakAltFire'
}
