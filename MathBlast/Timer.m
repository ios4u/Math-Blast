//
//  Timer.m
//  MathBlast
//
//  Created by JRamos on 6/9/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Timer.h"


@implementation Timer{
    
    CCLabelTTF *timer;
}

-(id)init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super init] )) {
        
        _totalSeconds = 120;

        [self setupTimer];
        
    }
    return self;
}

-(void) setupTimer
{
    CCLabelTTF *timerLabel = [CCLabelTTF labelWithString:@"Timer:" fontName:@"Avenir-Heavy" fontSize:25];
    timerLabel.color = ccWHITE;
    timerLabel.position = ccp(85, 670);
    [self addChild:timerLabel];
    
    
    timer = [CCLabelTTF labelWithString:@"2:00" fontName:@"Avenir-Heavy" fontSize:70];
    timer.position = ccp( 215,658);
    timer.color = ccGREEN;
    [self addChild:timer z:1];

    [self schedule:@selector(countTime) interval:1];

}

-(void) countTime
{
    _totalSeconds --;
    int minutes = _totalSeconds/60;
    int seconds = _totalSeconds%60;
    
    if(_totalSeconds >= 0){
        if(_totalSeconds == 30){
            timer.color = ccYELLOW;
            [self animateExpiringTime];
        }
        if(_totalSeconds == 10){
            timer.color = ccRED;
            [self animateExpiringTime];
        }
        if(_totalSeconds > 30){
            timer.color = ccGREEN;
        }
        if(_totalSeconds < 6){
            [self animateExpiringTime];
        }
        if(seconds%60 > 9){
            timer.string = [NSString stringWithFormat:@"%d:%d",minutes, seconds];
        }
        else{
            timer.string = [NSString stringWithFormat:@"%d:0%d",minutes, seconds];
        }
    }
    
    if(_totalSeconds == 0){
        [self unscheduleAllSelectors];
    }
    
}

-(void) animateExpiringTime
{
    [timer runAction:
     [CCSequence actions:
      [CCEaseOut actionWithAction:
       [CCScaleTo actionWithDuration:.1 scale:1.2] rate:.5],
        [CCEaseOut actionWithAction:
         [CCScaleTo actionWithDuration:.1 scale:1] rate:.5],
      nil]];
}

@end
