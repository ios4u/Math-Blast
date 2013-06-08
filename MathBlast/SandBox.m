//
//  MyCocos2DClass.m
//  MathBlast
//
//  Created by JRamos on 6/2/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "SandBox.h"
#import "DrawLayer.h"
#import "Gems.h"
@implementation SandBox{
    
    CGPoint locationBegin;
    CGPoint locationEnd;
    CGPoint locationReset;
    
    bool isHorizontal;
    bool isVertical;
    bool setOrientation;
    bool resetBool;
    
    NSMutableArray *spriteArray;
    
}


/*******************************************************************************
 * @method      scene
 * @abstract    <# abstract #>
 * @description
 -------------------------------------------------------------------------------
 Declares the static scene method. This creates a default CCScene, and adds
 ActionLayer as a child of the scene. When Cocos2D scene run on startup, this
 method is called.
 *******************************************************************************/
//+(id) scene
//{
//	// 'scene' is an autorelease object.
//	CCScene *scene = [CCScene node];
//	
//	// 'layer' is an autorelease object.
//	SandBox *layer = [SandBox node];
//	
//    DrawLayer *sand = [DrawLayer node];
//    
//	// add layer as a child to scene
//	[scene addChild: layer];
//    [scene addChild:sand];
//	
//	// return the scene
//	return scene;
//}

// on "init" you need to initialize your instance
-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super init] )) {
        
        self.touchEnabled = YES;
        setOrientation = YES;
        
        //DrawLayer *sand = [DrawLayer node];
        //[self addChild:sand];
        
        spriteArray = [[NSMutableArray alloc] init];
        [self gemify];

    }
    return self;
}

