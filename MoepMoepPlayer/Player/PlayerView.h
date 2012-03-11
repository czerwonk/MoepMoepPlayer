//
//  PlayerView
//
//  Created by Daniel Czerwonk on 3/8/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "View.h"
#import "Player.h"
#import "PlayerViewDelegate.h"

@protocol PlayerView<View>

- (void)setViewDelegate:(id<PlayerViewDelegate>)delegate;
- (void)setStreams:(NSArray *)streams;
- (void)playerChangedStatusTo:(PlayerStatus)status;

@end