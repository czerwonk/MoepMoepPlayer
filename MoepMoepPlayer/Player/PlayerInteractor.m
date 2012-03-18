//
//  PlayerInteractor
//
//  Created by Daniel Czerwonk on 3/8/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "PlayerInteractor.h"


@implementation PlayerInteractor

- (id<PlayerView>)view {
    return view;
}

- (void)setView:(id<PlayerView>)aView {
    [view release];
    view = [aView retain];

    [view setViewDelegate:self];
}

- (void)setPlayer:(id<Player>)aPlayer {
    [player release];
    player = [aPlayer retain];

    [player setDelegate:self];
}

- (id <Player>)player {
    return player;
}

- (void)playerChangedStatusTo:(PlayerStatus)status {
    [view playerChangedStatusTo:status];
}

- (id<DataRetriever>)channelListDataRetriever {
    return channelListDataRetriever;
}

- (void)setChannelListDataRetriever:(id<DataRetriever>)aChannelListDataRetriever {
    [channelListDataRetriever release];
    channelListDataRetriever = [aChannelListDataRetriever retain];

    [channelListDataRetriever setDelegate:self];
}

- (void)retriever:(id<DataRetriever>)retriever retrievedData:(id)object {
    if (retriever == channelListDataRetriever) {
        [self executeInMainThread:^{
            [view setChannels:(NSArray *)object];
        }];
    }
}

- (void)retriever:(id<DataRetriever>)retriever failedRetrievingData:(NSError *)error {
    if (retriever == channelListDataRetriever) {
        [self executeInMainThread:^{
            [view showErrorWithMessage:error.localizedDescription];
        }];
    }
}

- (void)reloadChannels {
    [self.channelListDataRetriever retrieveDataAsynchronous];
}

- (void)refreshPlayer {
    [player refresh];
}

- (void)playOrPause {
    if (player.status == PlayerStatusReady || player.status == PlayerStatusStopped) {
        [player play];
    }
    else {
        [player pause];
    }
}

- (void)switchToMainStream:(Channel *)channel {
    [player setStreamUrl:channel.mainStreamUrl];
}

- (void)switchToMobileStream:(Channel *)channel {
    [player setStreamUrl:channel.mobileStreamUrl];
}

- (void)dealloc {
    [super dealloc];

    [view release];
    [channelListDataRetriever release];
    [player release];
}

@end