-(void) gemify
{
//    CCSprite *red_gem = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem.position = ccp(400,400);
//    [self addChild:red_gem];
//    [spriteArray addObject:red_gem];
//    
//    CCSprite *red_gem2 = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem2.position = ccp(480,400);
//    [self addChild:red_gem2];
//    [spriteArray addObject:red_gem2];
//    
//    CCSprite *red_gem3 = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem3.position = ccp(560,400);
//    [self addChild:red_gem3];
//    [spriteArray addObject:red_gem3];
//    
//    CCSprite *red_gem4 = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem4.position = ccp(640,400);
//    [self addChild:red_gem4];
//    [spriteArray addObject:red_gem4];
//    
//    CCSprite *red_gem5 = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem5.position = ccp(400,320);
//    [self addChild:red_gem5];
//    [spriteArray addObject:red_gem5];
//    
//    CCSprite *red_gem6 = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem6.position = ccp(480,320);
//    [self addChild:red_gem6];
//    [spriteArray addObject:red_gem6];
//   
//    CCSprite *red_gem7 = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem7.position = ccp(560,320);
//    [self addChild:red_gem7];
//    [spriteArray addObject:red_gem7];
//    
//    CCSprite *red_gem8 = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem8.position = ccp(640,320);
//    [self addChild:red_gem8];
//    [spriteArray addObject:red_gem8];
//    
//    CCSprite *red_gem9 = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem9.position = ccp(400,480);
//    [self addChild:red_gem9];
//    [spriteArray addObject:red_gem9];
//    
//    CCSprite *red_gem10 = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem10.position = ccp(480,480);
//    [self addChild:red_gem10];
//    [spriteArray addObject:red_gem10];
//    
//    CCSprite *red_gem11 = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem11.position = ccp(560,480);
//    [self addChild:red_gem11];
//    [spriteArray addObject:red_gem11];
//    
//    CCSprite *red_gem12 = [CCSprite spriteWithFile:@"red_gem.png"];
//    red_gem12.position = ccp(640,480);
//    [self addChild:red_gem12];
//    [spriteArray addObject:red_gem12];
    
    Gems *redGem = [[Gems alloc] initWithValueAndPosition:1 :ccp(400,400)];
    [self addChild:redGem.gem];
    [spriteArray addObject:redGem];
    
    Gems *redGem2 = [[Gems alloc] initWithValueAndPosition:1 :ccp(480,400)];
    [self addChild:redGem2.gem];
    [spriteArray addObject:redGem2];
    
    Gems *redGem3 = [[Gems alloc] initWithValueAndPosition:1 :ccp(560,400)];
    [self addChild:redGem3.gem];
    [spriteArray addObject:redGem3];
    
    Gems *redGem4 = [[Gems alloc] initWithValueAndPosition:1 :ccp(640,400)];
    [self addChild:redGem4.gem];
    [spriteArray addObject:redGem4];
    
    Gems *redGem5 = [[Gems alloc] initWithValueAndPosition:1 :ccp(400,480)];
    [self addChild:redGem5.gem];
    [spriteArray addObject:redGem5];
    
    Gems *redGem6 = [[Gems alloc] initWithValueAndPosition:1 :ccp(480,480)];
    [self addChild:redGem6.gem];
    [spriteArray addObject:redGem6];
    
    Gems *redGem7 = [[Gems alloc] initWithValueAndPosition:1 :ccp(560,480)];
    [self addChild:redGem7.gem];
    [spriteArray addObject:redGem7];
    
    Gems *redGem8 = [[Gems alloc] initWithValueAndPosition:1 :ccp(640,480)];
    [self addChild:redGem8.gem];
    [spriteArray addObject:redGem8];
    
    Gems *redGem9 = [[Gems alloc] initWithValueAndPosition:1 :ccp(400,320)];
    [self addChild:redGem9.gem];
    [spriteArray addObject:redGem9];
    
    Gems *redGem10 = [[Gems alloc] initWithValueAndPosition:1 :ccp(480,320)];
    [self addChild:redGem10.gem];
    [spriteArray addObject:redGem10];
    
    Gems *redGem11 = [[Gems alloc] initWithValueAndPosition:1 :ccp(560,320)];
    [self addChild:redGem11.gem];
    [spriteArray addObject:redGem11];
    
    Gems *redGem12 = [[Gems alloc] initWithValueAndPosition:1 :ccp(640,320)];
    [self addChild:redGem12.gem];
    [spriteArray addObject:redGem12];
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    UITouch *touch = [touches anyObject];
    //    if( touch ) {
    locationBegin = [touch locationInView: [touch view]];
    locationBegin = [[CCDirector sharedDirector] convertToGL:locationBegin];
    locationEnd = [touch locationInView: [touch view]];
    locationEnd = [[CCDirector sharedDirector] convertToGL:locationEnd];
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    locationEnd = [touch locationInView: [touch view]];
    locationEnd = [[CCDirector sharedDirector] convertToGL:locationEnd];
    
    [self checkForLineOrientation];
    
    for (Gems *sprite in spriteArray) {
        if(isHorizontal){
            if (CGRectContainsPoint(sprite.gem.boundingBox, ccp(locationEnd.x, locationBegin.y))) {
                //NSLog(@"Sprite Touched!");
                sprite.gem.scale = 1.4;
                sprite.touched = YES;
            }else{
               // NSLog(@"Sprite Not Touched");
                sprite.gem.scale = 1.0;
            }
        }else if (isVertical){
            if (CGRectContainsPoint(sprite.gem.boundingBox, ccp(locationBegin.x, locationEnd.y))) {
                //NSLog(@"Sprite Touched!");
                sprite.gem.scale = 1.4;
                sprite.touched = YES;

            }else{
                //NSLog(@"Sprite Not Touched");
                sprite.gem.scale = 1.0;

            }
        }
    }
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self removeAllChildren];
    locationBegin = locationReset;
    locationEnd = locationReset;
    
    setOrientation = YES;
    isHorizontal = 0;
    isVertical = 0;
    
    [self resetGemSize];
    
}

-(void)checkForLineOrientation
{
    if(setOrientation){
        if(locationBegin.x - 25 > locationEnd.x || locationBegin.x + 25 < locationEnd.x)
        {
            isHorizontal = YES;
            setOrientation = NO;
        }
        else if(locationBegin.y - 25 > locationEnd.y || locationBegin.y + 25 < locationEnd.y){
            isVertical = YES;
            setOrientation = NO;
        }
    }
}

-(void)resetGemSize
{
    NSMutableArray *toDelete = [NSMutableArray array];
    for (Gems *sprite in spriteArray) {
        if(sprite.touched){
            [self removeChild:sprite.gem];
            [toDelete addObject:sprite];
        }
    }
    
    // Remove them
    [spriteArray removeObjectsInArray:toDelete];
}

-(void)draw
{
    ccColor4B hhh = ccc4(158,0,158, 128);
    
    ccDrawColor4F(hhh.r, hhh.g, hhh.b, hhh.a);
    glLineWidth(3);
    
    if(isHorizontal){
        CGPoint verts[] = { ccp(locationBegin.x,locationBegin.y), ccp(locationEnd.x,locationBegin.y) };
        ccDrawLine(verts[0], verts[1]);
    }
    else if(isVertical){
        CGPoint verts[] = { ccp(locationBegin.x,locationBegin.y), ccp(locationBegin.x,locationEnd.y) };
        ccDrawLine(verts[0], verts[1]);
    }
}


@end