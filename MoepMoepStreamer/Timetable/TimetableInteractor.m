//
//  SendeplanInteractor
//
//  Created by Daniel Czerwonk on 3/3/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "TimetableInteractor.h"
#import "Timetable.h"


@implementation TimetableInteractor

@dynamic view;
@dynamic dataRetriever;

- (id)initWithDataRetriever:(id<DataRetriever>)retriever {
    self = [super init];
    
    if (self) {
        self.dataRetriever = [retriever retain];
    }

    return self;
}

- (id<TimetableView>)view {
    return view;
}

- (void)setView:(id<TimetableView>)aView {
    [view release];
    view = [aView retain];
    view.viewDelegate = self;
}

- (id<DataRetriever>)dataRetriever {
    return dataRetriever;
}

- (void)setDataRetriever:(id<DataRetriever>)retriever {
    [dataRetriever release];
    dataRetriever = [retriever retain];
    dataRetriever.delegate = self;
}

- (void)refreshTimetable {
    [self.dataRetriever retrieveDataAsynchronous];
}

- (void)retriever:(id<DataRetriever>)retriever retrievedData:(id)object {
    if (retriever == self.dataRetriever) {
        [self executeInMainThread:^{
            [view setTimetable:(Timetable *)object];
        }];
    }
}

- (void)retriever:(id<DataRetriever>)retriever failedRetrievingData:(NSError *)error {
    if (retriever == self.dataRetriever) {
        [self executeInMainThread:^{
            [view showErrorWithMessage:error.localizedDescription];
        }];
    }
}

- (void)dealloc {
    [super dealloc];

    [dataRetriever release];
    [view release];
}

@end