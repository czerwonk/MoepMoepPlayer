//
//  Test
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "Test.h"


@implementation Test

- (void)verifyMockExpectations:(id)mock {
    @try {
        [mock verify];
    }
    @catch (NSException *ex) {
        STFail(ex.reason);
    }
}

@end