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

- (void)viewDidLoad {
    [super viewDidLoad];

    activityAlertView = [[UIAlertView alloc] init];

    UIActivityIndicatorView *activityIndicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.frame = CGRectMake(125, 50,
                                             activityIndicatorView.frame.size.width, activityIndicatorView.frame.size.height);

    [activityIndicatorView startAnimating];
    [activityAlertView addSubview:activityIndicatorView];
    [activityIndicatorView release];
}

- (void)showErrorWithMessage:(NSString *)message {
    [self stopActivityView];
    [self showAlertViewWithTitle:NSLocalizedString(@"Error", @"Error") andMessage:message];
}

- (void)showInfoWithMessage:(NSString *)message {
    [self stopActivityView];
    [self showAlertViewWithTitle:NSLocalizedString(@"Info", @"Info") andMessage:message];
}

- (void)showAlertViewWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message
                                                       delegate:nil cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
    [alertView show];
    [alertView release];
}

- (void)startActivityViewWithText:(NSString *)text {
    activityAlertView.message = text;
    [activityAlertView show];
}

- (void)stopActivityView {
    [activityAlertView dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)dealloc {
    [super dealloc];

    [activityAlertView release];
}

@end