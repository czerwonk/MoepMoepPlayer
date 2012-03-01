//
//  ViewController.m
//  StreamTest
//
//  Created by Daniel Czerwonk on 02/28/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "Player.h"
#import "StreamPlayer.h"

@interface ViewController ()

- (void)downloadImage;

- (void)startPlaying;

- (void)stopPlaying;

@end

@implementation ViewController

@synthesize imageView;
@synthesize playButton;
@synthesize activityView;

- (void)viewDidLoad {
    [super viewDidLoad];

    player = [[StreamPlayer alloc] init];
    player.streamUrl = @"http://radio.moepmoep.org:8000/stream.mp3";
    player.delegate = self;

    [self downloadImage];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)playButtonClicked {
    if (isPlaying) {
        [self stopPlaying];
    } else {
        [self startPlaying];
    }
}

- (IBAction)refreshButtonClicked {
    [self stopPlaying];
    [player refresh];
}

- (void)downloadImage {
    NSURL *url = [[NSURL alloc] initWithString:@"http://www.moepmoep.org/images/show_datensuppe.jpg"];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    [url release];

    UIImage *image = [[UIImage alloc] initWithData:data];
    [data release];
    self.imageView.image = image;
    [image release];
}

- (void)startPlaying {
    [player play];
    isPlaying = YES;
    [self.playButton setSelected:YES];
}

- (void)stopPlaying {
    [player pause];
    isPlaying = NO;
    [self.playButton setSelected:NO];
}

- (void)dealloc {
    [super dealloc];

    [imageView release];
    [playButton release];
    [player release];
}

- (void)playerStartedLoadingFromUrl:(NSString *)streamUrl {
    [self.activityView startAnimating];
    self.playButton.enabled = NO;
    self.playButton.titleLabel.textAlignment = UITextAlignmentCenter;
    self.playButton.titleLabel.text = @"Verbinde...";
}

- (void)playerIsReadyToPlay {
    [self.activityView stopAnimating];
    self.playButton.enabled = YES;
}

- (void)playerFailedToLoadStream {
    [self.activityView stopAnimating];
    self.playButton.enabled = NO;
    self.playButton.titleLabel.textAlignment = UITextAlignmentCenter;
    self.playButton.titleLabel.text = @"Fail";
}

@end