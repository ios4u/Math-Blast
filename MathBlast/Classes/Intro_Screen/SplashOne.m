//
//  SplashOne.m
//  MathBlast
//
//  Created by JRamos on 7/18/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "SplashOne.h"
#import "IntroLayer.h"
#import "SimpleAudioEngine.h"


@implementation SplashOne
{
    CGSize _winSize;

}
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	SplashOne *layer = [SplashOne node];
	
    //DrawLayer *sand = [DrawLayer node];
    
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//
-(id) init
{
	if( (self=[super init])) {
        
        _winSize = [CCDirector sharedDirector].winSize;
        
        
        [self animateIntro];
	}
	
	return self;
}

-(void)animateIntro
{
    CCSprite *jrWhite = [CCSprite spriteWithFile:@"jr_productions_white.png"];
    jrWhite.position = ccp(_winSize.width/2, _winSize.height * .6);
    jrWhite.opacity = 0;
    [self addChild: jrWhite z:1];
    
    [jrWhite runAction:
     [CCSequence actions:
      [CCFadeIn actionWithDuration:1],
      nil]];
    
    CCSprite *jrRed = [CCSprite spriteWithFile:@"jr_productions_red.png"];
    jrRed.position = ccp(_winSize.width/2, _winSize.height * .6);
    jrRed.opacity = 0;
    [self addChild: jrRed z:1];
    
    [jrRed runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2.5],
      [CCFadeIn actionWithDuration:1],
      nil]];
    
    
    
    [self scheduleOnce:@selector(exitScene) delay:8];
    [self scheduleOnce:@selector(lightningSound) delay:2];
}

-(void) lightningSound
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"single_lightning_bolt.caf" pitch:1 pan:1 gain:.5];
}

-(void) exitScene
{
    // Reload the current scene
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:2
                                        scene:[IntroLayer node]]];
    //[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}


@end
