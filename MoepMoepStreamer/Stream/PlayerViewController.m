//
//  ViewController.m
//  StreamTest
//
//  Created by Daniel Czerwonk on 02/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerViewController.h"
#import "StreamPlayer.h"

@interface PlayerViewController ()

- (void)playerStartedLoading;

- (void)playerIsReadyToPlay;

- (void)playerFailed;

- (void)playerStartedPlaying;

- (void)playerStoppedPlaying;

- (void)streamSwitched;

@end

@implementation PlayerViewController

@synthesize playButton;
@synthesize activityView;
@synthesize segmentedControl;
@synthesize pickerView;
@synthesize streamTextLabel;

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
    
    Stream *moep1 = [[Stream alloc] init];
    moep1.name = @"#moep1";
    moep1.mainStreamUrl = @"http://radio.moepmoep.org:8000/stream.mp3";
    moep1.mobileStreamUrl = @"http://relay.moepmoep.org:9000/stream2.mp3";

    Stream *moep2 = [[Stream alloc] init];
    moep2.name = @"#moep2";
    moep2.mainStreamUrl = @"http://radio.moepmoep.org:9500/stream4.mp3";
    moep2.mobileStreamUrl = @"http://relay.moepmoep.org:8500/stream5.mp3";

    streams = [[NSArray alloc] initWithObjects:moep1, moep2, nil];
    currentStream = moep1;
    self.streamTextLabel.text = currentStream.name;
    [self streamSwitched];

    [moep2 release];
    [self streamSwitched];
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
            [self playerStoppedPlaying];
            break;
    }
}

- (void)playerStartedLoading {
    [self.activityView startAnimating];
    self.playButton.enabled = NO;
    self.playButton.titleLabel.frame = self.playButton.frame;
    self.playButton.titleLabel.textAlignment = UITextAlignmentCenter;
    self.playButton.titleLabel.text = NSLocalizedString(@"Connect", @"Verbinde...");
}

- (void)playerIsReadyToPlay {
    [self.activityView stopAnimating];
    self.playButton.enabled = YES;
}

- (void)playerFailed {
    [self.activityView stopAnimating];
    self.playButton.enabled = NO;
    self.playButton.titleLabel.frame = self.playButton.frame;
    self.playButton.titleLabel.textAlignment = UITextAlignmentCenter;
    self.playButton.titleLabel.text = NSLocalizedString(@"Offline", @"Offline");
}

- (void)playerStartedPlaying {
    [self.playButton setSelected:YES];
}

- (void)playerStoppedPlaying {
    [self.playButton setSelected:NO];
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
    [activityView release];
}

@end