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
    int countDown;
    CCLabelTTF *countDownTimer;
    CGSize winSize;
}

-(id)init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super init] )) {
        
        winSize = [CCDirector sharedDirector].winSize;
        _totalSeconds = 120;
        countDown = 3;

        [self setupTimer];
        
    }
    return self;
}

-(void) setupTimer
{
        
    timer = [CCLabelTTF labelWithString:@"2:00" fontName:@"Avenir-Heavy" fontSize:70];
    timer.position = ccp( -300,682);
    timer.color = ccGREEN;
    [self addChild:timer z:1];
    
    [timer runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:3 position:ccp(215, 682)],
      nil]];
    
    countDownTimer = [CCLabelTTF labelWithString:@"3" fontName:@"MarkerFelt-Wide" fontSize:70];
    countDownTimer.color = ccBLUE;
    countDownTimer.position = ccp(winSize.width/2, winSize.height/2);
    countDownTimer.scale = 0;
    [self addChild:countDownTimer];
    


    [self scheduleOnce:@selector(countDown) delay:7];

}

-(void) countDown
{
    [countDownTimer runAction:
     [CCSequence actions:
      [CCCallFuncN actionWithTarget:self selector:@selector(changeCountDown)],
      [CCScaleTo actionWithDuration:0 scale:5],
      [CCScaleTo actionWithDuration:1 scale:0],
      [CCCallFuncN actionWithTarget:self selector:@selector(changeCountDown)],
      [CCScaleTo actionWithDuration:0 scale:5],
      [CCScaleTo actionWithDuration:1 scale:0],
      [CCCallFuncN actionWithTarget:self selector:@selector(changeCountDown)],
      [CCScaleTo actionWithDuration:0 scale:5],
      [CCScaleTo actionWithDuration:1 scale:0],
      nil]];
    [self schedule:@selector(countTime) interval:1 repeat:-1 delay:4];
}

-(void) changeCountDown
{
    if(countDown == 3){
        countDownTimer.color = ccRED;
    }
    else if(countDown == 2){
        countDownTimer.color = ccYELLOW;
    }
    else if(countDown == 1){
        countDownTimer.color = ccGREEN;
    }
    countDownTimer.string = [NSString stringWithFormat:@"%d",countDown];
    countDown --;
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
        countDown = 3;
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

-(void) startTimer
{
    [self scheduleOnce:@selector(countDown) delay:7];
}

@end
