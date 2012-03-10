//
//  ChatViewController.m
//  MoepMoepStreamer
//
//  Created by Daniel Czerwonk on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
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
