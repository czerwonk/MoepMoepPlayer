//
//  ViewController.m
//  StreamTest
//
//  Created by Daniel Czerwonk on 02/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerViewController.h"

@interface PlayerViewController ()

- (void)playerStartedLoading;

- (void)playerIsReadyToPlay;

- (void)playerFailed;

- (void)playerStartedPlaying;

- (void)channelSwitched;

@end

@implementation PlayerViewController

@synthesize playButton;
@synthesize segmentedControl;
@synthesize pickerView;
@synthesize channelNameTextLabel;
@synthesize viewDelegate;
@synthesize playerActivityView;

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.segmentedControl addTarget:self
                              action:@selector(channelSwitched)
                    forControlEvents:UIControlEventValueChanged];

    self.pickerView.frame = CGRectMake(self.pickerView.frame.origin.x,
                                       self.pickerView.frame.origin.y + 8,
                                       self.pickerView.frame.size.width,
                                       162);

    [self startActivityViewWithText:NSLocalizedString(@"LoadingStreamList", nil)];
    [self.viewDelegate reloadChannels];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait
                || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;
}

- (IBAction)playButtonClicked {
    [viewDelegate playOrPause];
}

- (IBAction)refreshButtonClicked {
    [viewDelegate refreshPlayer];
}

- (void)playerChangedStatusTo:(PlayerStatus)status {
    switch (status) {
        case PlayerStatusLoading:
            [self playerStartedLoading];
            break;

        case PlayerStatusReady:
            [self playerIsReadyToPlay];
            break;

        case PlayerStatusFailed:
            [self playerFailed];
            break;

        case PlayerStatusPlaying:
            [self playerStartedPlaying];
            break;

        case PlayerStatusStopped:
            [self playerIsReadyToPlay];
            break;
            
        default:
            break;
    }
}

- (void)setChannels:(NSArray *)theChannels {
    [self stopActivityView];

    [channels release];
    channels = [[NSArray alloc] initWithArray:theChannels];

    if (channels.count > 0) {
        [currentChannel release];
        currentChannel = [[channels objectAtIndex:0] retain];

        [self channelSwitched];
        [self.pickerView reloadAllComponents];
    }
}

- (void)playerStartedLoading {
    [self.playerActivityView startAnimating];
    self.playButton.enabled = NO;
    [self.playButton setSelected:NO];
    [self.playButton setTitle:NSLocalizedString(@"Connect", nil) forState:UIControlStateDisabled];
}

- (void)playerIsReadyToPlay {
    [self.playerActivityView stopAnimating];
    self.playButton.enabled = YES;
    [self.playButton setSelected:NO];
    [self.playButton setTitle:NSLocalizedString(@"Play", nil) forState:UIControlStateNormal];
}

- (void)playerFailed {
    [self.playerActivityView stopAnimating];
    self.playButton.enabled = NO;
    [self.playButton setSelected:NO];
    [self.playButton setTitle:NSLocalizedString(@"Offline", nil) forState:UIControlStateDisabled];
}

- (void)playerStartedPlaying {
    self.playButton.enabled = YES;
    [self.playButton setSelected:YES];
    [self.playButton setTitle:NSLocalizedString(@"Stop", nil) forState:UIControlStateSelected];
}

- (void)channelSwitched {
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            [viewDelegate switchToMainStream:currentChannel];
            break;

        case 1:
            [viewDelegate switchToMobileStream:currentChannel];
            break;
    }

    self.channelNameTextLabel.text = currentChannel.name;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)picker {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)picker numberOfRowsInComponent:(NSInteger)component {
    return channels.count;
}

- (NSString *)pickerView:(UIPickerView *)picker titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Channel *stream = [channels objectAtIndex:row];
    return stream.name;
}

- (void)pickerView:(UIPickerView *)picker didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    Channel *channel = [channels objectAtIndex:row];
    [currentChannel release];
    currentChannel = [channel retain];
    self.channelNameTextLabel.text = currentChannel.name;

    [self channelSwitched];
}

- (void)dealloc {
    [super dealloc];

    [playButton release];
    [channels release];
    [currentChannel release];
    [channelNameTextLabel release];
    [pickerView release];
    [segmentedControl release];
    [playerActivityView release];
    [viewDelegate release];
}

@end