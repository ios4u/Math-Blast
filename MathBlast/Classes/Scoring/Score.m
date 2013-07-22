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
    CCLabelTTF *levelLabel;
    CCLabelTTF *levelTargetLabel;
    
    CCLabelTTF *score;
    UITextField *textField;
    int targetScore;
    int scoreForTurn;
    int totalGemsCollected;
    int combo;
    int timeLeft;
    int levelScore;
    
    CCSprite *goodLabel;
    CCSprite *greatLabel;
    CCSprite *excellentLabel;
    CCSprite *superbLabel;
    
    CCParticleSystemQuad *superbEmitter;
    CCParticleSystemQuad *clearGemsEmitter;
    
    CCProgressTimer* progressBar;
    CCSprite * progressSprite;
    CCSprite *progressDone;
    bool turnOffProgress;
    
    Results *result;
    CCMenu *nextLevel;
    
    LevelManager *levelManager;
    
    GameController *gc;
    
    CGSize winSize;

}

-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super init] )) {
        
        winSize = [CCDirector sharedDirector].winSize;
        _level = 1;
        _levelTarget = 4;
        [self setupScore];
        [self setupProgressBar];
        [self displayLevel];
        
        _arrayOfPowerups = [[NSMutableArray alloc] init];
    
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

-(void) displayLevel
{
    levelLabel = [CCLabelTTF labelWithString:@"1" fontName:@"MarkerFelt-Wide" fontSize:25];
    levelLabel.anchorPoint = ccp(0,0.5f);
    levelLabel.color = ccRED;
    levelLabel.position = ccp(-200, 458);
    [self addChild:levelLabel];
    
    [levelLabel runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:3 position:ccp(110, 465)],
      nil]];
    
    levelTargetLabel = [CCLabelTTF labelWithString:@"4" fontName:@"MarkerFelt-Wide" fontSize:65];
    levelTargetLabel.anchorPoint = ccp(0.5f,0.5f);
    levelTargetLabel.color = ccGREEN;
    levelTargetLabel.position = ccp(-200, 430);
    [self addChild:levelTargetLabel];
    
    [levelTargetLabel runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2],
      [CCMoveTo actionWithDuration:3 position:ccp(256, 430)],
      nil]];

}

-(void) addScore: (int)scoreTurn :(CGPoint)location :(int)totalGemsTouched :(int)distinct :(int)time :(LevelManager*)lm
{
    //get scores
    scoreForTurn = scoreTurn;
    targetScore = _gemScore + scoreForTurn;
    totalGemsCollected = totalGemsCollected + totalGemsTouched;
    levelScore = levelScore + scoreTurn;
    levelManager = lm;
    if(totalGemsTouched > combo){ combo = totalGemsTouched; }
    
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
    
    if(!turnOffProgress){
        timeLeft = time;
    }
    
    //animate progress bar
    int target = [levelManager floatForProp:@"target"];
    float progress = (levelScore * 1.0) / target * 100.0;
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
            progressDone = [CCSprite spriteWithFile:@"progressBar2.png"];
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

-(void) didEndLevel:(GameController*) gameC
{
    
    if(!turnOffProgress){//level target not met - lose - game reset
        NSLog(@"You lose");
        gameC.isGameOver = YES;
        result = [Results node];
        [self addChild:result z:2];
        result.tag = 20;
        [self recordHighScore];
    }
    else{
        result = [Results node];
        [self addChild:result z:2];
        result.tag = 20;
        
        //pass in GameController
        gc = gameC;
        
        //display result screen
        [result displayResultBoard:totalGemsCollected :combo :timeLeft :levelScore :targetScore];
        
        //set powerup idle and remove used
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        for (Powerups *pow in _arrayOfPowerups) {
            [pow setLive:NO];
            if(!pow.wasUsed){
                [temp addObject:pow];
            }else{//remove it
                [self removeChild:pow];
            } 
        }
        _arrayOfPowerups = temp;
        
        //make powerup if applicable
        if([_arrayOfPowerups count] < 1 && [levelManager boolForProp:@"transform"]){
            Powerups *pow = [[Powerups alloc] initWithValue:1];
            [_arrayOfPowerups addObject:pow];
            [self addChild:pow z:3];
        }
        
        [self animateNextLevelButton];
    }
    
}

-(void) animateNextLevelButton
{
    
    CCSprite *arrow = [CCSprite spriteWithFile:@"bigArrow.png"];
    
    CCMenuItemSprite *nextLevelItem = [CCMenuItemSprite itemWithNormalSprite:arrow selectedSprite:nil target:self selector:@selector(nextLevelTapped)];
    
    nextLevelItem.position = ccp(880, 660);
    
    nextLevel = [CCMenu menuWithItems:nextLevelItem, nil];
    
    nextLevel.position = CGPointZero;
    nextLevel.scale = 0;
    
    [self addChild:nextLevel z:5];
    
    [nextLevel runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:5.5],
      [CCScaleTo actionWithDuration:0 scale:1],
      nil]];
    
    [nextLevel runAction:
     [CCRepeatForever actionWithAction:
      [CCFadeOut actionWithDuration:1.5]]];
    
}


