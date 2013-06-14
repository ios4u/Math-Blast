//
//  LevelManager.h
//  SpaceBlaster2
//
//  Created by JRamos on 2/23/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//


/*
 *
 *CLASS TAKEN FROM SPACEGAME
 *(need to modify in the future)
 *
 */


#import <Foundation/Foundation.h>

/*******************************************************************************
 This contains an enum for the GameStates for the game. This is different than
 the stages inside a level. These are the main overall states such as
 'Title Screen', 'Playing', 'GameOver'.
 It Also contains some helper methods to advance to the next stage or next
 level, a method to give LevelManager time to update itself, and some helper
 methods to return properties for the current stage (or check if they exist).
 *******************************************************************************/
typedef enum {
    GameStateTitle = 0,
    GameStateNormal,
    GameStateDone
} GameState;

@interface LevelManager : NSObject

@property (assign) GameState gameState;

- (int)curLevelIdx;
- (int)curStageIdx;
- (void)nextStage;
- (void)nextLevel;
- (BOOL)update;
- (float)floatForProp:(NSString *)prop;
- (NSString *)stringForProp:(NSString *)prop;
- (BOOL)boolForProp:(NSString *)prop;
- (BOOL)hasProp:(NSString *)prop;

@end
