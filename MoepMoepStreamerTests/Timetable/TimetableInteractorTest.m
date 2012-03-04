//
//  TimetableInteractorTest
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "TimetableInteractorTest.h"
#import "TimetableInteractor.h"
#import "Timetable.h"

@implementation TimetableInteractorTest

- (void)testRefreshShouldRetrieveData {
    id<DataRetriever> dataRetriever = [OCMockObject mockForProtocol:@protocol(DataRetriever)];
    [[dataRetriever expect] retrieveDataAsynchronous];
    [[dataRetriever stub] setDelegate:[OCMArg any]];

    TimetableInteractor *interactor = [[[TimetableInteractor alloc] init] autorelease];
    interactor.dataRetriever = dataRetriever;
    [interactor refresh];

    [self verifyMockExpectations:dataRetriever];
}

- (void)testShouldUpdateViewAfterReceivedData {
    Timetable *timetable = [[[Timetable alloc] init] autorelease];

    id<TimetableView> view = [OCMockObject mockForProtocol:@protocol(TimetableView)];
    [[view expect] setTimetable:timetable];
    [[view stub] setViewDelegate:[OCMArg any]];

    TimetableInteractor *interactor = [[[TimetableInteractor alloc] init] autorelease];
    interactor.view = view;
    [interactor retriever:nil retrievedData:timetable];

    [self verifyMockExpectations:view];
}

- (void)testShouldNotifyViewOnError {
    NSError *error = [OCMockObject mockForClass:[NSError class]];
    [[[error stub] andReturn:@"Test"] localizedDescription];

    id<TimetableView> view = [OCMockObject mockForProtocol:@protocol(TimetableView)];
    [[view expect] showErrorWithMessage:error.localizedDescription];
    [[view stub] setViewDelegate:[OCMArg any]];

    TimetableInteractor *interactor = [[[TimetableInteractor alloc] init] autorelease];
    interactor.view = view;

    [interactor retriever:nil failedRetrievingData:error];

    [self verifyMockExpectations:view];
}

- (void)testShouldSetDelegateOfDataRetriever {
    TimetableInteractor *interactor = [[[TimetableInteractor alloc] init] autorelease];

    id<DataRetriever> dataRetriever = [OCMockObject mockForProtocol:@protocol(DataRetriever)];
    [[dataRetriever expect] setDelegate:interactor];

    interactor.dataRetriever = dataRetriever;

    [self verifyMockExpectations:dataRetriever];
}

- (void)testShouldSetDelegateOfView {
    TimetableInteractor *interactor = [[[TimetableInteractor alloc] init] autorelease];

    id<TimetableView> view = [OCMockObject mockForProtocol:@protocol(TimetableView)];
    [[view expect] setViewDelegate:interactor];

    interactor.view = view;

    [self verifyMockExpectations:view];
}

@end