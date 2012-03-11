//
//  InteractorBase
//
//  Created by Daniel Czerwonk on 3/9/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface InteractorBase : NSObject {

}

- (void)executeInMainThread:(void (^)())block;

@end