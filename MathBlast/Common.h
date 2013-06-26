//
//  Common.h
//  SpaceBlaster2
//
//  Created by JRamos on 2/22/13.
//  Copyright (c) 2013 JRamos. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Common : NSObject

//C function
float randomValueBetween(float low, float high);

#define PTM_RATIO ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 200.0 : 100.0)
#define PTM_RATIO_BOSS ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ? 2000.0 : 100.0)

@end
