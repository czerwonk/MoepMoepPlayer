//
//  ChatViewController.h
//  MoepMoepStreamer
//
//  Created by Daniel Czerwonk on 2/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface ChatViewController : BaseViewController<UIWebViewDelegate>

@property (nonatomic, retain) IBOutlet UIWebView *webView;

@end
