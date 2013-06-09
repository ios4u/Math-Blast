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
#import "GameBoard.h"
#import "GameGrid.h"
#import "Background.h"
@implementation SandBox{
    
    CGPoint locationBegin;
    CGPoint locationEnd;
    CGPoint locationReset;
    
    bool isHorizontal;
    bool isVertical;
    bool setOrientation;
    bool resetBool;
    
    NSMutableArray *spriteArray;
    
    GameBoard *gameBoard;
    
    Background *bckLayer;
    
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
        
        bckLayer = [Background node];
        [self addChild:bckLayer z:-1];
        
        gameBoard = [[GameBoard alloc] init];        
        NSLog(@"gameboard size: %d", [gameBoard.allPoints count]);
        
        //DrawLayer *sand = [DrawLayer node];
        //[self addChild:sand];
        
        spriteArray = [[NSMutableArray alloc] init];
        [self gemify];

    }
    return self;
}

//generates gems on the game board
-(void) gemify
{
    for (GameGrid *gg in gameBoard.allPoints) {
        int r = arc4random() % 2;
        if(!gg.hasGem){
            Gems *redGem = [[Gems alloc] initWithValueAndPosition:r :gg.gridPoint];
            [self addChild:redGem.gem];
            gg.hasGem = YES;
            [spriteArray addObject:redGem];
        }
    }
    
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    UITouch *touch = [touches anyObject];
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
    
    [self resetGems];
    
}

-(void)resetGems
{
    NSMutableArray *toDelete = [NSMutableArray array];
    for (Gems *sprite in spriteArray) {
        if(sprite.touched){
            
            //remove sprite from board
            [sprite removeGem];
            [toDelete addObject:sprite];
            
            //update board
            for (GameGrid *gg in gameBoard.allPoints) {
                if(sprite.point.x == gg.gridPoint.x && sprite.point.y == gg.gridPoint.y){
                    gg.hasGem = NO;
                }
            }
        }
    }
    
    // Remove from array
    [spriteArray removeObjectsInArray:toDelete];
    
    bool emptySpace = YES;
    while (emptySpace) {
        emptySpace = NO;
        //fill empty spaces
        for (Gems *sprite in spriteArray) {
            for (GameGrid *gg in gameBoard.allPoints) {
                if(sprite.point.x == gg.gridPoint.x && (sprite.point.y - gg.gridPoint.y) == 71 && !gg.hasGem){
                    NSLog(@"Will move down");
                    for (GameGrid *gg in gameBoard.allPoints) {
                        if(sprite.point.x == gg.gridPoint.x && sprite.point.y == gg.gridPoint.y){
                            gg.hasGem = NO;
                        }
                    }
                    sprite.point = gg.gridPoint;
                    [sprite moveSpriteDown];
                    gg.hasGem = YES;
                    emptySpace = YES;
                    
                }
            }
        }
    }
    
    
    //replace gems
    [self gemify];
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