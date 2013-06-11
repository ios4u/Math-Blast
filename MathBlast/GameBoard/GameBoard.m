//
//  GameBoard.m
//  MathBlast
//
//  Created by JRamos on 6/8/13.
//  Copyright 2013 JRamos. All rights reserved.
//

#import "GameBoard.h"
#import "GameGrid.h"


@implementation GameBoard

-(id) init
{
    if ((self = [super init]))
    {
        _allPoints = [[NSMutableArray alloc] init];
        [self setupBoard];
    }
    return self;

}

//manually set the coordinates for each grid / each playing piece
//any coordinate changes to the background board must also be made here
-(void)setupBoard
{
    int xCoord = 420;
    int yCoord = 645;
    for (int i=0; i<64; i++) {
        if(xCoord < 950){
            GameGrid *grid1 = [[GameGrid alloc] init];
            grid1.hasGem = NO;
            grid1.gridPoint = ccp(xCoord,yCoord);
            [_allPoints addObject:grid1];
            
            xCoord = xCoord + 70;
        }
        else{
            xCoord = 420;
            yCoord = yCoord - 71;
            i--;
        }
    }
    
}


@end
