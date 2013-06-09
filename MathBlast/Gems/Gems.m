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
        _point = point;
        switch (val) {
                //make purple gem
            case 0:
                [self makePurpleGem];
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
    _gem = [CCSprite spriteWithFile:@"red_gem.png"];
    
    [self animateSprite];
    
}

-(void) makePurpleGem
{
    _gem = [CCSprite spriteWithFile:@"purple_gem.png"];
    
    [self animateSprite];
}

//animates the falling of the gem to the game board
-(void) animateSprite
{
    float moveX = _point.x;
    float moveY = _point.y;
    _gem.position = ccp(moveX, moveY * 2.5);
    
    [_gem runAction:
     [CCSequence actions:
      [CCMoveTo actionWithDuration:.7 position:_point],
      nil]];
}

-(void)moveSpriteDown
{
    [_gem runAction:
     [CCSequence actions:
      [CCMoveBy actionWithDuration:.3 position:ccp(0, -71)],
      nil]];
}

-(void) removeGem
{
    [_gem removeFromParent];
}
@end
