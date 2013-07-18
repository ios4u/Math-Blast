//
//  Leaderboards.m
//  MathBlast
//
//  Created by JRamos on 7/15/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Leaderboards.h"
#import "Title.h"


@implementation Leaderboards
{
    CGSize winSize;
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Leaderboards *layer = [Leaderboards node];
    
	// add layer as a child to scene
	[scene addChild: layer];
    //[scene addChild:sand];
	
	// return the scene
	return scene;
}

-(id) init
{
    if( (self=[super init])) {
        
        winSize = [CCDirector sharedDirector].winSize;
        
        //[self scheduleOnce:@selector(exitScene) delay:3];
        [self setupBackground];
        [self showScores];
        
    }
    
    return self;
}

-(void) setupBackground
{
    
    CCSprite *bck = [CCSprite spriteWithFile:@"highscores.png"];
    bck.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:bck z:-5];
    
    CCSprite *longbackbutton = [CCSprite spriteWithFile:@"longbackbutton.png"];
    
    CCMenuItemSprite *backSpriteHighScores = [CCMenuItemSprite itemWithNormalSprite:longbackbutton selectedSprite:nil target:self selector:@selector(backButtonTapped)];
    
    CCMenu *backMenuButton = [CCMenu menuWithItems:backSpriteHighScores, nil];
    
    backMenuButton.position = ccp(winSize.width/2, winSize.height * .06);
    backMenuButton.tag = 10;
    
    [self addChild:backMenuButton z:1];
    
}

-(void) showScores
{
    
    // Get user defaults
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];

//
//    
//                UNCOMMENT FOR DUMMY SOCRES
//     
//     NSMutableArray *highScores = [NSMutableArray arrayWithArray:[defaults arrayForKey:@"scores"]];
//     
//     [highScores insertObject:[NSNumber numberWithInt:988] atIndex:1];
//     // Remove last score, so as to ensure only 10 entries in the high score array
//     [highScores removeLastObject];
//     // Re-save scores array to user defaults
//     [defaults setObject:highScores forKey:@"scores"];
//     [defaults synchronize];
//     
//
//
    
    if([defaults objectForKey:@"scores"]){//scores user defaults exists
        
        NSLog(@"Scoring exists");
        // Get high scores array from "defaults" object
        NSArray *highScores = [defaults arrayForKey:@"scores"];
        
        //create label for #1
        CCLabelTTF *scoreLabelOne = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d" , [[highScores objectAtIndex:0] intValue]] fontName:@"Avenir-Heavy" fontSize:35];
        scoreLabelOne.anchorPoint = ccp(0.5f,0.5f);
        scoreLabelOne.color = ccYELLOW;
        scoreLabelOne.position = ccp(790 , 515);
        scoreLabelOne.scale = 0;
        scoreLabelOne.tag = 10;
        [self addChild:scoreLabelOne];
        
        //animate totalGems score
        [scoreLabelOne runAction:
         [CCSequence actions:
          [CCDelayTime actionWithDuration:1],
          [CCScaleTo actionWithDuration:0 scale:10],
          [CCScaleTo actionWithDuration:.5 scale:1], nil]];
        
        CCLabelTTF *levelLabelOne = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d" , 35] fontName:@"Avenir-Heavy" fontSize:35];
        levelLabelOne.anchorPoint = ccp(0.5f,0.5f);
        levelLabelOne.color = ccYELLOW;
        levelLabelOne.position = ccp(515 , 515);
        levelLabelOne.scale = 0;
        levelLabelOne.tag = 10;
        [self addChild:levelLabelOne];
        
        //animate totalGems score
        [levelLabelOne runAction:
         [CCSequence actions:
          [CCDelayTime actionWithDuration:1],
          [CCScaleTo actionWithDuration:0 scale:10],
          [CCScaleTo actionWithDuration:.5 scale:1], nil]];
        
        CCLabelTTF *nameLabelOne = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%@" , @"1. jonny"] fontName:@"Avenir-Heavy" fontSize:35];
        nameLabelOne.anchorPoint = ccp(0.0f,0.5f);
        nameLabelOne.color = ccYELLOW;
        nameLabelOne.position = ccp(80 , 515);
        nameLabelOne.scale = 0;
        nameLabelOne.tag = 10;
        [self addChild:nameLabelOne];
        
        //animate totalGems score
        [nameLabelOne runAction:
         [CCSequence actions:
          [CCDelayTime actionWithDuration:1],
          [CCScaleTo actionWithDuration:0 scale:10],
          [CCScaleTo actionWithDuration:.5 scale:1], nil]];
        
        //create labels for 2-10
        // Iterate through array and print out high scores
        int yCoord = 465;
        for (int i = 1; i < [highScores count]; i++)
        {
            if([[highScores objectAtIndex:i] intValue] != 0){
                //[scoresString appendFormat:@"%i. %i\n", i + 1, [[highScores objectAtIndex:i] intValue]];
                
                CCLabelTTF *scoreLabels = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d" , [[highScores objectAtIndex:i] intValue]] fontName:@"Avenir-Heavy" fontSize:25];
                scoreLabels.anchorPoint = ccp(0.5f,0.5f);
                scoreLabels.color = ccWHITE;
                scoreLabels.position = ccp(790 , yCoord);
                [self addChild:scoreLabels];
                yCoord = yCoord - 41;
            }
        }
        //NSLog(@"%@" , scoresString);
        
    }
    else{//scores user defaults doesn't exits, create it.
        
        
        NSLog(@"Scoring does not exists");
        
        
        // Register default high scores
        NSDictionary *scoreDefaults = [NSDictionary dictionaryWithObject:[NSArray arrayWithObjects:[NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], [NSNumber numberWithInt:0], nil] forKey:@"scores"];
        
        [defaults registerDefaults:scoreDefaults];
        [defaults synchronize];
        
        NSMutableArray *highScores = [NSMutableArray arrayWithArray:[defaults arrayForKey:@"scores"]];
        
        [highScores insertObject:[NSNumber numberWithInt:0] atIndex:0];
        // Remove last score, so as to ensure only 10 entries in the high score array
        [highScores removeLastObject];
        // Re-save scores array to user defaults
        [defaults setObject:highScores forKey:@"scores"];
        [defaults synchronize];
    }

    
}

-(void) backButtonTapped
{
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionCrossFade transitionWithDuration:.5
                                             scene:[Title node]]];
}

@end
