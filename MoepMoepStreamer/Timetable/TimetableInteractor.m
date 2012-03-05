//
//  SendeplanInteractor
//
//  Created by Daniel Czerwonk on 3/3/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "TimetableInteractor.h"
#import "Timetable.h"


@interface TimetableInteractor ()

- (void)runSyncInMainThread:(void (^)(void))block;

@end

@implementation TimetableInteractor

@dynamic view;
@dynamic dataRetriever;

- (id)initWithDataRetriever:(id<DataRetriever>)retriever {
    self = [super init];
    
    if (self) {
        self.dataRetriever = retriever;
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
        [self runSyncInMainThread:^{
            [view setTimetable:(Timetable *)object];
        }];
    }
}

- (void)retriever:(id<DataRetriever>)retriever failedRetrievingData:(NSError *)error {
    if (retriever == self.dataRetriever) {
        [self runSyncInMainThread:^{
            [view showErrorWithMessage:error.localizedDescription];
        }];
    }
}

- (void)runSyncInMainThread:(void (^)(void))block {
    dispatch_semaphore_t s = dispatch_semaphore_create(0);

    dispatch_async(dispatch_get_main_queue(), ^{
        block();
        dispatch_semaphore_signal(s);
    });

    dispatch_semaphore_wait(s, DISPATCH_TIME_FOREVER);
}

- (void)dealloc {
    [super dealloc];

    [dataRetriever release];
    [view release];
}

@end