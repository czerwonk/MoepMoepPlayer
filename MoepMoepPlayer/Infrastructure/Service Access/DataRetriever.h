//
//  WebRequestDispatcher
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deserializer.h"
#import "DataRetrieverDelegate.h"

@protocol DataRetriever<NSObject>

@property (nonatomic, retain) id<Deserializer> deserializer;
@property (nonatomic, retain) id<DataRetrieverDelegate> delegate;

- (void)retrieveDataAsynchronous;

@end