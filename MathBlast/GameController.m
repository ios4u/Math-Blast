//
//  MyCocos2DClass.m
//  MathBlast
//
//  Created by JRamos on 6/2/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "GameController.h"
#import "LevelManager.h"
#import "Gems.h"
#import "GameBoard.h"
#import "GameGrid.h"
#import "Background.h"
#import "Timer.h"
#import "Score.h"
#import "Powerups.h"
#import "Title.h"
@implementation GameController{
    
    CGPoint locationBegin;
    CGPoint locationBeginSection;
    CGPoint locationEndLine;
    CGPoint locationEnd;
    CGPoint locationReset;
    
    bool isHorizontal;
    bool isVertical;
    bool resetBool;
    bool endLevel;
    bool beginDrawHistory;
    
    NSMutableArray *drawArrayBegin;
    NSMutableArray *drawArrayEnd;
    
    GameBoard *gameBoard;
    
    Background *bckLayer;
    
    Timer *timer;
    
    Score *score;
    
    LevelManager *levelManager;
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
        
        //add background
        bckLayer = [[Background node] initWithController:self];
        [self addChild:bckLayer z:-5];
        
        //add logic to game (game grid)
        gameBoard = [[GameBoard alloc] init];
        NSLog(@"gameboard size: %d", [gameBoard.allPoints count]);
        
        timer = [Timer node];
        [self addChild:timer z:-1];
        
        //add scoring
        score = [Score node];
        [self addChild:score z:-1];
        
        //DrawLayer *sand = [DrawLayer node];
        //[self addChild:sand];
   
        _spriteArray = [[NSMutableArray alloc] init];
        drawArrayBegin = [[NSMutableArray alloc] init];
        drawArrayEnd = [[NSMutableArray alloc] init];
        endLevel = YES;
        [self setupLevelManager];
        [self scheduleUpdate];
        [self scheduleOnce:@selector(gemify) delay:10];
        [self scheduleOnce:@selector(startLevel) delay:10];
        
    }
    return self;
}

- (void)setupLevelManager {
    levelManager = [[LevelManager alloc] init];
    [levelManager nextStage];
}

-(void) startLevel
{
    endLevel = NO;
}

//generates gems on the game board
-(void) gemify
{
    for (GameGrid *gg in gameBoard.allPoints) {
        int gemran = [levelManager floatForProp:@"gem"];
        int r = arc4random() % gemran;
        if(!gg.hasGem){
            Gems *newGem = [[Gems alloc] initWithValueAndPosition:r :gg.gridPoint];
            [self addChild:newGem.gem z:-2];
            gg.hasGem = YES;
            newGem.gem.scale = .8;
            [_spriteArray addObject:newGem];
            
        }
    }
    
}


- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(endLevel) { return; }//end level if timer expires
    NSSet *multiTouch = [event allTouches];
    if( [multiTouch count] > 1) {
        return;
    }
    else {
        UITouch *touch = [touches anyObject];
        locationBegin = [touch locationInView: [touch view]];
        locationBegin = [[CCDirector sharedDirector] convertToGL:locationBegin];
        
        //find center of gem
        for (Gems *sprite in _spriteArray) {
            if (CGRectContainsPoint(sprite.gem.boundingBox, ccp(locationBegin.x, locationBegin.y))) {
                locationBegin = sprite.point;
            }
        }
        //if touch is not a gem
        if(locationBegin.x < 370){
            locationBegin.x = 370.0;
        }
        locationBeginSection = locationBegin;
        locationEnd = locationBeginSection;
        
        //NSLog(@"LocaBeginSec %fx , %fy" , locationBeginSection.x, locationBeginSection.y);
        //NSLog(@"LocaBeginSec %fx , %fy" , locationBegin.x, locationBegin.y);
        
        
    }
}

