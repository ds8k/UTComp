//-----------------------------------------------------------
//
//-----------------------------------------------------------
class Silent_TimerMessage extends TimerMessage;

static function ClientReceive(
    PlayerController P,
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    super(CriticalEventPlus).ClientReceive(P, Switch, RelatedPRI_1, RelatedPRI_2, OptionalObject);

}

defaultproperties
{
	PosY=0.900000
}
