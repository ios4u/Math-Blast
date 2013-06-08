//
//  Gems.m
//  MathBlast
//
//  Created by JRamos on 6/8/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "Gems.h"


@implementation Gems


//When this is called, a value and a position will be passed.
//The type of gem will depend on its value.
-(id) initWithValueAndPosition: (int)val :(CGPoint)point
{
    if ((self = [super init]))
    {
        _value = val;
        _point = &point;
        switch (val) {
                //make 
            case 0:
                break;
                
                //make red gem
            case 1:
                [self makeRedGem];
                break;
                
                //make
            case 2: 
                break;
        }
    }
    return self;
}

//contructs the type of gem with its image
-(void) makeRedGem
{
    NSLog(@"Red gem called");
    _gem = [CCSprite spriteWithFile:@"red_gem.png"];
    //_gem.position = *(_point);
    
    [self animateSprite];
    
}

//animates the falling of the gem to the game board
-(void) animateSprite
{
    float moveX = _point->x;
    float moveY = _point->y;
    _gem.position = ccp(moveX, moveY * 3);
    
    [_gem runAction:
     [CCSequence actions:
      [CCDelayTime actionWithDuration:.4],
      [CCMoveTo actionWithDuration:1 position:*(_point)],
      nil]];
}

@end
