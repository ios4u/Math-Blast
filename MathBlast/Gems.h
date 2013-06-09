//
//  Gems.h
//  MathBlast
//
//  Created by JRamos on 6/8/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Gems : CCSprite

@property (nonatomic) int value;
@property (nonatomic) CGPoint point;
@property (strong, nonatomic) CCSprite* gem;
@property (nonatomic) bool touched;

-(id)initWithValueAndPosition: (int)val :(CGPoint)point;

-(void)animateSprite;

-(void)moveSpriteDown;

-(void)removeGem;

@end
