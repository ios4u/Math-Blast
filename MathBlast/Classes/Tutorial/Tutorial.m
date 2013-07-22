//
//  Tutorial.m
//  MathBlast
//
//  Created by JRamos on 7/5/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Tutorial.h"
#import "Title.h"


@implementation Tutorial
{
    CGSize winSize;
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Tutorial *layer = [Tutorial node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    //[scene addChild:sand];
	
	// return the scene
	return scene;
}

-(id) init
{
    if( (self=[super init])) {
        
        winSize = [CCDirector sharedDirector].winSize;
        
        //[self scheduleOnce:@selector(exitScene) delay:3];
        [self setupBackground];
        
    }
    
    return self;
}

-(void) setupBackground
{
    
    CCSprite *bck = [CCSprite spriteWithFile:@"back4blur.jpg"];
    bck.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:bck z:-5];
    
    CCSprite *backbutton = [CCSprite spriteWithFile:@"longbackbutton.png"];
    
    CCMenuItemSprite *backSpriteHighScores = [CCMenuItemSprite itemWithNormalSprite:backbutton selectedSprite:nil target:self selector:@selector(backButtonTapped)];
    
    CCMenu *backMenuButton = [CCMenu menuWithItems:backSpriteHighScores, nil];
    
    backMenuButton.position = ccp(winSize.width * .5, winSize.height * .05);
    backMenuButton.tag = 10;
    
    [self addChild:backMenuButton z:1];
    
}

-(void) backButtonTapped
{
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionCrossFade transitionWithDuration:.5
                                             scene:[Title node]]];
}


@end
