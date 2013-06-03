//
//  MyCocos2DClass.m
//  MathBlast
//
//  Created by JRamos on 6/2/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "SandBox.h"


@end
@implementation SandBox{
    NSMutableArray *naughtytoucharray;
    
    CGPoint locationBegin;
    CGPoint locationEnd;
    CGPoint locationReset;
    
    bool isHorizontal;
    bool setOrientation;
    bool resetBool;
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
+(id) scene
{
    // 'scene' is an autorelease object.
    CCScene *scene = [CCScene node];
    
    // 'layer' is an autorelease object.
    SandBox *layer = [SandBox node];
    
    // add layer as a child to scene
    [scene addChild: layer];
    
    // return the scene
    return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    // always call "super" init
    // Apple recommends to re-assign "self" with the "super" return value
    if( (self=[super init] )) {
        self.touchEnabled = YES;
        lastTouchPoint = ccp(-1.0f,-1.0f);
        
        setOrientation = YES;
        
    }
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    
    UITouch *touch = [touches anyObject];
//    if( touch ) {
        locationBegin = [touch locationInView: [touch view]];
        locationBegin = [[CCDirector sharedDirector] convertToGL:locationBegin];
        locationEnd = [touch locationInView: [touch view]];
        locationEnd = [[CCDirector sharedDirector] convertToGL:locationEnd];
//        CCLOG(@"location(%f,%f)", locationBegin.x, locationBegin.y);
//
//        if( CGPointEqualToPoint(lastTouchPoint, ccp(-1.0f,-1.0f) ) )
//        {
//            lastTouchPoint = ccp(location.x, location.y);
//            CCSprite *circle = [CCSprite spriteWithFile:@"circle.png"];
//            [circle setPosition:lastTouchPoint];
//            [self addChild:circle];
//            CCLOG(@"initial touchpoint set. to (%f,%f)", lastTouchPoint.x, lastTouchPoint.y);
//        }
//        else {
//            CCLOG(@"lastTouchPoint is now(%f,%f), location is (%f,%f)", lastTouchPoint.x, lastTouchPoint.y, location.x, location.y);
//            CGPoint diff = ccpSub(location, lastTouchPoint);
//            float rads = atan2f( diff.y, diff.x);
//            float degs = -CC_RADIANS_TO_DEGREES(rads);
//            float dist = ccpDistance(lastTouchPoint, location);
//            CCSprite *line = [CCSprite spriteWithFile:@"line.png"];
//            [line setAnchorPoint:ccp(0.0f, 0.5f)];
//            [line setPosition:lastTouchPoint];
//            [line setScaleX:dist / line.boundingBox.size.width];
//            [line setRotation: degs];
//            [self addChild:line];
//            
//            CCSprite *circle = [CCSprite spriteWithFile:@"circle.png"];
//            [circle setPosition:location];
//            [self addChild:circle];
//            
//            //            lastTouchPoint = ccp(location.x, location.y);
//            lastTouchPoint = ccp(-1.0f,-1.0f);
//        }
//        
//    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSLog(@"Touches");
    
    UITouch *touch = [touches anyObject];
    locationEnd = [touch locationInView: [touch view]];
    locationEnd = [[CCDirector sharedDirector] convertToGL:locationEnd];
    
    [self checkForLineOrientation];
    //CCLOG(@"location(%f,%f)", locationBegin.x, locationBegin.y);
    
    
//    UITouch *touch = [touches anyObject];
//    CGPoint location = [touch locationInView: [touch view]];
//    location = [[CCDirector sharedDirector] convertToGL:location];
//    
//    CCLOG(@"lastTouchPoint is now(%f,%f), location is (%f,%f)", lastTouchPoint.x, lastTouchPoint.y, location.x, location.y);
//    CGPoint diff = ccpSub(location, lastTouchPoint);
//    float rads = atan2f( diff.y, diff.x);
//    float degs = -CC_RADIANS_TO_DEGREES(rads);
//    float dist = ccpDistance(lastTouchPoint, location);
//    CCSprite *line = [CCSprite spriteWithFile:@"line.png"];
//    [line setAnchorPoint:ccp(0.0f, 0.5f)];
//    [line setPosition:lastTouchPoint];
//    [line setScaleX:dist / line.boundingBox.size.width];
//    [line setRotation: degs];
//    [self addChild:line];
    

//    CGPoint location = [touches locationInView: [touches view]];
//    location = [[CCDirector sharedDirector] convertToGL:location];
//    CCLOG(@"lastTouchPoint is now(%f,%f), location is (%f,%f)", lastTouchPoint.x, lastTouchPoint.y, location.x, location.y);
//    CGPoint diff = ccpSub(location, lastTouchPoint);
//    float rads = atan2f( diff.y, diff.x);
//    float degs = -CC_RADIANS_TO_DEGREES(rads);
//    float dist = ccpDistance(lastTouchPoint, location);
//    CCSprite *line = [CCSprite spriteWithFile:@"line.png"];
//    [line setAnchorPoint:ccp(0.0f, 0.5f)];
//    [line setPosition:lastTouchPoint];
//    [line setScaleX:dist / line.boundingBox.size.width];
//    [line setRotation: degs];
//    [self addChild:line];
//    
//    CCSprite *circle = [CCSprite spriteWithFile:@"circle.png"];
//    [circle setPosition:location];
//    [self addChild:circle];
//    
//    //            lastTouchPoint = ccp(location.x, location.y);
//    lastTouchPoint = ccp(-1.0f,-1.0f);

}

-(void)checkForLineOrientation
{
    if(setOrientation){
        if(locationBegin.x - 50 > locationEnd.x || locationBegin.x + 50 < locationEnd.x)
        {
            isHorizontal = YES;
            setOrientation = NO;
        }
        else if(locationBegin.y - 50 > locationEnd.y || locationBegin.y + 50 < locationEnd.y){
            isHorizontal = NO;
            setOrientation = NO;
        }
    }
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    //[self removeAllChildren];
    locationBegin = locationReset;
    locationEnd = locationReset;
    
    setOrientation = YES;
    isHorizontal = resetBool;
    
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
    else if(!isHorizontal){
        CGPoint verts[] = { ccp(locationBegin.x,locationBegin.y), ccp(locationBegin.x,locationEnd.y) };
        ccDrawLine(verts[0], verts[1]);
    }
    else{
        CGPoint verts[] = { ccp(locationBegin.x,locationBegin.y), ccp(locationEnd.x,locationEnd.y) };
        ccDrawLine(verts[0], verts[1]);
    }
}

@end

