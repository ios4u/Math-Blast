//
//  IntroLayer.m
//  MathBlast
//
//  Created by JRamos on 4/19/13.
//  Copyright JRamos 2013. All rights reserved.
//


// Import the interfaces
#import "IntroLayer.h"


#pragma mark - IntroLayer

// HelloWorldLayer implementation
@implementation IntroLayer
{
    CGSize _size;
    CGSize winSize;
    CCSprite *cemse_c;
    CCSprite *cemse_e;
    CCSprite *cemse_m;
    CCSprite *cemse_s;
}

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

//
-(id) init
{
	if( (self=[super init])) {
        
        winSize = [CCDirector sharedDirector].winSize;
        
        
		
//		// ask director for the window size
		_size = [[CCDirector sharedDirector] winSize];
//		
//		CCSprite *background;
//		
//		if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {
//			background = [CCSprite spriteWithFile:@"Default.png"];
//			background.rotation = 90;
//		} else {
//			background = [CCSprite spriteWithFile:@"Default-Landscape~ipad.png"];
//		}
//		background.position = ccp(size.width/2, size.height/2);
//		
//		// add the label as a child to this Layer
//		[self addChild: background];
        
        
        [self animateIntro];
	}
	
	return self;
}

-(void)animateIntro{
    
    //initializes each sprite and performs an action with them
    cemse_m = [CCSprite spriteWithFile:@"cemse_m.png"];
    cemse_m.position = ccp(_size.width/2, _size.height/2);
    [self addChild: cemse_m];
    
    cemse_c = [CCSprite spriteWithFile:@"cemse_c.png"];
    cemse_c.position = ccp(_size.width/2, _size.height/2);
    [self addChild: cemse_c];
    
    [cemse_c runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:.4],
      [CCMoveTo actionWithDuration:1 position:ccp(winSize.width/2, winSize.height * .9)],
      nil]];
}

-(void) onEnter
{
    [super onEnter];
    ccColor4B color = {255,255,255,255};
    CCLayerColor *colorLayer = [CCLayerColor layerWithColor:color];
    [self addChild:colorLayer z:-1];
}
@end