-(void) nextLevelTapped
{
    
    [result runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:.5],
       [CCMoveBy actionWithDuration:.3 position:ccp(-80, 0)],
       [CCMoveBy actionWithDuration:1 position:ccp(2000, 0)],
       nil]];
    
    [nextLevel runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:.5],
      [CCMoveBy actionWithDuration:.3 position:ccp(-80, 0)],
      [CCMoveBy actionWithDuration:1 position:ccp(2000, 0)],
      nil]];
    
    //snap into position. If it has already been placed, then ignore.
    if([[_arrayOfPowerups lastObject] ready] == 0){
        [[_arrayOfPowerups lastObject] snapToPosition];
        [[_arrayOfPowerups lastObject] isPositioned];
    }
    
    //update results
    targetScore = targetScore + result.totalSum;
    _gemScore = targetScore;
    score.string = [NSString stringWithFormat:@"%d", targetScore];
    
    _level++;
    _levelTarget++;
    levelLabel.string = [NSString stringWithFormat:@"%d" , _level];
    levelTargetLabel.string = [NSString stringWithFormat:@"%d" , _levelTarget];
    
    //let gamecontroller know you are starting next level
    [gc startNextLevel];
    
    //reorder powerup Z
    if([_arrayOfPowerups count] != 0){
        [self reorderChild:[_arrayOfPowerups lastObject] z:1];
    }
    
    //cleanup
    [self scheduleOnce:@selector(removeResults) delay:6];
    [self removeChild:nextLevel cleanup:YES];
    [self removeChild:progressDone];
    
    levelScore = 0;
    totalGemsCollected = 0;
    combo = 0;
    turnOffProgress = NO;
    [self fillProgressBar:0.0];
    
    
}

-(void) recordHighScore
{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *highScores = [NSMutableArray arrayWithArray:[defaults arrayForKey:@"scores"]];

    for (int i = 0; i < [highScores count]; i++)
    {
        if (targetScore >= [[highScores objectAtIndex:i] intValue])
        {
            
            [self addText];
            // Bust out of the loop
            break;
        }
        
        if(i == [highScores count] - 1)
        {
            [result gameOver];
        }
    }
    
}

-(void) addText
{
//    // This label will change depending on text input.
//    nameLabel = [CCLabelTTF labelWithString:@"My name is..."
//                                   fontName:@"Marker Felt"
//                                   fontSize:32];
//    CGSize size = [[CCDirector sharedDirector] winSize];
//    nameLabel.position =  ccp( size.width /2 , size.height/2 );
//    [self addChild: nameLabel];
    
    // Create textfield
    textField = [[UITextField alloc] initWithFrame:CGRectMake(winSize.width*.4,winSize.height*.4,200,25)];
    textField.placeholder = @"Enter name here." ;
    textField.borderStyle = UITextBorderStyleRoundedRect;
    CGRect frameRect = textField.frame;
    frameRect.size.height = 50;
    textField.frame = frameRect;
    textField.autocorrectionType = UITextAutocorrectionTypeNo ;
    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
    textField.font = [UIFont fontWithName:@"Verdana" size:42.0f];
    textField.font = [UIFont systemFontOfSize:44.0];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing ;
    textField.adjustsFontSizeToFitWidth = YES;
    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    textField.returnKeyType = UIReturnKeyDone ;
    textField.textColor = [UIColor blackColor];
    
    // Workaround to dismiss keyboard when Done/Return is tapped
    [textField addTarget:self action:@selector(textFieldEditingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
    
    // Add textfield into cocos2d view
    [[[CCDirector sharedDirector] view] addSubview:textField];
}

-(void) textFieldEditingDidEndOnExit:(UITextField*) tf {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSMutableArray *highScores = [NSMutableArray arrayWithArray:[defaults arrayForKey:@"scores"]];
    NSMutableArray *level = [NSMutableArray arrayWithArray:[defaults arrayForKey:@"level"]];
    NSMutableArray *name = [NSMutableArray arrayWithArray:[defaults arrayForKey:@"name"]];
    
    for (int i = 0; i < [highScores count]; i++)
    {
        if (targetScore >= [[highScores objectAtIndex:i] intValue])
        {
            
            // Insert new high score, which pushes all others down
            [highScores insertObject:[NSNumber numberWithInt:targetScore] atIndex:i];
            [level insertObject:[NSNumber numberWithInt:_level] atIndex:i];
            [name insertObject:textField.text atIndex:i];
            
            // Remove last score, so as to ensure only 10 entries in the high score array
            [highScores removeLastObject];
            [level removeLastObject];
            [name removeLastObject];
            
            // Re-save scores array to user defaults
            [defaults setObject:highScores forKey:@"scores"];
            [defaults setObject:level forKey:@"level"];
            [defaults setObject:name forKey:@"name"];
            [defaults synchronize];
            NSLog(@"Saved new high score of %i", targetScore);
            // Bust out of the loop
            [textField removeFromSuperview];
            [result gameOver];
            break;
        }
    }

}

-(void) removeLabel
{
    [self removeChildByTag:10 cleanup:YES];
}

-(void) removeResults
{
    [self removeChildByTag:20];
}
@end
