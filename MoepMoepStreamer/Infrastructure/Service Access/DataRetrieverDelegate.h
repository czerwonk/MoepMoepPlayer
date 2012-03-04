//
//  DataRetrieverDelegate
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

@protocol DataRetriever;

@protocol DataRetrieverDelegate<NSObject>

- (void)retriever:(id<DataRetriever>)retriever retrievedData:(id)object;

- (void)retriever:(id<DataRetriever>)retriever failedRetrievingData:(NSError *)error;

@end