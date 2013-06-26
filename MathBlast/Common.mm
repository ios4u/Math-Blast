//
//  Common.mm
//  SpaceBlaster2
//
//  Created by JRamos on 2/22/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import "Common.h"


//This function to give you a random number between two floats.
float randomValueBetween(float low, float high) {
    return (((float) arc4random() / 0xFFFFFFFFu)
            * (high - low)) + low;
}
