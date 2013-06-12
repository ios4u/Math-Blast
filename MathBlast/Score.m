//
//  Score.m
//  MathBlast
//
//  Created by JRamos on 6/9/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Score.h"
#import "Results.h"
#import "Powerups.h"


@implementation Score
{
    CCLabelTTF *score;
    int targetScore;
    int scoreForTurn;
    
    CCSprite *goodLabel;
    CCSprite *greatLabel;
    CCSprite *excellentLabel;
    CCSprite *superbLabel;
    
    CCParticleSystemQuad *superbEmitter;
    CCParticleSystemQuad *clearGemsEmitter;
    
    CCProgressTimer* progressBar;
    CCSprite * progressSprite;
    bool turnOffProgress;
    
    Results *result;

}

-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super init] )) {
        [self setupScore];
        [self setupProgressBar];
        
        _arrayOfPowerups = [[NSMutableArray alloc] init];
        
        result = [Results node];
        [self addChild:result z:2];
    }
    return self;
}

-(void) setupScore
{
    score = [CCLabelTTF labelWithString:@"0" fontName:@"Avenir" fontSize:40];
    score.color = ccBLUE;
    score.position = ccp(-200, 558);
    [self addChild:score];
    
    [score runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:3 position:ccp(212, 558)],
      nil]];
}

-(void) addScore: (int)scoreTurn :(CGPoint)location :(int)totalGemsTouched :(int)distinct
{
    //get scores
    scoreForTurn = scoreTurn;
    targetScore = _gemScore + scoreForTurn;
    
    //animate floating scores
    if(totalGemsTouched > 1 && totalGemsTouched <= 3){
        [self animateGood:location];
    }
    if(totalGemsTouched >= 4 && totalGemsTouched <= 6){
        [self animateGreat:location];
        [self animateFloatingTotalGemsBonus:location :totalGemsTouched];
    }
    if(totalGemsTouched >= 7 && totalGemsTouched <= 14){
        [self animateExcellent:location];
        [self animateFloatingTotalGemsBonus:location :totalGemsTouched];
    }
    if(totalGemsTouched >= 15){
        [self animateSuperb:location];
        [self animateFloatingTotalGemsBonus:location :totalGemsTouched];
    }
    if(distinct >= 2){
        [self animateFloatingDistinctBonus:location :distinct];
    }
    
    //animate score counter
    [self schedule:@selector(updateScore)];
    
    //animate progress bar
    float progress = (targetScore * 1.0) / 500.0 * 100.0;
    if(progress > 100.0){ progress = 100; }
    [self fillProgressBar:progress];
}

-(void) updateScore
{
    if (_gemScore < targetScore) {
        
        _gemScore += (arc4random() % 10); //get a random number between one and ten
        if (_gemScore > targetScore) { //if we went to far, pull it bacl
            _gemScore = targetScore;
        }
        
        score.string = [NSString stringWithFormat:@"%d", _gemScore];
    }
    else {
        _gemScore = targetScore; //if we've arrived at the score
        [self unschedule:@selector(updateScore)]; 
    }

}

- (void)animateFloatingScore:(CGPoint)location
{
    CCLabelTTF *floatingScore = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"+%d" , scoreForTurn] fontName:@"Avenir" fontSize:15];
    floatingScore.color = ccYELLOW;
    floatingScore.position = ccp(location.x , location.y + 7);
    floatingScore.tag = 10;
    [self addChild:floatingScore];
    
    //animate floating score
    [floatingScore runAction:
     [CCSequence actions:
      [CCMoveBy actionWithDuration:1.5 position:ccp(0, 40)],
      [CCFadeOut actionWithDuration:.5],
      [CCCallFuncN actionWithTarget:self selector:@selector(removeLabel)],
      nil]];
}

-(void) animateFloatingDistinctBonus:(CGPoint)location :(int)distinct
{
    CCLabelTTF *floatingDistinct = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"Bonus x%d" , distinct] fontName:@"Avenir-Heavy" fontSize:20];
    floatingDistinct.color = ccRED;
    floatingDistinct.position = ccp(location.x + 32, location.y + 30);
    floatingDistinct.tag = 10;
    [self addChild:floatingDistinct];
    
    //animate floating score
    [floatingDistinct runAction:
     [CCSequence actions:
      [CCMoveBy actionWithDuration:1.5 position:ccp(0, 40)],
      [CCFadeOut actionWithDuration:.5],
      [CCCallFuncN actionWithTarget:self selector:@selector(removeLabel)],
      nil]];
}

-(void) animateFloatingTotalGemsBonus:(CGPoint)location :(int)totalGemsTouched
{
    CCLabelTTF *totalGems = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"COMBO x%d" , totalGemsTouched] fontName:@"Avenir-Heavy" fontSize:25];
    totalGems.color = ccGREEN;
    totalGems.position = ccp(location.x + 52, location.y + 55);
    totalGems.tag = 10;
    [self addChild:totalGems];
    
    //animate floating score
    [totalGems runAction:
     [CCSequence actions:
      [CCMoveBy actionWithDuration:1.5 position:ccp(0, 40)],
      [CCFadeOut actionWithDuration:.5],
      [CCCallFuncN actionWithTarget:self selector:@selector(removeLabel)],
      nil]];
}

