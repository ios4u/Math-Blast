//
//  Title.m
//  MathBlast
//
//  Created by JRamos on 4/20/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Title.h"
#import "GameController.h"


@implementation Title

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Title *layer = [Title node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    //[scene addChild:sand];
	
	// return the scene
	return scene;
}


-(id) init
{
    if( (self=[super init])) {
        [self scheduleOnce:@selector(exitScene) delay:3];
        
    }
    
    return self;
}

-(void) exitScene
{
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:2
                                        scene:[GameController node]]];
}

@end
