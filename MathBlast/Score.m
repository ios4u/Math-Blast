//
//  Score.m
//  MathBlast
//
//  Created by JRamos on 6/9/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Score.h"


@implementation Score
{
    CCLabelTTF *score;
    int targetScore;
    CCSprite *goodLabel;
}

-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super init] )) {
        [self setupScore];
    }
    return self;
}

-(void) setupScore
{
    score = [CCLabelTTF labelWithString:@"0" fontName:@"Avenir" fontSize:40];
    score.color = ccBLUE;
    score.position = ccp(212, 542);
    [self addChild:score];
}

-(void) addScore: (int)scoreForTurn
{
    targetScore = _gemScore + scoreForTurn;
    [self animateSuperlative];
    [self schedule:@selector(updateScore)];
}

-(void) updateScore
{
    if (_gemScore < targetScore) { //so this should always get run
        
        _gemScore += (arc4random() % 10); //get a random number between one and ten
        if (_gemScore > targetScore) { //if we went to far, pull it bacl
            _gemScore = targetScore;
        }
        
        score.string = [NSString stringWithFormat:@"%d", _gemScore];
    }
    else {
        _gemScore = targetScore; //if we've arrived at the score
        [self unschedule:@selector(updateScore)]; //...unschedule us
    }

}

-(void) animateSuperlative
{
    goodLabel = [CCSprite spriteWithFile:@"good.png"];
    goodLabel.position = ccp(400, 400);
    [self addChild:goodLabel];
    
    [goodLabel runAction:
     [CCSequence actions:
      [CCFadeOut actionWithDuration:1],
      [CCCallFuncN actionWithTarget:self selector:@selector(removeLabel)], nil]];

}

-(void) removeLabel
{
    [self removeChild:goodLabel cleanup:YES];
}
@end
