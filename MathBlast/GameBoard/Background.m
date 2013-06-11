//
//  Background.m
//  MathBlast
//
//  Created by JRamos on 6/8/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Background.h"

//This class manages any background images/ animation
@implementation Background{
    CGSize _winSize;
    CCParticleSystemQuad *emitter;

}

-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super init] )) {
        _winSize = [CCDirector sharedDirector].winSize;
        [self setupBackground];
        [self setupGrid];
        [self setupTimerBorder];
        [self setupDetailBorder];
        [self setupScoreBorder];
    }
    return self;
}

- (void)setupEmitter
{
    emitter = [CCParticleSystemQuad particleWithFile:@"progress.plist"];
    emitter.position = ccp(-200, 575);
    
    [self addChild:emitter z:1];
    
    [emitter runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:3 position:ccp(78, 575)],
      nil]];
    
    
}

-(void) setupBackground
{
    CCSprite *bck = [CCSprite spriteWithFile:@"back2.jpg"];
    bck.position = ccp(_winSize.width/2, _winSize.height/2);
    [self addChild:bck];
    
    [self setupEmitter];
}

-(void) setupGrid
{
    CCSprite *grid = [CCSprite spriteWithFile:@"bckgrid.png"];
    grid.position = ccp(1600,383);
    [self addChild:grid];
    
    [grid runAction:
    [CCSequence actions:
     [CCDelayTime actionWithDuration:2],
     [CCMoveTo actionWithDuration:3 position:ccp(668, 383)],
     nil]];
}

-(void) setupTimerBorder
{
    CCSprite *timer = [CCSprite spriteWithFile:@"timerBorder.png"];
    timer.position = ccp(-200, 684);
    [self addChild:timer];
    
    [timer runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:3 position:ccp(170, 684)],
      nil]];
}

-(void) setupDetailBorder
{
    CCSprite *detail = [CCSprite spriteWithFile:@"detailBorder.png"];
    detail.position = ccp(-200, 275);
    [self addChild:detail];
    
    [detail runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:3 position:ccp(175, 267)],
      nil]];
    
}

-(void) setupScoreBorder
{
    CCSprite *score = [CCSprite spriteWithFile:@"timerBorder.png"];
    score.position = ccp(-200, 570);
    [self addChild:score];
    
    CCSprite *treasure = [CCSprite spriteWithFile:@"treasureChest.png"];
    treasure.position = ccp(-200, 570);
    [self addChild:treasure];
    
    CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:@"Treasure Chest Value" fontName:@"Avenir-Heavy" fontSize:16];
    scoreLabel.color = ccYELLOW;
    scoreLabel.position = ccp(-200, 595);
    [self addChild:scoreLabel];
    
    [score runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:3 position:ccp(175, 570)],
      nil]];
    
    [treasure runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:3 position:ccp(78, 570)],
      nil]];
    
    [scoreLabel runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:3 position:ccp(210, 595)],
      nil]];
}

@end
