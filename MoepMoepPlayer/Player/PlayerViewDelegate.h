//
//  PlayerViewDelegate
//
//  Created by Daniel Czerwonk on 3/8/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "Channel.h"

@protocol PlayerViewDelegate<NSObject>

- (void)reloadChannels;
- (void)refreshPlayer;
- (void)playOrPause;
- (void)switchToMainStream:(Channel *)channel;
- (void)switchToMobileStream:(Channel *)channel;

@end