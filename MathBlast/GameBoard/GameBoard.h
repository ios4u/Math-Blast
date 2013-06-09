//
//  GameBoard.h
//  MathBlast
//
//  Created by JRamos on 6/8/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameBoard : CCNode

@property (strong, nonatomic) NSMutableArray* allPoints;

-(id) init;

@end
