//
//  PlayerDelegate
//
//  Created by Daniel Czerwonk on 2/29/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "PlayerStatus.h"

@protocol PlayerDelegate

- (void)playerChangedStatusTo:(PlayerStatus)status;

@end