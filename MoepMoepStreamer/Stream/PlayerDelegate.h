//
//  PlayerDelegate
//
//  Created by Daniel Czerwonk on 2/29/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

@protocol PlayerDelegate

- (void)playerStartedLoadingFromUrl:(NSString *)streamUrl;
- (void)playerIsReadyToPlay;
- (void)playerFailedToLoadStream;

@end