//
//  InteractorBase
//
//  Created by Daniel Czerwonk on 3/9/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "InteractorBase.h"


@implementation InteractorBase

- (void)executeInMainThread:(void (^)())block {
    if ([[NSThread currentThread] isMainThread]) {
        block();
        return;
    }
    
    dispatch_semaphore_t s = dispatch_semaphore_create(0);

    dispatch_async(dispatch_get_main_queue(), ^{
        block();
        dispatch_semaphore_signal(s);
    });

    dispatch_semaphore_wait(s, DISPATCH_TIME_FOREVER);
}

@end