class FireSparks extends xEmitter;

simulated function PostBeginPlay()
{
    if ( PhysicsVolume.bWaterVolume )
    Super.destroy();
}

defaultproperties
{
    mRegen=False
    mStartParticles=20
    mMaxParticles=10
    mLifeRange(0)=0.8
    mLifeRange(1)=1.2
    mRegenRange(0)=0.0
    mRegenRange(1)=0.0
    mDirDev=(X=0.4,Y=0.4,Z=0.4)
    mPosDev=(X=0.2,Y=0.2,Z=0.2)
    mSpawnVecB=(X=2.0,Y=0.0,Z=0.06)
    mSpeedRange(0)=250.0
    mSpeedRange(1)=350.0
    mMassRange(0)=1.5
    mMassRange(1)=2.5
    mAirResistance=0.2
    mSizeRange(0)=1.0
    mSizeRange(1)=2.0
    mGrowthRate=-1.0
    mColorRange(0)=(R=25,G=140,B=240,A=255)
    mColorRange(1)=(R=25,G=140,B=240,A=255)
    mAttenKa=0.1
    DrawScale=10.0
    ScaleGlow=20.0
}
