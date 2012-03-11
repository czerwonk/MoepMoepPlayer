//
//  HttpGetDataRetriever
//
//  Created by Daniel Czerwonk on 3/9/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataRetriever.h"


@interface HttpGetDataRetriever : NSObject<DataRetriever> {
    @private
    NSURL *url;
}

- (id)initWithUrl:(NSString *)url;

@end