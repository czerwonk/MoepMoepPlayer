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

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "PlayerDelegate.h"
#import "Channel.h"
#import "Player.h"
#import "PlayerView.h"
#import "BaseViewController.h"

@protocol PlayerViewDelegate;

@interface PlayerViewController : BaseViewController<PlayerView, UIPickerViewDataSource, UIPickerViewDelegate> {
    @private
    NSArray *channels;
    Channel *currentChannel;
}

@property (nonatomic, retain) IBOutlet UIButton *playButton;
@property (nonatomic, retain) IBOutlet UIActivityIndicatorView *playerActivityView;
@property (nonatomic, retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, retain) IBOutlet UIPickerView *pickerView;
@property (nonatomic, retain) IBOutlet UILabel *channelNameTextLabel;
@property (nonatomic, retain) id<PlayerViewDelegate> viewDelegate;

- (IBAction)playButtonClicked;
- (IBAction)refreshButtonClicked;

@end