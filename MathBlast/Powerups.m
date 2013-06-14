//
//  Powerups.m
//  MathBlast
//
//  Created by JRamos on 6/11/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Powerups.h"
#import "Gems.h"


@implementation Powerups{
    
    CGSize winSize;
    CCSprite *transformPowerup;
    CCParticleSystemQuad* emitter;
    CCParticleSystemQuad *emitterSet;
}


-(id)initWithValue: (int)val
{
    
    if ((self = [super init]))
    {
        
        winSize = [CCDirector sharedDirector].winSize;
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
    transformPowerup = [CCSprite spriteWithFile:@"transform.png"];
    transformPowerup.scale = 0;
    transformPowerup.position = ccp(160 , 125);
    [self addChild:transformPowerup z:1];
    
    [transformPowerup runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:5],
      [CCScaleTo actionWithDuration:0 scale:2],
      [CCScaleTo actionWithDuration:.5 scale:.7], nil]];
    
    [self scheduleOnce:@selector(addSparkEmitter) delay:5.1];
}

-(void) addSparkEmitter
{
    emitter = [CCParticleSystemQuad particleWithFile:@"powerup.plist"];
    emitter.position = ccp(160 , 125);
    emitter.tag = 10;
    
    [self addChild:emitter z:0];
    
}

-(void) snapToPosition
{
    [transformPowerup runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:1],
      [CCMoveTo actionWithDuration:1 position:ccp(winSize.width/2, winSize.height/2)],
      [CCDelayTime actionWithDuration:1],
      [CCMoveTo actionWithDuration:1 position:ccp(88, 294)],
      [CCDelayTime actionWithDuration:.5],
      [CCScaleTo actionWithDuration:.5 scale:.48],
      nil]];
    
    [emitter runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:1],
      [CCMoveTo actionWithDuration:1 position:ccp(winSize.width/2, winSize.height/2)],
      [CCDelayTime actionWithDuration:1],
      [CCMoveTo actionWithDuration:1 position:ccp(88, 294)],
      [CCDelayTime actionWithDuration:.5],
      [CCScaleTo actionWithDuration:.5 scale:.48],
      [CCCallFuncN actionWithTarget:self selector:@selector(remove)],
      [CCCallFuncN actionWithTarget:self selector:@selector(emitterSet)],
      nil]];
}

-(void) emitterSet
{
    
    emitterSet = [CCParticleSystemQuad particleWithFile:@"powerupSet.plist"];
    emitterSet.position = ccp(88, 294);
    emitterSet.tag = 10;
    
    [self addChild:emitterSet z:0];
}

-(void) remove
{
    [self removeChildByTag:10 cleanup:YES];
}

+(void)applyTransformPowerup:(NSMutableArray *)arrayOfSprites
{
    
}

-(void)isPositioned
{
    _ready = YES;
}
@end
