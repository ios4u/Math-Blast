//
//  Sounds.m
//  MathBlast
//
//  Created by JRamos on 6/19/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Sounds.h"
#import "SimpleAudioEngine.h"


@implementation Sounds

-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super init] )) {
        
        [self setupSounds];
        
    }
    return self;
}

-(void) setupSounds
{
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"gem_collect.caf"];
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"gem_collectmedium.caf"];
}

-(void) playGemCollect
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"gem_collect.caf"];
}

-(void) playGemCollectMedium
{
    NSLog(@"playing");
    [[SimpleAudioEngine sharedEngine] playEffect:@"gem_collectmedium.caf"];
}

@end
