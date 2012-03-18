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

    interactor.channelListDataRetriever = retriever;
    [self verifyMockExpectations:retriever];
}

- (void)testShouldRetrieveDataOnReloadChannels {
    id<DataRetriever> retriever = [OCMockObject niceMockForProtocol:@protocol(DataRetriever)];
    [[retriever expect] retrieveDataAsynchronous];

    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];
    interactor.channelListDataRetriever = retriever;

    [interactor reloadChannels];

    [self verifyMockExpectations:retriever];
}

- (void)testShouldSetChannelsAfterRetrievingData {
    id<DataRetriever> retriever = [OCMockObject niceMockForProtocol:@protocol(DataRetriever)];

    NSArray *channels = [[[NSArray alloc] init] autorelease];

    id<PlayerView> view = [OCMockObject niceMockForProtocol:@protocol(PlayerView)];
    [[view expect] setChannels:channels];

    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];
    interactor.channelListDataRetriever = retriever;
    interactor.view = view;

    [interactor retriever:retriever retrievedData:channels];

    [self verifyMockExpectations:view];
}

- (void)testShouldNotifyViewOnError {
    id<DataRetriever> retriever = [OCMockObject niceMockForProtocol:@protocol(DataRetriever)];

    NSError *error = [[[NSError alloc] initWithDomain:@"Foo" code:0 userInfo:nil] autorelease];

    id<PlayerView> view = [OCMockObject niceMockForProtocol:@protocol(PlayerView)];
    [[view expect] showErrorWithMessage:error.localizedDescription];

    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];
    interactor.channelListDataRetriever = retriever;
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
    Channel *channel = [[[Channel alloc] init] autorelease];
    channel.mobileStreamUrl = @"bar";

    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<Player> player = [OCMockObject niceMockForProtocol:@protocol(Player)];
    [[player expect] setStreamUrl:channel.mobileStreamUrl];
    interactor.player = player;

    [interactor switchToMobileStream:channel];

    [self verifyMockExpectations:player];
}

- (void)testShouldSetMainStreamUrlToPlayer {
    Channel *channel = [[[Channel alloc] init] autorelease];
    channel.mainStreamUrl = @"foo";

    PlayerInteractor *interactor = [[[PlayerInteractor alloc] init] autorelease];

    id<Player> player = [OCMockObject niceMockForProtocol:@protocol(Player)];
    [[player expect] setStreamUrl:channel.mainStreamUrl];
    interactor.player = player;

    [interactor switchToMainStream:channel];

    [self verifyMockExpectations:player];
}

@end