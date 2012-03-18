//
//  PlayerInteractorTest
//
//  Created by Daniel Czerwonk on 3/9/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test.h"


@interface PlayerInteractorTest : Test {

}

- (void)testShouldSetDelegateOfView;

- (void)testShouldSetDelegateOfDataRetriever;

- (void)testShouldRetrieveDataOnReloadChannels;

- (void)testShouldSetChannelsAfterRetrievingData;

- (void)testShouldNotifyViewOnError;

- (void)testShouldSetDelegateOfPlayer;

- (void)testShouldRefreshPlayer;

- (void)testShouldStartPlayerIfStopped;

- (void)testShouldStartPlayerIfReady;

- (void)testShouldSetMobileStreamUrlToPlayer;

- (void)testShouldSetMainStreamUrlToPlayer;

@end