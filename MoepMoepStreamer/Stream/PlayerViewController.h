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
#import "Stream.h"
#import "Player.h"

@interface PlayerViewController : UIViewController<PlayerDelegate, UIPickerViewDataSource, UIPickerViewDelegate> {

    @private
    id<Player> player;
    BOOL isPlaying;
    NSArray *streams;
    Stream *currentStream;
}

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *activityView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) IBOutlet UILabel *streamTextLabel;

- (IBAction)playButtonClicked;
- (IBAction)refreshButtonClicked;

@end