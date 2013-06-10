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

-(void) setupBackground
{
    CCSprite *bck = [CCSprite spriteWithFile:@"back2.jpg"];
    bck.position = ccp(_winSize.width/2, _winSize.height/2);
    [self addChild:bck];
}

-(void) setupGrid
{
    CCSprite *grid = [CCSprite spriteWithFile:@"bckgrid.png"];
    grid.position = ccp(_winSize.width*.65, _winSize.height/2);
    [self addChild:grid];
}

-(void) setupTimerBorder
{
    CCSprite *timer = [CCSprite spriteWithFile:@"timerBorder.png"];
    timer.position = ccp(175, 660);
    [self addChild:timer];
}

-(void) setupDetailBorder
{
    CCSprite *detail = [CCSprite spriteWithFile:@"detailBorder.png"];
    detail.position = ccp(175, 275);
    [self addChild:detail];
    
}

-(void) setupScoreBorder
{
    CCSprite *score = [CCSprite spriteWithFile:@"timerBorder.png"];
    score.position = ccp(175, 555);
    [self addChild:score];
    
    CCSprite *treasure = [CCSprite spriteWithFile:@"treasureChest.png"];
    treasure.position = ccp(78, 555);
    [self addChild:treasure];
    
    CCLabelTTF *scoreLabel = [CCLabelTTF labelWithString:@"Treasure Chest Value" fontName:@"Avenir-Heavy" fontSize:16];
    scoreLabel.color = ccYELLOW;
    scoreLabel.position = ccp(210, 580);
    [self addChild:scoreLabel];
}

@end
