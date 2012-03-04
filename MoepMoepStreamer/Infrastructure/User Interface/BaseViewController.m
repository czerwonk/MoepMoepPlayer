//
//  BaseViewController
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "BaseViewController.h"


@interface BaseViewController ()

- (void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message;

@end

@implementation BaseViewController

@synthesize activityView;

- (void)showErrorWithMessage:(NSString *)message {
    [self.activityView stopAnimating];
    [self showAlertViewWithTitle:NSLocalizedString(@"Error", @"Error") andMessage:message];
}

- (void)showInfoWithMessage:(NSString *)message {
    [self.activityView stopAnimating];
    [self showAlertViewWithTitle:NSLocalizedString(@"Info", @"Info") andMessage:message];
}

- (void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message
                                                       delegate:nil cancelButtonTitle:nil
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

@end