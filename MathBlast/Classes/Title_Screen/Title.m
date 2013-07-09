//
//  Title.m
//  MathBlast
//
//  Created by JRamos on 4/20/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Title.h"
#import "GameController.h"
#import "Gems.h"
#import "Tutorial.h"


@implementation Title
{
    CGSize winSize;
    int tagNum;
    int tagGemNum;
    UITextField *textField;
    CCLabelTTF *nameLabel;
}

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	Title *layer = [Title node];
    
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
        tagNum = 0;
        tagGemNum = 0;
        
        //[self scheduleOnce:@selector(exitScene) delay:3];
        [self setupTitle];
        
        [self addText];
        
        //animate falling gems
        [self schedule:@selector(animateFallingGems) interval:2 repeat:-1 delay:1];
        
    }
    
    return self;
}

-(void) addText
{
//    // This label will change depending on text input.
//    nameLabel = [CCLabelTTF labelWithString:@"My name is..."
//                                        fontName:@"Marker Felt"
//                                        fontSize:32];
//    CGSize size = [[CCDirector sharedDirector] winSize];
//    nameLabel.position =  ccp( size.width /2 , size.height/2 );
//    [self addChild: nameLabel];
//    
//    // Create textfield
//    textField = [[[UITextField alloc] initWithFrame:CGRectMake(10,10,200,25)] autorelease];
//    textField.placeholder = @"Enter name here." ;
//    textField.borderStyle = UITextBorderStyleNone ;
//    CGRect frameRect = textField.frame;
//    frameRect.size.height = 50;
//    textField.frame = frameRect;
//    textField.autocorrectionType = UITextAutocorrectionTypeNo ;
//    textField.autocapitalizationType = UITextAutocapitalizationTypeNone;
//    textField.font = [UIFont fontWithName:@"Verdana" size:42.0f];
//    textField.font = [UIFont systemFontOfSize:44.0];
//    textField.clearButtonMode = UITextFieldViewModeWhileEditing ;
//    textField.adjustsFontSizeToFitWidth = YES;
//    textField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    textField.returnKeyType = UIReturnKeyDone ;
//    textField.textColor = [UIColor whiteColor];
//    
//    // Workaround to dismiss keyboard when Done/Return is tapped
//    [textField addTarget:self action:@selector(textFieldEditingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
//    
//    // Add textfield into cocos2d view
//    [[[CCDirector sharedDirector] view] addSubview:textField];
}

-(void) textFieldEditingDidEndOnExit:(UITextField*) tf {
    nameLabel.string = [NSString stringWithFormat:@"My name is %@", textField.text];
}

-(void) setupTitle
{
    
    CCSprite *bck = [CCSprite spriteWithFile:@"back4.jpg"];
    bck.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:bck z:-5];
    
    CCSprite *logo = [CCSprite spriteWithFile:@"mathblastLogo.png"];
    logo.position = ccp(winSize.width/2, winSize.height * .85);
    logo.scale = 0;
    [self addChild: logo z:1];
    
    [logo runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:1.5],
      [CCScaleTo actionWithDuration:1.5 scale:1],
      nil]];
    
    
    CCSprite *play = [CCSprite spriteWithFile:@"play.png"];
    
    CCMenuItemSprite *menuSprite = [CCMenuItemSprite itemWithNormalSprite:play selectedSprite:nil target:self selector:@selector(playTapped)];
    
    CCMenu *playMenuButton = [CCMenu menuWithItems:menuSprite, nil];
    
    playMenuButton.position = ccp(winSize.width * .4, winSize.height * .45);
    playMenuButton.scale = .8;
    playMenuButton.opacity = 0;
    playMenuButton.tag = 10;
    
    [self addChild:playMenuButton z:1];
    
    
    [playMenuButton runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:3],
      [CCFadeIn actionWithDuration:.5],
      nil]];

    
//    CCSprite *play = [CCSprite spriteWithFile:@"play.png"];
//    play.position = ccp(winSize.width/2, winSize.height * .55);
//    play.opacity = 0;
//    play.scale = .8;
//    [self addChild: play z:1];
//    
//    [play runAction:
//     [CCSequence actions:
//      [CCDelayTime actionWithDuration:3],
//      [CCFadeIn actionWithDuration:.5],
//      nil]];
    
    
    
    
    
    CCSprite *tutorial = [CCSprite spriteWithFile:@"tutorial.png"];
    
    CCMenuItemSprite *menuSpriteTut = [CCMenuItemSprite itemWithNormalSprite:tutorial selectedSprite:nil target:self selector:@selector(tutorialTapped)];
    
    CCMenu *tutorialMenuButton = [CCMenu menuWithItems:menuSpriteTut, nil];
    
    tutorialMenuButton.position = ccp(winSize.width * .4, winSize.height * .32);
    tutorialMenuButton.scale = .8;
    tutorialMenuButton.opacity = 0;
    tutorialMenuButton.tag = 10;
    
    [self addChild:tutorialMenuButton z:1];
    
    
    [tutorialMenuButton runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:3.3],
      [CCFadeIn actionWithDuration:.5],
      nil]];
    
    
    
    
    
    
//    CCSprite *tutorial = [CCSprite spriteWithFile:@"tutorial.png"];
//    tutorial.position = ccp(winSize.width/2, winSize.height * .42);
//    tutorial.opacity = 0;
//    tutorial.scale = .8;
//    [self addChild: tutorial z:1];
//    
//    [tutorial runAction:
//     [CCSequence actions:
//      [CCDelayTime actionWithDuration:3.3],
//      [CCFadeIn actionWithDuration:.5],
//      nil]];
    
    CCSprite *scores = [CCSprite spriteWithFile:@"scores.png"];
    scores.position = ccp(winSize.width/2, winSize.height * .29);
    scores.opacity = 0;
    scores.scale = .8;
    [self addChild: scores z:1];
    
    [scores runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:3.6],
      [CCFadeIn actionWithDuration:.5],
      nil]];
}

-(void) animateFallingGems
{
    int r = arc4random() % 5;
    int randX = arc4random() % (int) winSize.width;
    int randTime = randomValueBetween(8, 25);
    int randScale = randomValueBetween(1, 5);
    //int randOpacity = randomValueBetween(125, 225);
    
    Gems *newGem = [[Gems alloc] initWithValueAndPosition:r :ccp(randX, 1000)];//new gem
    [self addChild:newGem.gem z:-2];//add gem to our scene
    //newGem.gem.opacity = randOpacity;
    newGem.gem.scale = randScale * .1;
    newGem.gem.tag = tagGemNum;
    
    [newGem.gem runAction:
     [CCSequence actions:
      [CCMoveBy actionWithDuration:randTime position:ccp(0, -1200)],
      [CCCallFuncN actionWithTarget:self selector:@selector(removeFallingGems)],

      nil]];
    
    tagGemNum++;
}

-(void) removeFallingGems
{
    [self removeChildByTag:tagNum cleanup:YES];
    tagNum++;
    
}

-(void) playTapped
{
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:2
                                        scene:[GameController node]]];
}

-(void) tutorialTapped
{
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFadeDown transitionWithDuration:2
                                        scene:[Tutorial node]]];
}

//This function to give you a random number between two floats.
float randomValueBetween(float low, float high) {
    return (((float) arc4random() / 0xFFFFFFFFu)
            * (high - low)) + low;
}

@end
