//
//  LevelManager.m
//  SpaceBlaster2
//
//  Created by JRamos on 2/23/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "LevelManager.h"
#import <QuartzCore/QuartzCore.h>

@implementation LevelManager {
    
    //This declares some private instance variables to keep track of the times the current
    //stage has started and how long it should run in seconds.
    double _stageStart;
    double _stageDuration;
    
    
    //variables that reference to the data pulled from Levels.plist. It stores the overall
    //dictionary of data from the file, the list of levels and the current level index,
    //the list of stages within the level and the current stage index, and finally the
    //dictionary of data for the current stage.
    NSDictionary * _data;
    NSArray * _levels;
    int _curLevelIdx;
    NSArray * _curStages;
    int _curStageIdx;
    NSDictionary * _curStage;
}

- (id)init
{
    
    /*******************************************************************************
     This gets the path for Levels.plist inside the main bundle. It then uses a
     helper method called dictionaryWithContentsOfFile to create a new NSDictionary
     based on the contents of the property list.
     Then it gets the entry in the root dictionary named Levels.
     *******************************************************************************/
    if ((self = [super init])) {
        
        NSString *levelDefsFile = [[NSBundle mainBundle] pathForResource:@"Levels"
                                                                  ofType:@"plist"];
        _data = [NSDictionary dictionaryWithContentsOfFile:levelDefsFile];
        NSAssert(_data != nil, @"Couldn't open Levels file");
        
        _levels = (NSArray *) _data[@"Levels"];
        NSAssert(_levels != nil, @"Couldn't find Levels entry");
        _curLevelIdx = -1;
        _curStageIdx = -1;
        _gameState = GameStateTitle;
        
    }
    return self;
}

- (int)curLevelIdx
{
    return _curLevelIdx;
}

-(int)curStageIdx
{
    return _curStageIdx;
}

- (BOOL)hasProp:(NSString *)prop
{
    NSString * retval =  (NSString *) _curStage[prop];
    return retval != nil;
}

- (NSString *)stringForProp:(NSString *)prop
{
    NSString * retval =  (NSString *) _curStage[prop];
    NSAssert(retval != nil, @"Couldn't find prop %@", prop);
    return retval;
}

- (float)floatForProp:(NSString *)prop
{
    NSNumber * retval = (NSNumber *) _curStage[prop];
    NSAssert(retval != nil, @"Couldn't find prop %@", prop);
    return retval.floatValue;
}

- (BOOL)boolForProp:(NSString *)prop
{
    NSNumber * retval =  (NSNumber *) _curStage[prop];
    if (!retval) return FALSE;
    return [retval boolValue];
}

- (void)nextLevel
{
    _curLevelIdx++;
    if (_curLevelIdx >= _levels.count) {
        _gameState = GameStateDone;
        return;
    }
    _curStages = (NSArray *) _levels[_curLevelIdx];
    [self nextStage];
}


/*******************************************************************************
 * @method      nextStage
 * @abstract    <# abstract #>
 * @description
 -------------------------------------------------------------------------------
 nextStage tries to get the next entry in the stages array, but if there are no
 more it advances to the next level. nextStage is where it sets up the _curStage
 dictionary. It also looks for a special key that must exist for each stage—the
 Duration, which specifies how long the stage should last in seconds—and
 squirrels that away, along with the current time (as _stageStart).
 *******************************************************************************/
- (void)nextStage
{
    _curStageIdx++;
    if (_curStageIdx >= _curStages.count) {
        _curStageIdx = -1;
        [self nextLevel];
        return;
    }
    
    _gameState = GameStateNormal;
    _curStage = _curStages[_curStageIdx];
    
}

/*******************************************************************************
 * @method      update
 * @abstract    <# abstract #>
 * @description
 -------------------------------------------------------------------------------
 update will be called by ActionLayer each frame, and its job is to check if
 it’s time to advance to the next stage, and to call nextStage if so. This method
 returns a BOOL that indicates if the game has advanced to a new stage.
 *******************************************************************************/
- (BOOL)update
{
    if (_gameState == GameStateTitle ||
        _gameState == GameStateDone) return FALSE;
    if (_stageDuration == -1) return FALSE;
    
    double curTime = CACurrentMediaTime();
    if (curTime > _stageStart + _stageDuration) {
        [self nextStage];
        return TRUE;
    }
    
    return FALSE;
}

@end
