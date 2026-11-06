
//-----------------------------------------------------------
//
//-----------------------------------------------------------
class RoundMessage extends CriticalEventPlus;

var() localized string RoundWord;
var() localized string OfWord;

static function string GetString(
    optional int Switch,
    optional PlayerReplicationInfo RelatedPRI_1,
    optional PlayerReplicationInfo RelatedPRI_2,
    optional Object OptionalObject
    )
{
    local int i;
    i=switch>>10;
    return default.RoundWord@(i)@default.ofword@(switch-(i<<10));
}

defaultproperties
{
    RoundWord="Round"
    OfWord="Of"
    bIsConsoleMessage=False
    DrawColor=(R=255,G=255,B=0,A=255)
    StackMode=SM_Down
    PosY=0.85
    FontSize=0
}
