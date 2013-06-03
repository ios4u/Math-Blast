//
//  MyCocos2DClass.h
//  MathBlast
//
//  Created by JRamos on 6/2/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SandBox : CCLayer 
{
    CGPoint lastTouchPoint;
}
    
// returns a Scene that contains the HelloWorld as the only child
+(id) scene;
