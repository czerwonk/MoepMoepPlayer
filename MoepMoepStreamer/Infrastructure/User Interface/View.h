//
//  View
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

@protocol View<NSObject>

- (void)showErrorWithMessage:(NSString *)message;

- (void)showInfoWithMessage:(NSString *)message;

@end