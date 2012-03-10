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

- (id<DataRetriever>)streamListDataRetriever {
    return streamListDataRetriever;
}

- (void)setStreamListDataRetriever:(id<DataRetriever>)aStreamListDataRetriever {
    [streamListDataRetriever release];
    streamListDataRetriever = [aStreamListDataRetriever retain];

    [streamListDataRetriever setDelegate:self];
}

- (void)retriever:(id<DataRetriever>)retriever retrievedData:(id)object {
    if (retriever == streamListDataRetriever) {
        [self executeInMainThread:^{
            [view setStreams:(NSArray *)object];
        }];
    }
}

- (void)retriever:(id<DataRetriever>)retriever failedRetrievingData:(NSError *)error {
    if (retriever == streamListDataRetriever) {
        [self executeInMainThread:^{
            [view showErrorWithMessage:error.localizedDescription];
        }];
    }
}

- (void)reloadStreams {
    [self.streamListDataRetriever retrieveDataAsynchronous];
}

- (void)dealloc {
    [super dealloc];

    [view release];
    [streamListDataRetriever release];
}

@end