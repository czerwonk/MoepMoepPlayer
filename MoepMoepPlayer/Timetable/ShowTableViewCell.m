//
//  ShowTableViewCell
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "ShowTableViewCell.h"


@implementation ShowTableViewCell

@synthesize startTimeLabel;
@synthesize showNameLabel;
@synthesize showDescriptionLabel;

- (void)dealloc {
    [super dealloc];

    [startTimeLabel release];
    [showNameLabel release];
    [showDescriptionLabel release];
}

@end