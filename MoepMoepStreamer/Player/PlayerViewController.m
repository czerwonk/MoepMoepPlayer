//
//  ViewController.m
//  StreamTest
//
//  Created by Daniel Czerwonk on 02/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerViewController.h"
#import "StreamPlayer.h"
#import "PlayerViewDelegate.h"

@interface PlayerViewController ()

- (void)playerStartedLoading;

- (void)playerIsReadyToPlay;

- (void)playerFailed;

- (void)playerStartedPlaying;

- (void)streamSwitched;

@end

@implementation PlayerViewController

@synthesize playButton;
@synthesize segmentedControl;
@synthesize pickerView;
@synthesize streamTextLabel;
@synthesize viewDelegate;
@synthesize playerActivityView;

- (void)viewDidLoad {
    [super viewDidLoad];

    player = [[StreamPlayer alloc] init];
    player.delegate = self;

    [self.segmentedControl addTarget:self
                              action:@selector(streamSwitched)
                    forControlEvents:UIControlEventValueChanged];

    self.pickerView.frame = CGRectMake(self.pickerView.frame.origin.x,
                                       self.pickerView.frame.origin.y + 8,
                                       self.pickerView.frame.size.width,
                                       162);

    [self startActivityViewWithText:NSLocalizedString(@"LoadingStreamList", nil)];
    [self.viewDelegate reloadStreams];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return interfaceOrientation == UIInterfaceOrientationPortrait
                || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown;
}

- (IBAction)playButtonClicked {
    if (isPlaying) {
        [player pause];
    } else {
        [player play];
    }
}

- (IBAction)refreshButtonClicked {
    [player refresh];
}

- (void)playerChangedStatusTo:(PlayerStatus)status {
    isPlaying = status == PlayerStatusPlaying;

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

- (void)setStreams:(NSArray *)retrievedStreams {
    [self stopActivityView];

    [streams release];
    streams = [[NSArray alloc] initWithArray:retrievedStreams];

    if (streams.count > 0) {
        [currentStream release];
        currentStream = [[streams objectAtIndex:0] retain];

        [self streamSwitched];
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

- (void)streamSwitched {
    switch (self.segmentedControl.selectedSegmentIndex) {
        case 0:
            player.streamUrl = currentStream.mainStreamUrl;
            break;

        case 1:
            player.streamUrl = currentStream.mobileStreamUrl;
            break;
    }

    self.streamTextLabel.text = currentStream.name;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return streams.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    Stream *stream = [streams objectAtIndex:row];
    return stream.name;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    Stream *stream = [streams objectAtIndex:row];
    [currentStream release];
    currentStream = [stream retain];
    self.streamTextLabel.text = currentStream.name;

    [self streamSwitched];
}

- (void)dealloc {
    [super dealloc];

    [playButton release];
    [player release];
    [streams release];
    [currentStream release];
    [streamTextLabel release];
    [pickerView release];
    [segmentedControl release];
    [playerActivityView release];
    [viewDelegate release];
}

@end