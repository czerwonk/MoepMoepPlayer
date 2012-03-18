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