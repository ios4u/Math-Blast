//
//  Powerups.m
//  MathBlast
//
//  Created by JRamos on 6/11/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Powerups.h"


@implementation Powerups


-(id)initWithValue: (int)val
{
    
    if ((self = [super init]))
    {
        _powerType = val;
        switch (val) {
                //make tranform powerup
            case 1:
                [self animatePowerup];
                break;
            case 2:
                break;
        }
    }
    return self;
}

-(void) animatePowerup
{
    CCSprite *transformPowerup = [CCSprite spriteWithFile:@"transform.png"];
    transformPowerup.scale = 0;
    transformPowerup.position = ccp(160 , 125);
    [self addChild:transformPowerup z:1];
    
    [transformPowerup runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:4],
      [CCScaleTo actionWithDuration:0 scale:2],
      [CCScaleTo actionWithDuration:.5 scale:.7], nil]];
    
    [self scheduleOnce:@selector(addSparkEmitter) delay:4];
}

-(void) addSparkEmitter
{
    CCParticleSystemQuad* emitter = [CCParticleSystemQuad particleWithFile:@"powerup.plist"];
    emitter.position = ccp(160 , 125);
    
    [self addChild:emitter z:0];
    
}

@end
