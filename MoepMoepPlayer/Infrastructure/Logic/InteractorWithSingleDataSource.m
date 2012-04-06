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

#import "InteractorWithSingleDataSource.h"
#import "DataRetriever.h"


@implementation InteractorWithSingleDataSource

- (id <ViewWithDataSource>)view {
    return view;
}

- (void)setView:(id <ViewWithDataSource>)aView {
    [view release];
    view = [aView retain];
    view.viewDelegate = self;
}

- (id <DataRetriever>)dataRetriever {
    return dataRetriever;
}

- (void)setDataRetriever:(id <DataRetriever>)aRetriever {
    [dataRetriever release];
    dataRetriever = [aRetriever retain];
    dataRetriever.delegate = self;
}

- (void)reloadDataSource {
    [dataRetriever retrieveDataAsynchronous];
}

- (void)retriever:(id <DataRetriever>)retriever retrievedData:(id)object {
    [self executeInMainThread:^{
        [view updateDataSource:object];
    }];
}

- (void)retriever:(id <DataRetriever>)retriever failedRetrievingData:(NSError *)error {
    [self executeInMainThread:^{
        [view showErrorWithMessage:error.localizedDescription];
    }];
}

- (void)dealloc {
    [super dealloc];

    [view release];
    [dataRetriever release];
}

@end