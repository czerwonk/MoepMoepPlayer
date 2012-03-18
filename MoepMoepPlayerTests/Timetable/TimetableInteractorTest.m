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

#import "TimetableInteractorTest.h"
#import "TimetableInteractor.h"
#import "Timetable.h"

@implementation TimetableInteractorTest

- (void)testRefreshShouldRetrieveData {
    id<DataRetriever> dataRetriever = [OCMockObject niceMockForProtocol:@protocol(DataRetriever)];
    [[dataRetriever expect] retrieveDataAsynchronous];

    TimetableInteractor *interactor = [[[TimetableInteractor alloc] init] autorelease];
    interactor.dataRetriever = dataRetriever;
    [interactor refreshTimetable];

    [self verifyMockExpectations:dataRetriever];
}

- (void)testShouldUpdateViewAfterReceivedData {
    Timetable *timetable = [[[Timetable alloc] init] autorelease];

    id<TimetableView> view = [OCMockObject niceMockForProtocol:@protocol(TimetableView)];
    [[view expect] setTimetable:timetable];

    TimetableInteractor *interactor = [[[TimetableInteractor alloc] init] autorelease];
    interactor.view = view;
    [interactor retriever:nil retrievedData:timetable];

    [self verifyMockExpectations:view];
}

- (void)testShouldNotifyViewOnError {
    NSError *error = [OCMockObject mockForClass:[NSError class]];
    [[[error stub] andReturn:@"Test"] localizedDescription];

    id<TimetableView> view = [OCMockObject niceMockForProtocol:@protocol(TimetableView)];
    [[view expect] showErrorWithMessage:error.localizedDescription];

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