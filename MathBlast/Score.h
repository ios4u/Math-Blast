//
//  Score.h
//  MathBlast
//
//  Created by JRamos on 6/9/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Score : CCLayer 

@property (nonatomic) int gemScore;
@property (strong, nonatomic) NSMutableArray *arrayOfPowerups;

-(void) addScore:(int)scoreForTurn :(CGPoint) location :(int) totalGemsTouched :(int)distinct;

-(void) didEndLevel;
@end
