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
    [[SimpleAudioEngine sharedEngine] preloadEffect:@"clock.caf"];

}

-(void) playGemCollect
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"gem_collect.caf" pitch:1 pan:1 gain:.1];
}

-(void) playGemCollectMedium
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"gem_collectmedium.caf" pitch:1 pan:1 gain:.1];
}

-(void) playClock
{
    [[SimpleAudioEngine sharedEngine] playEffect:@"clock.caf"];
}

@end
