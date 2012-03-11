//
//  TimetableInteractorTest
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test.h"


@interface TimetableInteractorTest : Test {

}

- (void)testRefreshShouldRetrieveData;

- (void)testShouldUpdateViewAfterReceivedData;

- (void)testShouldNotifyViewOnError;

- (void)testShouldSetDelegateOfDataRetriever;

- (void)testShouldSetDelegateOfView;

@end