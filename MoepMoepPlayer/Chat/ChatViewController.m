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

#import "ChatViewController.h"

@interface ChatViewController ()

- (void)loadChat;

@end

@implementation ChatViewController

@synthesize webView;

- (void)viewDidLoad {
    [super viewDidLoad];

    self.webView.delegate = self;
    [self loadChat];
}

- (void)loadChat {
    NSURL *url = [[NSURL alloc] initWithString:@"http://widget.mibbit.com/?server=irc.prooops.eu&channel=%23moepmoep2%2C%23moepmoep&nick=moep_%3F%3F%3F%3F&autoConnect=true&charset=UTF-8&noServerMotd=true&noServerNotices=true"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [url release];

    [self.webView loadRequest:request];
    [request release];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self startActivityViewWithText:NSLocalizedString(@"Loading", nil)];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self stopActivityView];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self showErrorWithMessage:error.localizedDescription];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)dealloc {
    [webView release];

    [super dealloc];
}

@end
