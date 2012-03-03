//
//  ViewController.h
//  StreamTest
//
//  Created by Daniel Czerwonk on 02/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PlayerDelegate.h"

@protocol Player;

@interface PlayerViewController : UIViewController<PlayerDelegate> {

    @private
    id<Player> player;
    BOOL isPlaying;
}

@property (nonatomic, retain) IBOutlet UIImageView *imageView;
@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;

- (IBAction)playButtonClicked;
- (IBAction)refreshButtonClicked;

@end