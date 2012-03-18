//
//  MoepMoepPlayer
//
//  Copyright (C) 2012, Daniel Czerwonk
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>
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