-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    if(endLevel){ return; }//end level if timer expires
    
    UITouch *touch = [touches anyObject];
    NSSet *multiTouch = [event allTouches];
    CGPoint boundTest = [touch locationInView: [touch view]];
    boundTest = [[CCDirector sharedDirector] convertToGL:boundTest];
    
    //make sure there are no multitouches and are in bounds
    if( [multiTouch count] > 1 || boundTest.x < 365) {
        return;
    }
    else {
        UITouch *touch = [touches anyObject];
        locationEnd = [touch locationInView: [touch view]];
        locationEnd = [[CCDirector sharedDirector] convertToGL:locationEnd];
        
        
        //for every sprite, check if it was touched. Then do some point calculation
        for (Gems *sprite in _spriteArray) {
            
            if (CGRectContainsPoint(sprite.gem.boundingBox, ccp(locationEnd.x, locationEnd.y))){
                //NSLog(@"LocBeginSec : %f" , locationBeginSection.y);
                //NSLog(@"LocEnd : %f" , locationEnd.x);
                
                sprite.gem.scale = 1.1;
                sprite.touched = YES;
                
                //check for orientation
                //if horizontal
                if((locationBeginSection.x < sprite.point.x || locationBeginSection.x > sprite.point.x) && (locationBeginSection.y == sprite.point.y)){
                    if(isVertical){
                        isVertical = NO;
                        //add draw points for history
                        beginDrawHistory = YES;
                        [drawArrayBegin addObject:[NSValue valueWithCGPoint:CGPointMake(locationBegin.x, locationBegin.y)]];
                        [drawArrayEnd addObject:[NSValue valueWithCGPoint:CGPointMake(locationBeginSection.x, locationBeginSection.y)]];
                        locationBegin = locationBeginSection;
                    }
                    isHorizontal = YES;
                    locationBeginSection = sprite.point;
                    locationEndLine = locationBeginSection;
                }
                //if vertical
                else if((locationBeginSection.y < sprite.point.y || locationBeginSection.y > sprite.point.y) && (locationBeginSection.x == sprite.point.x)){
                    if(isHorizontal){
                        isHorizontal = NO;
                        //add draw points for history
                        beginDrawHistory = YES;
                        [drawArrayBegin addObject:[NSValue valueWithCGPoint:CGPointMake(locationBegin.x, locationBegin.y)]];
                        [drawArrayEnd addObject:[NSValue valueWithCGPoint:CGPointMake(locationBeginSection.x, locationBeginSection.y)]];
                        locationBegin = locationBeginSection;
                    }
                    isVertical = YES;
                    locationBeginSection = sprite.point;
                    locationEndLine = locationBeginSection;
                }
                //if diagonal
                else if ((locationBeginSection.x < sprite.point.x || locationBeginSection.x > sprite.point.x) && (locationBeginSection.y < sprite.point.y || locationBeginSection.y > sprite.point.y)){
                    sprite.gem.scale = 1;
                    sprite.touched = NO;
                }
            }
            
            //NSLog(@"LocEnd : %f" , locationEnd.y);
        }
    }
    
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([[CCDirector sharedDirector] isPaused] ){ return; }
    
    if(endLevel) { return; }//end level if timer expires
    //ignore multitouch
    NSSet *multiTouch = [event allTouches];
    if( [multiTouch count] > 1) {
        return;
    }
    else {
        //[self removeAllChildren];
        locationBegin = locationReset;
        locationEnd = locationReset;
        
        isHorizontal = NO;
        isVertical = NO;
        
        //remove all draw points in history
        [drawArrayBegin removeAllObjects];
        [drawArrayEnd removeAllObjects];
        
        [self gemLogic];
    }
}

