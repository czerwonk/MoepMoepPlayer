//
//  MoepMoepPlayer
//
//  Copyright (C) 2012, Daniel Czerwonk
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>
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