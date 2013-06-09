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
    }
    return self;
}

-(void) setupBackground
{
    CCSprite *bck = [CCSprite spriteWithFile:@"back1.jpg"];
    bck.position = ccp(_winSize.width/2, _winSize.height/2);
    [self addChild:bck];
}

-(void) setupGrid
{
    CCSprite *grid = [CCSprite spriteWithFile:@"bckgrid.png"];
    grid.position = ccp(_winSize.width*.65, _winSize.height/2);
    [self addChild:grid];
}

@end