//apply removal, regeneraton of gem, and scoring logic
-(void)gemLogic
{
    NSMutableArray *toDelete = [NSMutableArray array];
    int totalGemsTouched = 0;
    int totalGemsValue = 0;
    NSMutableArray *distinctGems = [[NSMutableArray alloc] init];
    
    //figure out score and if player got sum correct
    for (Gems *sprite in _spriteArray) {
        if(sprite.touched){
            
            //get scoring for turn
            totalGemsTouched++;
            totalGemsValue = totalGemsValue + sprite.value;
            NSNumber *num = [NSNumber numberWithInt:sprite.value];
            [distinctGems addObject:num];
        }
    }
    
    //do gem remove logic if sum is correct
    if(totalGemsValue == score.levelTarget){
        for (Gems *sprite in _spriteArray) {
            if(sprite.touched){
                
                //remove sprite from board
                [sprite putGemInTreasureChest];
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
        [_spriteArray removeObjectsInArray:toDelete];
        
        //calculate score if the right gem sum
        NSArray *distinctArray =  [[NSSet setWithArray:distinctGems] allObjects];
        int distinct = [distinctArray count];
        int scoreForTurn = (score.levelTarget * totalGemsTouched) * distinct;
        [score addScore:scoreForTurn :locationEndLine : totalGemsTouched :distinct :timer.totalSeconds :levelManager];
        
        //move gems down to empty spaces
        [self fillEmptySpacesWithGems];
        
    }else{//wrong sum
        //reset gem size
        [self resetGemSize];
        //shake screen
        [self shakeScreen:2];
    }
    
    //replace empty spaces with new gems
    [self gemify];
}

-(void) resetGemSize
{
    for (Gems *sprite in _spriteArray) {
        sprite.touched = NO;
        sprite.gem.scale = .8;
    }
}

- (void)fillEmptySpacesWithGems
{
    bool emptySpace = YES;
    while (emptySpace) {
        emptySpace = NO;
        //fill empty spaces
        for (Gems *sprite in _spriteArray) {
            for (GameGrid *gg in gameBoard.allPoints) {
                if(sprite.point.x == gg.gridPoint.x && (sprite.point.y - gg.gridPoint.y) == 71 && !gg.hasGem){
                    //NSLog(@"Will move down");
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
}

- (void)shakeScreen:(int)times {
    if(locationBeginSection.x == 370) { return; }
    id shakeLow = [CCMoveBy
                   actionWithDuration:0.025 position:ccp(0, -2)];
    id shakeLowBack = [shakeLow reverse];
    id shakeHigh =  [CCMoveBy
                     actionWithDuration:0.025 position:ccp(0, 2)];
    id shakeHighBack = [shakeHigh reverse];
    id shake = [CCSequence actions:shakeLow, shakeLowBack,
                shakeHigh, shakeHighBack, nil];
    CCRepeat* shakeAction = [CCRepeat
                             actionWithAction:shake times:times];
    
    [self runAction:shakeAction];
}

-(void) update:(ccTime)delta //keeps track if level was completed
{
    //do end level animations if level is over
    if(timer.totalSeconds == 0){
        endLevel = YES;
        [self resetGemSize];
        [self unscheduleUpdate];
        
        for (Gems *sprite in _spriteArray) {
            [sprite endLevelAnimation];
        }
        [score didEndLevel:self];
        [_spriteArray removeAllObjects];
        [drawArrayBegin removeAllObjects];
        [drawArrayEnd removeAllObjects];
        locationBegin = locationReset;
        locationEnd = locationReset;
        isHorizontal = NO;
        isVertical = NO;
    }
}

-(void) startNextLevel
{
    [self scheduleOnce:@selector(startLevel) delay:8];
    timer.totalSeconds = 120;
    [timer startTimer];
    
    //clear gamegrid of gems so that a new level can start
    for (GameGrid *gg in gameBoard.allPoints) {
        gg.hasGem = NO;
    }
    
    //start level again
    [self scheduleUpdate];
    [levelManager nextStage];
    [self scheduleOnce:@selector(gemify) delay:8];
    [self scheduleOnce:@selector(makePowerupsLive) delay:9]; //makes powerups live
}

-(void) makePowerupsLive
{
    for (Powerups *powerup in score.arrayOfPowerups) {
        powerup.isLive = YES;
        [powerup setLive:YES];
        [powerup setGems:_spriteArray];//passes gem pointer
    }
}

-(void)draw
{
    if(endLevel){ return; }
    ccColor4B hhh = ccc4(158,0,158, 128);
    
    ccDrawColor4F(hhh.r, hhh.g, hhh.b, hhh.a);
    glLineWidth(3);
    
    if(isHorizontal || isVertical){
        CGPoint verts[] = { locationBegin, locationEndLine };
        ccDrawLine(verts[0], verts[1]);
        if(beginDrawHistory){
            //this draws all previously lines of the same orientation
            for (int i=0; i<[drawArrayEnd count]; i++) {
                NSValue *val = [drawArrayBegin objectAtIndex:i];
                CGPoint p = [val CGPointValue];
                NSValue *val2 = [drawArrayEnd objectAtIndex:i];
                CGPoint p2 = [val2 CGPointValue];
                ccDrawLine(p, p2);
            }
        }
    }
    
}


@end