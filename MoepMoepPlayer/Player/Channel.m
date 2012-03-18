//
//  Stream
//
//  Created by Daniel Czerwonk on 3/7/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "Channel.h"


@implementation Channel

@synthesize name;
@synthesize mainStreamUrl;
@synthesize mobileStreamUrl;

- (void)dealloc {
    [super dealloc];

    [name release];
    [mainStreamUrl release];
    [mobileStreamUrl release];
}

@end