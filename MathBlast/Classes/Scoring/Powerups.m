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
    CCMenu *transformMenuButton;
    NSMutableArray *allGems;
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
    transformPowerup.tag = 10;
    transformPowerup.position = ccp(160 , 125);
    [self addChild:transformPowerup z:1];
    
    [transformPowerup runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:4],
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
      [CCCallFuncN actionWithTarget:self selector:@selector(setButton)],
      nil]];
}

-(void) emitterSet
{
    
    emitterSet = [CCParticleSystemQuad particleWithFile:@"powerupSet.plist"];
    emitterSet.position = ccp(88, 294);
    emitterSet.tag = 10;
    
    [self addChild:emitterSet z:0];
}

-(void) setButton
{
    [self removeChild:transformPowerup cleanup:YES];
    
    CCSprite *transformSprite = [CCSprite spriteWithFile:@"transform.png"];
    
    CCMenuItemSprite *menuSprite = [CCMenuItemSprite itemWithNormalSprite:transformSprite selectedSprite:nil target:self selector:@selector(transformTapped)];
    
    transformMenuButton = [CCMenu menuWithItems:menuSprite, nil];
    
    transformMenuButton.position = ccp(-178, 95);
    transformMenuButton.scale = .48;
    transformMenuButton.tag = 10;
    
    [self addChild:transformMenuButton z:5];
    
    [transformMenuButton setEnabled:NO];
    
}

-(void) setLive:(BOOL*)live
{
    [transformMenuButton setEnabled:live];
}

-(void) transformTapped
{
    [transformMenuButton runAction:
     [CCFadeOut actionWithDuration:1]];
    
    [transformMenuButton runAction:
     [CCScaleTo actionWithDuration:1 scale:.8]];
    
    [transformMenuButton runAction:
     [CCSequence actions:
      [CCMoveBy actionWithDuration:1 position:ccp(180, 150)],
      [CCCallFuncN actionWithTarget:self selector:@selector(remove)],
      nil]];
    
    _wasUsed = YES;
    
    [self applyTransformPowerup];
}

-(void) setGems:(NSMutableArray *)arrayOfSprites
{
    allGems = arrayOfSprites;
}

-(void) remove
{
    [self removeChildByTag:10 cleanup:YES];
}

-(void)applyTransformPowerup
{
    //this powerup sets random gems to 0
    for (Gems *sprite in allGems) {
        int r = arc4random() % 2;
        if(r == 1){
            [sprite performTransform];
        }
    }
}

-(void)isPositioned
{
    _ready = YES;
}
@end
