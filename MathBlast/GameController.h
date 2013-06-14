//
//  MyCocos2DClass.h
//  MathBlast
//
//  Created by JRamos on 6/2/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameController : CCLayer
{
    CGPoint lastTouchPoint;
}

@property (strong, nonatomic) NSMutableArray *spriteArray;
@property (nonatomic) bool isGameOver;

-(void) startNextLevel;

// returns a CCScene that contains the HelloWorldLayer as the only child
//+(CCScene *) scene;

@end