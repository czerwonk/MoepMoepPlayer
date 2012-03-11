//
//  Timetable
//
//  Created by Daniel Czerwonk on 3/3/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "Timetable.h"


@implementation Timetable

@synthesize shows;

- (void)dealloc {
    [super dealloc];

    [shows release];
}

@end