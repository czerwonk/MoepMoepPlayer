//
//  StreamPlayer
//
//  Created by Daniel Czerwonk on 2/29/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "StreamPlayer.h"


@interface StreamPlayer ()

- (void)initializeAudioSession;

- (void)resetPlayer;

@end

@implementation StreamPlayer

@synthesize delegate;
@dynamic streamUrl;
@synthesize status;

- (id)init {
    self = [super init];

    if (self) {
        player = [[AVPlayer alloc] init];
        [player addObserver:self forKeyPath:@"currentItem.status" options:0 context:NULL];

        [self initializeAudioSession];
    }

    return self;
}

- (void)initializeAudioSession {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setDelegate:self];

    UInt32 doChangeDefaultRoute = 1;
    AudioSessionSetProperty(kAudioSessionProperty_OverrideCategoryDefaultToSpeaker, sizeof(doChangeDefaultRoute), &doChangeDefaultRoute);

    NSError *error = nil;

    if (![session setCategory:AVAudioSessionCategoryPlayback error:&error]) {
        NSLog(@"Error: %@", error);
    }
}

- (NSString *)streamUrl {
    return streamUrl;
}

- (void)setStreamUrl:(NSString *)streamUrlString {
    streamUrl = streamUrlString;

    [self resetPlayer];
}

- (void)resetPlayer {
    self.status = PlayerStatusLoading;
    [self.delegate playerStartedLoadingFromUrl:self.streamUrl];

    NSURL *url = [[NSURL alloc] initWithString:self.streamUrl];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    [url release];

    [player replaceCurrentItemWithPlayerItem:item];
    [item release];
}

- (void)play {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error = nil;

    if (![session setActive:YES error:&error]) {
        NSLog(@"Error: %@", error);
    }

    [player play];
    self.status = PlayerStatusPlaying;
}

- (void)pause {
    self.status = PlayerStatusStopped;
    [player pause];

    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
}

- (void)dealloc {
    [super dealloc];

    [player release];
    [streamUrl release];
}

- (void)beginInterruption {
    [player pause];
}

- (void)endInterruption {
    [self resetPlayer];
    [self play];
}

- (void)refresh {
    [self resetPlayer];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object
                        change:(NSDictionary *)change context:(void *)context {
    if (player.currentItem.status == AVPlayerItemStatusReadyToPlay && player.currentItem.asset.playable) {
        self.status = PlayerStatusReady;
        [self.delegate playerIsReadyToPlay];
    }
    else if (player.currentItem.status == AVPlayerItemStatusFailed) {
        self.status = PlayerStatusStopped;
        [self.delegate playerFailed];
    }
}

@end