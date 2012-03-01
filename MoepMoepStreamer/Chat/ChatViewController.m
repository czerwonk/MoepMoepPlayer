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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];

    if (self) {

    }

    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self loadChat];
}

- (void)loadChat {
    NSURL *url = [[NSURL alloc] initWithString:@"http://widget.mibbit.com/?server=irc.prooops.eu&channel=%23moepmoep2%2C%23moepmoep&nick=ircgast_%3F%3F%3F%3F&autoConnect=true&charset=UTF-8&customprompt=Willkommen%20auf%20prooops%2C%20viel%20Spa%C3%9F%20mit%20moepmoep.org&customloading=moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20moep%20&noServerMotd=true&noServerNotices=true"];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [url release];

    [self.webView loadRequest:request];
    [request release];
}

@end
