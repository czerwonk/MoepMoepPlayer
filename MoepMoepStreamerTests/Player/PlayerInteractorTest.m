//
//  PlayerInteractorTest
//
//  Created by Daniel Czerwonk on 3/9/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "PlayerInteractorTest.h"
#import "PlayerInteractor.h"


@implementation PlayerInteractorTest

- (void)testShouldSetDelegateOfView {
    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<PlayerView> view = [OCMockObject mockForProtocol:@protocol(PlayerView)];
    [[view expect] setViewDelegate:interactor];

    interactor.view = view;
    [self verifyMockExpectations:view];
}

- (void)testShouldSetDelegateOfDataRetriever {
    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<DataRetriever> retriever = [OCMockObject mockForProtocol:@protocol(DataRetriever)];
    [[retriever expect] setDelegate:interactor];

    interactor.streamListDataRetriever = retriever;
    [self verifyMockExpectations:retriever];
}

- (void)testShouldRetrieveDataOnReloadStreams {
    id<DataRetriever> retriever = [OCMockObject niceMockForProtocol:@protocol(DataRetriever)];
    [[retriever expect] retrieveDataAsynchronous];

    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];
    interactor.streamListDataRetriever = retriever;

    [interactor reloadStreams];

    [self verifyMockExpectations:retriever];
}

- (void)testShouldSetStreamsAfterRetrievingData {
    id<DataRetriever> retriever = [OCMockObject niceMockForProtocol:@protocol(DataRetriever)];

    NSArray *streams = [[[NSArray alloc] init] autorelease];

    id<PlayerView> view = [OCMockObject niceMockForProtocol:@protocol(PlayerView)];
    [[view expect] setStreams:streams];

    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];
    interactor.streamListDataRetriever = retriever;
    interactor.view = view;

    [interactor retriever:retriever retrievedData:streams];

    [self verifyMockExpectations:view];
}

- (void)testShouldNotifyViewOnError {
    id<DataRetriever> retriever = [OCMockObject niceMockForProtocol:@protocol(DataRetriever)];

    NSError *error = [[[NSError alloc] initWithDomain:@"Foo" code:0 userInfo:nil] autorelease];

    id<PlayerView> view = [OCMockObject niceMockForProtocol:@protocol(PlayerView)];
    [[view expect] showErrorWithMessage:error.localizedDescription];

    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];
    interactor.streamListDataRetriever = retriever;
    interactor.view = view;

    [interactor retriever:retriever failedRetrievingData:error];

    [self verifyMockExpectations:view];
}

@end