//
//  PlayerInteractorTest
//
//  Created by Daniel Czerwonk on 3/9/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
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

- (void)testShouldSetDelegateOfPlayer {
    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<Player> player = [OCMockObject mockForProtocol:@protocol(Player)];
    [[player expect] setDelegate:interactor];

    interactor.player = player;

    [self verifyMockExpectations:player];
}

- (void)testShouldNotifyViewOnPlayerStateChange {
    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<PlayerView> view = [OCMockObject niceMockForProtocol:@protocol(PlayerView)];
    [[view expect] playerChangedStatusTo:PlayerStatusReady];
    interactor.view = view;
    
    [interactor playerChangedStatusTo:PlayerStatusReady];

    [self verifyMockExpectations:view];
}

- (void)testShouldRefreshPlayer {
    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<Player> player = [OCMockObject niceMockForProtocol:@protocol(Player)];
    [[player expect] refresh];
    interactor.player = player;

    [interactor refreshPlayer];

    [self verifyMockExpectations:player];
}

- (void)testShouldPausePlayerIfPlaying {
    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<Player> player = [OCMockObject niceMockForProtocol:@protocol(Player)];
    [[player expect] pause];
    PlayerStatus status = PlayerStatusPlaying;
    [[[player stub] andReturnValue:OCMOCK_VALUE(status)] status];
    interactor.player = player;

    [interactor playOrPause];

    [self verifyMockExpectations:player];
}

- (void)testShouldStartPlayerIfStopped {
    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<Player> player = [OCMockObject niceMockForProtocol:@protocol(Player)];
    [[player expect] play];
    PlayerStatus status = PlayerStatusStopped;
    [[[player stub] andReturnValue:OCMOCK_VALUE(status)] status];
    interactor.player = player;

    [interactor playOrPause];

    [self verifyMockExpectations:player];
}

- (void)testShouldStartPlayerIfReady {
    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<Player> player = [OCMockObject niceMockForProtocol:@protocol(Player)];
    [[player expect] play];
    PlayerStatus status = PlayerStatusReady;
    [[[player stub] andReturnValue:OCMOCK_VALUE(status)] status];
    interactor.player = player;

    [interactor playOrPause];

    [self verifyMockExpectations:player];
}

- (void)testShouldSetMobileStreamUrlToPlayer {
    Stream *stream = [[[Stream alloc] init] autorelease];
    stream.mobileStreamUrl = @"bar";

    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<Player> player = [OCMockObject niceMockForProtocol:@protocol(Player)];
    [[player expect] setStreamUrl:stream.mobileStreamUrl];
    interactor.player = player;

    [interactor switchToMobileStream:stream];

    [self verifyMockExpectations:player];
}

- (void)testShouldSetMainStreamUrlToPlayer {
    Stream *stream = [[[Stream alloc] init] autorelease];
    stream.mainStreamUrl = @"foo";

    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<Player> player = [OCMockObject niceMockForProtocol:@protocol(Player)];
    [[player expect] setStreamUrl:stream.mainStreamUrl];
    interactor.player = player;

    [interactor switchToMainStream:stream];

    [self verifyMockExpectations:player];
}

@end