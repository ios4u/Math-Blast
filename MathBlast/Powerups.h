//
//  Powerups.h
//  MathBlast
//
//  Created by JRamos on 6/11/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Powerups : CCLayer

@property (nonatomic) int powerType;

-(id)initWithValue: (int)val;

@end
