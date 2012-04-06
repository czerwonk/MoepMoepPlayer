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

#import "InteractorWithSingleDataSourceTest.h"
#import "InteractorWithSingleDataSource.h"
#import "DataRetriever.h"


@implementation InteractorWithSingleDataSourceTest

- (void)testShouldSetDelegateOfView {
    InteractorWithSingleDataSource *interactor = [[[InteractorWithSingleDataSource alloc] init] autorelease];

    id<ViewWithDataSource> view = [OCMockObject mockForProtocol:@protocol(ViewWithDataSource)];
    [[view expect] setViewDelegate:interactor];

    interactor.view = view;

    [self verifyMockExpectations:view];
}

- (void)testShouldSetDelegateOfDataRetriever {
    InteractorWithSingleDataSource *interactor = [[[InteractorWithSingleDataSource alloc] init] autorelease];

    id<DataRetriever> retriever = [OCMockObject mockForProtocol:@protocol(DataRetriever)];
    [[retriever expect] setDelegate:interactor];

    interactor.dataRetriever = retriever;

    [self verifyMockExpectations:retriever];
}

- (void)testShouldNotifyViewOnError {
    NSError *error = [OCMockObject mockForClass:[NSError class]];
    [[[error stub] andReturn:@"Test"] localizedDescription];

    id<ViewWithDataSource> view = [OCMockObject niceMockForProtocol:@protocol(ViewWithDataSource)];
    [[view expect] showErrorWithMessage:error.localizedDescription];

    InteractorWithSingleDataSource *interactor = [[[InteractorWithSingleDataSource alloc] init] autorelease];
    interactor.view = view;

    [interactor retriever:nil failedRetrievingData:error];

    [self verifyMockExpectations:view];
}

- (void)testShouldUpdateDataSourceToViewAfterRetrieving {
    id<DataRetriever> retriever = [OCMockObject niceMockForProtocol:@protocol(DataRetriever)];

    NSArray *data = [[[NSArray alloc] init] autorelease];

    id<ViewWithDataSource> view = [OCMockObject niceMockForProtocol:@protocol(ViewWithDataSource)];
    [[view expect] updateDataSource:data];

    InteractorWithSingleDataSource *interactor = [[[InteractorWithSingleDataSource alloc] init] autorelease];
    interactor.dataRetriever = retriever;
    interactor.view = view;

    [interactor retriever:retriever retrievedData:data];

    [self verifyMockExpectations:view];
}

- (void)testShouldRetrieveDataOnReload {
    id<DataRetriever> retriever = [OCMockObject niceMockForProtocol:@protocol(DataRetriever)];
    [[retriever expect] retrieveDataAsynchronous];

    InteractorWithSingleDataSource *interactor = [[[InteractorWithSingleDataSource alloc] init] autorelease];
    interactor.dataRetriever = retriever;

    [interactor reloadDataSource];

    [self verifyMockExpectations:retriever];
}

@end