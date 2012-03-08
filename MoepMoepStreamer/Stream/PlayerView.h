//
//  PlayerView
//
//  Created by Daniel Czerwonk on 3/8/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "View.h"
#import "Player.h"

@protocol PlayerView<View>

- (void)setStreams:(NSArray *)streams;
- (void)streamChangedStatus:(PlayerStatus)status;

@end