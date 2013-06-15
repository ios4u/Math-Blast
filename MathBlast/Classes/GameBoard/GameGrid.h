//
//  GameGrid.h
//  MathBlast
//
//  Created by JRamos on 6/8/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameBoard.h"


//Helps keep track of the gems on the game board
@interface GameGrid : CCNode

@property (nonatomic) CGPoint gridPoint;
@property (nonatomic) bool hasGem;

@end
