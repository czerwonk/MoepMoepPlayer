//
//  Player
//
//  Created by Daniel Czerwonk on 2/29/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "PlayerDelegate.h"
#import "PlayerStatus.h"

@protocol Player<NSObject>

@property (copy) NSString *streamUrl;
@property (nonatomic, retain) id<PlayerDelegate> delegate;
@property (nonatomic, readonly) PlayerStatus status;

- (void)play;
- (void)pause;
- (void)refresh;

@end