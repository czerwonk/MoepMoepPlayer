//
//  SendeplanInteractor
//
//  Created by Daniel Czerwonk on 3/3/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TimetableView.h"
#import "TimetableViewDelegate.h"
#import "DataRetriever.h"


@interface TimetableInteractor : NSObject<TimetableViewDelegate, DataRetrieverDelegate> {
    @private
    id<DataRetriever> dataRetriever;
    id<TimetableView> view;
}

@property (nonatomic, retain) id<TimetableView> view;
@property (nonatomic, retain) id<DataRetriever> dataRetriever;

- (id)initWithDataRetriever:(id<DataRetriever>)retriever;

@end