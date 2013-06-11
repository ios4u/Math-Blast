//
//  Results.m
//  MathBlast
//
//  Created by JRamos on 6/11/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Results.h"


@implementation Results{
    CGSize winSize;
}

-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super init] )) {
        NSLog(@"results");
        winSize = [CCDirector sharedDirector].winSize;
    }
    return self;
}

-(void) displayResults
{
    CCSprite *results = [CCSprite spriteWithFile:@"resultBoard.png"];
    results.scale = 1.05;
    results.position = ccp(winSize.width/2 , -500);
    //results.opacity = 200;
    [self addChild:results];
    
    [results runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:1 position:ccp(winSize.width/2 , winSize.height/2)],
                   nil]];
    
}

@end
