//
//  BaseViewController
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "View.h"


@interface BaseViewController : UIViewController<View> {
    UIAlertView *activityAlertView;
}

- (void)startActivityViewWithText:(NSString *)text;
- (void)stopActivityView;

@end