-(void) animateGood:(CGPoint)location
{
    goodLabel = [CCSprite spriteWithFile:@"good.png"];
    goodLabel.position = ccp(location.x - 70, location.y + 40);
    goodLabel.tag = 10;
    [self addChild:goodLabel];
    
    [self animateFloatingScore:location];
    
    //animate goodLabel
    [goodLabel runAction:
     [CCSequence actions:
      [CCMoveBy actionWithDuration:2 position:ccp(0, 50)],
      [CCFadeOut actionWithDuration:.5],
      [CCCallFuncN actionWithTarget:self selector:@selector(removeLabel)],
      nil]];
    
    //[self animateClearGems:location];
}

-(void) animateGreat:(CGPoint)location
{
    greatLabel = [CCSprite spriteWithFile:@"great.png"];
    greatLabel.position = ccp(location.x - 70, location.y + 40);
    greatLabel.tag = 10;
    [self addChild:greatLabel];
    
    [self animateFloatingScore:location];
    
    //animate goodLabel
    [greatLabel runAction:
     [CCSequence actions:
      [CCMoveBy actionWithDuration:2 position:ccp(0, 50)],
      [CCFadeOut actionWithDuration:.5],
      [CCCallFuncN actionWithTarget:self selector:@selector(removeLabel)],
      nil]];
    
    [self animateClearGems:location];
}

-(void) animateExcellent:(CGPoint)location
{
    excellentLabel = [CCSprite spriteWithFile:@"excellent.png"];
    excellentLabel.position = ccp(location.x - 160, location.y + 40);
    excellentLabel.tag = 10;
    [self addChild:excellentLabel];
    
    [self animateFloatingScore:location];
    
    //animate goodLabel
    [excellentLabel runAction:
     [CCSequence actions:
      [CCMoveBy actionWithDuration:2 position:ccp(0, 50)],
      [CCFadeOut actionWithDuration:.5],
      [CCCallFuncN actionWithTarget:self selector:@selector(removeLabel)],
      nil]];
    
    [self animateClearGems:location];
}

-(void) animateSuperb:(CGPoint)location
{
    superbLabel = [CCSprite spriteWithFile:@"superb.png"];
    superbLabel.position = ccp(location.x - 140, location.y + 60);
    excellentLabel.tag = 10;
    [self addChild:superbLabel];
    
    [self animateFloatingScore:location];
    
    //animate goodLabel
    [superbLabel runAction:
     [CCSequence actions:
      [CCMoveBy actionWithDuration:2 position:ccp(0, 50)],
      [CCFadeOut actionWithDuration:.5],
      [CCCallFuncN actionWithTarget:self selector:@selector(removeLabel)],
      nil]];
    
//    superbEmitter = [CCParticleSystemQuad particleWithFile:@"starsBursting.plist"];
//    superbEmitter.position = location;
//    superbEmitter.tag = 10;
//    
//    [self addChild:superbEmitter];
    
    [self removeLabel];
}

-(void)animateClearGems:(CGPoint)location
{
    clearGemsEmitter = [CCParticleSystemQuad particleWithFile:@"clear.plist"];
    clearGemsEmitter.position = location;
    clearGemsEmitter.tag = 10;
    
    [self addChild:clearGemsEmitter];
    
    [self removeLabel];
}

-(void) setupProgressBar
{
    CCSprite * progressBorder = [CCSprite spriteWithFile: @"progressBorder.png"];
	[progressBorder setPosition:ccp(1600, 70)];
	[self addChild: progressBorder];
    
    progressSprite = [CCSprite spriteWithFile: @"progressBar.png"];
	progressBar = [CCProgressTimer progressWithSprite:progressSprite];
	progressBar.type = kCCProgressTimerTypeBar;
    
	[progressBorder addChild:progressBar];
	[progressBar setAnchorPoint: ccp(0,0)];
    [progressBar setMidpoint:ccp(0, 0)];
    progressBar.barChangeRate = ccp(1, 0);
    
    [progressBorder runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:3 position:ccp(670, 70)],
      nil]];
    
}

-(void) fillProgressBar :(float)perc
{
    if(!turnOffProgress){
        CCProgressTo *progressTo = [CCProgressTo actionWithDuration:3 percent:perc];
        [progressBar runAction:progressTo];
        
        if(perc == 100.0){
            CCSprite *progressDone = [CCSprite spriteWithFile:@"progressBar2.png"];
            progressDone.position = ccp(670, -170);
            [self addChild:progressDone z:1];
            [progressDone runAction:
             [CCSequence actions:
              [CCDelayTime actionWithDuration:3],
              [CCMoveTo actionWithDuration:0 position:ccp(670, 70)],
              nil]];
        }
        
        if(perc == 100.0){ turnOffProgress = YES; }; //stop running if progress is 100%
    }
}

-(void) didEndLevel
{
    //display result screen
    [result displayResults];
    
    //make powerup if applicable
    Powerups *pow = [[Powerups alloc] initWithValue:1];
    [_arrayOfPowerups addObject:pow];
    [self addChild:pow z:3];
    
}

-(void) removeLabel
{
    [self removeChildByTag:10 cleanup:YES];
}
@end
