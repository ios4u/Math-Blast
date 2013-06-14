//
//  IntroLayer.m
//  MathBlast
//
//  Created by JRamos on 4/19/13.
//  Copyright JRamos 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"
#import "GameController.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer
{
    
    //private variables
    CGSize _winSize;
    CCSprite *_cemse_c;
    CCSprite *_cemse_e;
    CCSprite *_cemse_e2;
    CCSprite *_cemse_m;
    CCSprite *_cemse_s;
    CCSprite *_cemse;
    
    
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
    //DrawLayer *sand = [DrawLayer node];
        
	// add layer as a child to scene
	[scene addChild: layer];
    //[scene addChild:sand];
	
	// return the scene
	return scene;
}

//
-(id) init
{
	if( (self=[super init])) {
        
        _winSize = [CCDirector sharedDirector].winSize;
        
        
        [self animateIntro];
	}
	
	return self;
}

-(void)animateIntro{
    
    //initializes each sprite and performs an action with them
    _cemse = [CCSprite spriteWithFile:@"cemse.png"];
    _cemse.position = ccp(_winSize.width/2, _winSize.height * .53);
    _cemse.opacity = 0;
    [self addChild: _cemse z:1];
    
    _cemse_m = [CCSprite spriteWithFile:@"cemse_m.png"];
    _cemse_m.position = ccp(_winSize.width/2, _winSize.height * .53);
    [self addChild: _cemse_m];
    
    _cemse_c = [CCSprite spriteWithFile:@"cemse_c.png"];
    _cemse_c.position = ccp(_winSize.width * 1.2, _winSize.height * .53);
    [self addChild: _cemse_c];
    
    _cemse_e = [CCSprite spriteWithFile:@"cemse_e.png"];
    _cemse_e.position = ccp(_winSize.width * 1.2, _winSize.height * .53);
    [self addChild: _cemse_e];
    
    _cemse_e2 = [CCSprite spriteWithFile:@"cemse_e.png"];
    _cemse_e2.position = ccp(_winSize.width * -.2, _winSize.height * .53);
    [self addChild: _cemse_e2];
    
    _cemse_s = [CCSprite spriteWithFile:@"cemse_s.png"];
    _cemse_s.position = ccp(_winSize.width * -.2, _winSize.height * .53);
    [self addChild: _cemse_s];
    
    [_cemse_c runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:.4],
      [CCMoveTo actionWithDuration:2 position:ccp(_winSize.width * .41, _winSize.height * .53)],
      nil]];
    
    [_cemse_e runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:.4],
      [CCMoveTo actionWithDuration:1.5 position:ccp(_winSize.width * .455, _winSize.height * .53)],
      nil]];
    
    [_cemse_e2 runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:.4],
      [CCMoveTo actionWithDuration:2 position:ccp(_winSize.width * .59, _winSize.height * .53)],
      nil]];
    
    [_cemse_s runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:.4],
      [CCMoveTo actionWithDuration:1.5 position:ccp(_winSize.width * .545, _winSize.height * .53)],
      nil]];
    
    [_cemse runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2.3],
      [CCFadeIn actionWithDuration:.2],
      nil]];

    
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"The University Of Chicago" fontName:@"Avenir" fontSize:20];
    [self addChild:label z:0];
    [label setColor:ccc3(0,0,0)];
    label.position = ccp( _winSize.width/2, _winSize.height * .465);
    label.opacity = 0;
    
    [label runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2.3],
      [CCFadeIn actionWithDuration:1],
      nil]];
    
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:@"The Center for Elementary Mathematics and Science Education" fontName:@"Avenir" fontSize:30];
    [self addChild:label2 z:0];
    [label2 setColor:ccc3(0,0,0)];
    label2.position = ccp( _winSize.width/2, _winSize.height * .7);
    label2.opacity = 0;
    
    [label2 runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:2.3],
      [CCFadeIn actionWithDuration:1],
      nil]];
    
    CCLabelTTF *label3 = [CCLabelTTF labelWithString:@"Presents" fontName:@"Avenir" fontSize:25];
    [self addChild:label3 z:0];
    [label3 setColor:ccc3(0,0,0)];
    label3.position = ccp( _winSize.width/2, _winSize.height * .35);
    label3.opacity = 0;
    
    [label3 runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:4],
      [CCFadeIn actionWithDuration:2],
      nil]];
    
    [self scheduleOnce:@selector(exitScene) delay:.1];

}

-(void) exitScene
{
    // Reload the current scene
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:2
                                        scene:[GameController node]]];
    //[[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
}

-(void) onEnter
{
    [super onEnter];
    ccColor4B color = {255,255,255,255};
    CCLayerColor *colorLayer = [CCLayerColor layerWithColor:color];
    [self addChild:colorLayer z:-1];
}
@end
