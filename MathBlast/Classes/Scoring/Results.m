//
//  Results.m
//  MathBlast
//
//  Created by JRamos on 6/11/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Results.h"
#import "Title.h"


@implementation Results{
    
    CGSize winSize;
    int totalGems;
    int combo;
    int secsLeft;
    int roundScore;
    int gameScore;
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

-(void) displayResultBoard:(int)totalGemsCollected :(int)longestCombo :(int)timeLeft :(int)levelScore :(int)targetScore
{
    secsLeft = timeLeft;
    combo = longestCombo;
    totalGems = totalGemsCollected;
    roundScore = levelScore;
    gameScore = targetScore;
    CCSprite *results = [CCSprite spriteWithFile:@"resultBoard.png"];
    results.scale = 1.05;
    results.position = ccp(winSize.width/2 , -500);
    results.tag = 10;
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
      [CCDelayTime actionWithDuration:1.2],
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
      [CCDelayTime actionWithDuration:1.4],
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
      [CCDelayTime actionWithDuration:1.8],
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
      [CCDelayTime actionWithDuration:2],
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
      [CCDelayTime actionWithDuration:2.2],
      [CCScaleTo actionWithDuration:0 scale:10],
      [CCScaleTo actionWithDuration:.5 scale:1], nil]];
    
    int tot = totGems + totSecs + totCombo;
    CCLabelTTF *total = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+%d" , tot] fontName:@"Avenir-Heavy" fontSize:40];
    total.anchorPoint = ccp(0,0.5f);
    total.color = ccGREEN;
    total.position = ccp(740 , 342);
    total.scale = 0;
    total.tag = 10;
    [self addChild:total];
    
    _totalSum = tot;
    
    //animate totalGems score
    [total runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:3],
      [CCScaleTo actionWithDuration:0 scale:20],
      [CCScaleTo actionWithDuration:.5 scale:1], nil]];
    
    CCLabelTTF *roundTotal = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+%d" , roundScore] fontName:@"Avenir-Heavy" fontSize:40];
    roundTotal.anchorPoint = ccp(0,0.5f);
    roundTotal.color = ccGREEN;
    roundTotal.position = ccp(740 , 292);
    roundTotal.scale = 0;
    roundTotal.tag = 10;
    [self addChild:roundTotal];
    
    //animate totalGems score
    [roundTotal runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:3.3],
      [CCScaleTo actionWithDuration:0 scale:20],
      [CCScaleTo actionWithDuration:.5 scale:1], nil]];
    
    CCLabelTTF *overallScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"=%d" , gameScore + tot] fontName:@"Avenir-Heavy" fontSize:40];
    overallScore.anchorPoint = ccp(0,0.5f);
    overallScore.color = ccGREEN;
    overallScore.position = ccp(740 , 247);
    overallScore.scale = 0;
    overallScore.tag = 10;
    [self addChild:overallScore];
    
    //animate totalGems score
    [overallScore runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:3.6],
      [CCScaleTo actionWithDuration:0 scale:20],
      [CCScaleTo actionWithDuration:.5 scale:1], nil]];
}

-(void) gameOver
{
    CCSprite *menuAlert = [CCSprite spriteWithFile:@"gameoverMenu.png"];
    menuAlert.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:menuAlert z:6];
    
    CCSprite *menuButtonAlertSprite = [CCSprite spriteWithFile:@"mainMenuButton.png"];
    
    CCMenuItemSprite *menuAlertSprite = [CCMenuItemSprite itemWithNormalSprite:menuButtonAlertSprite selectedSprite:nil target:self selector:@selector(menuTapped)];
    
    CCMenu *menuMenuAlertButton = [CCMenu menuWithItems:menuAlertSprite, nil];
    
    menuMenuAlertButton.position = ccp(winSize.width/2 - 2, winSize.height/2 - 30);
    menuMenuAlertButton.tag = 10;
    
    [self addChild:menuMenuAlertButton z:6];

}

-(void) menuTapped
{
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:2
                                        scene:[Title node]]];

}


-(void) removeLabel
{
    [self removeChildByTag:10 cleanup:YES];
}


@end
