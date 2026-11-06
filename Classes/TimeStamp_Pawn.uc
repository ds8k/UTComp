//-----------------------------------------------------------
//
//-----------------------------------------------------------
class TimeStamp_Pawn extends Pawn;

var int timestamp;
var int NewTimeStamp;
var float dt;

function prebeginplay()
{
    super.prebeginplay();
}

function PossessedBy(Controller C)
{
   Super.PossessedBy(C);
   NetPriority=default.NetPriority;
}
function destroyed()
{
   super.destroyed();

}

simulated event tick(float deltatime)
{
   Super.tick(deltatime);
   NewTimeStamp = (Rotation.Yaw+Rotation.Pitch*256)/256;
   DT+=deltatime;
   if(NewTimeStamp > TimeStamp || TimeStamp-NewTimeStamp > 5000)
   {
       TimeStamp=NewTimeStamp;
       DT=0.00;
   }
}

defaultproperties
{
    ControllerClass=None
    bAcceptsProjectors=False
    bAlwaysRelevant=True
    NetPriority=50.0
    bCanBeDamaged=False
    bCanTeleport=False
    bDisturbFluidSurface=False
    bCollideActors=False
    bCollideWorld=False
    bBlockActors=False
    bProjTarget=False
}
