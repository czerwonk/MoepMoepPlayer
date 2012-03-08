//
//  PlayerViewDelegate
//
//  Created by Daniel Czerwonk on 3/8/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "Stream.h"

@protocol PlayerViewDelegate<NSObject>

- (void)refreshPlayer;
- (void)startPlayer;
- (void)stopPlayer;
- (void)switchToMainStream:(Stream *)stream;
- (void)switchToMobileStream:(Stream *)stream;

@end