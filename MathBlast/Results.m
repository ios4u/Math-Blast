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
    int totalGems;
    int combo;
    int secsLeft;
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

-(void) displayResultBoard:(int)totalGemsCollected :(int)longestCombo :(int)timeLeft
{
    secsLeft = timeLeft;
    combo = longestCombo;
    totalGems = totalGemsCollected;
    CCSprite *results = [CCSprite spriteWithFile:@"resultBoard.png"];
    results.scale = 1.05;
    results.position = ccp(winSize.width/2 , -500);
    //results.opacity = 200;
    [self addChild:results z:-1];
    
    [results runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:1.5],
      [CCMoveTo actionWithDuration:1 position:ccp(winSize.width/2 , winSize.height/2)],
      [CCCallFuncN actionWithTarget:self selector:@selector(animateResultScores)],
      [CCCallFuncN actionWithTarget:self selector:@selector(animateCalculateTotals)],
                   nil]];
}

-(void) animateResultScores
{
    CCLabelTTF *totalGemsLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d" , totalGems] fontName:@"Avenir-Heavy" fontSize:35];
    totalGemsLabel.anchorPoint = ccp(0.5f,0.5f);
    totalGemsLabel.color = ccYELLOW;
    totalGemsLabel.position = ccp(630 , 547);
    totalGemsLabel.scale = 0;
    totalGemsLabel.tag = 10;
    [self addChild:totalGemsLabel];
    
    //animate totalGems score
    [totalGemsLabel runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:1],
      [CCScaleTo actionWithDuration:0 scale:10],
      [CCScaleTo actionWithDuration:.5 scale:1], nil]];
    
    CCLabelTTF *longCombo = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d" , combo] fontName:@"Avenir-Heavy" fontSize:35];
    longCombo.anchorPoint = ccp(0.5f,0.5f);
    longCombo.color = ccYELLOW;
    longCombo.position = ccp(630 , 473);
    longCombo.scale = 0;
    longCombo.tag = 10;
    [self addChild:longCombo];
    
    //animate totalGems score
    [longCombo runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:1.5],
      [CCScaleTo actionWithDuration:0 scale:10],
      [CCScaleTo actionWithDuration:.5 scale:1], nil]];
    
    CCLabelTTF *timeLeft = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d" , secsLeft] fontName:@"Avenir-Heavy" fontSize:35];
    timeLeft.anchorPoint = ccp(0.5f,0.5f);
    timeLeft.color = ccYELLOW;
    timeLeft.position = ccp(630 , 400);
    timeLeft.scale = 0;
    timeLeft.tag = 10;
    [self addChild:timeLeft];
    
    //animate totalGems score
    [timeLeft runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2.0],
      [CCScaleTo actionWithDuration:0 scale:10],
      [CCScaleTo actionWithDuration:.5 scale:1], nil]];

}

-(void) animateCalculateTotals
{
    int totGems = totalGems * 2;
    CCLabelTTF *totalGemsLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+%d" , totGems] fontName:@"Avenir-Heavy" fontSize:45];
    totalGemsLabel.anchorPoint = ccp(0,0.5f);
    totalGemsLabel.color = ccBLUE;
    totalGemsLabel.position = ccp(740 , 547);
    totalGemsLabel.scale = 0;
    totalGemsLabel.tag = 10;
    [self addChild:totalGemsLabel];
    
    //animate totalGems score
    [totalGemsLabel runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:3],
      [CCScaleTo actionWithDuration:0 scale:10],
      [CCScaleTo actionWithDuration:.5 scale:1], nil]];
    
    int totCombo = combo *10;
    CCLabelTTF *longCombo = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+%d" , totCombo] fontName:@"Avenir-Heavy" fontSize:45];
    longCombo.anchorPoint = ccp(0,0.5f);
    longCombo.color = ccBLUE;
    longCombo.position = ccp(740 , 473);
    longCombo.scale = 0;
    longCombo.tag = 10;
    [self addChild:longCombo];
    
    //animate totalGems score
    [longCombo runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:3.5],
      [CCScaleTo actionWithDuration:0 scale:10],
      [CCScaleTo actionWithDuration:.5 scale:1], nil]];
    
    int totSecs = secsLeft * 5;
    CCLabelTTF *timeLeft = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+%d" , totSecs] fontName:@"Avenir-Heavy" fontSize:45];
    timeLeft.anchorPoint = ccp(0,0.5f);
    timeLeft.color = ccBLUE;
    timeLeft.position = ccp(740 , 400);
    timeLeft.scale = 0;
    timeLeft.tag = 10;
    [self addChild:timeLeft];
    
    //animate totalGems score
    [timeLeft runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:4.0],
      [CCScaleTo actionWithDuration:0 scale:10],
      [CCScaleTo actionWithDuration:.5 scale:1], nil]];
    
    int tot = totGems + totSecs + totCombo;
    CCLabelTTF *total = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+%d" , tot] fontName:@"Avenir-Heavy" fontSize:50];
    total.anchorPoint = ccp(0,0.5f);
    total.color = ccGREEN;
    total.position = ccp(740 , 315);
    total.scale = 0;
    total.tag = 10;
    [self addChild:total];
    
    //animate totalGems score
    [total runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:5],
      [CCScaleTo actionWithDuration:0 scale:20],
      [CCScaleTo actionWithDuration:.5 scale:1], nil]];
}

-(void) removeLabel
{
    [self removeChildByTag:10 cleanup:YES];
}


@end
