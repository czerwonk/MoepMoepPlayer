//
//  StreamPlayer
//
//  Created by Daniel Czerwonk on 2/29/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <AudioToolbox/AudioToolbox.h>
#import "StreamPlayer.h"
#import "NotificationKeys.h"


@interface StreamPlayer ()

- (void)initializeAudioSession;

- (void)resetPlayer;

- (void)releasePlayer;

- (void)initializeApplicationStateObservation;

- (void)applicationWillBeSentToBackground;

- (void)applicationReturnedFromBackground;

@end

@implementation StreamPlayer

@synthesize delegate;
@dynamic streamUrl;
@synthesize status;

- (id)init {
    self = [super init];

    if (self) {
        [self initializeAudioSession];
        [self initializeApplicationStateObservation];
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

- (void)initializeApplicationStateObservation {
    [[NSNotificationCenter defaultCenter] addObserverForName:ApplicationWillBeSentToBackground
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *notification) {
                                                      [self applicationWillBeSentToBackground];
                                                  }];
    [[NSNotificationCenter defaultCenter] addObserverForName:ApplicationReturnedFromBackground
                                                      object:nil
                                                       queue:nil
                                                  usingBlock:^(NSNotification *notification) {
                                                      [self applicationReturnedFromBackground];
                                                  }];
}

- (NSString *)streamUrl {
    return streamUrl;
}

- (void)setStreamUrl:(NSString *)streamUrlString {
    streamUrl = streamUrlString;

    [self resetPlayer];
}

- (void)resetPlayer {
    if (self.streamUrl == nil) {
        return;
    }
    
    self.status = PlayerStatusLoading;
    [self.delegate playerStartedLoadingFromUrl:self.streamUrl];

    NSURL *url = [[NSURL alloc] initWithString:self.streamUrl];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    [url release];

    [self releasePlayer];
    player = [[AVPlayer alloc] initWithPlayerItem:item];
    [player addObserver:self forKeyPath:@"currentItem.status" options:0 context:NULL];
    [item release];
}

- (void)releasePlayer {
    [player removeObserver:self forKeyPath:@"currentItem.status"];
    [player release];
    player = nil;
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

- (void)beginInterruption {
    [player pause];
}

- (void)endInterruption {
    [self resetPlayer];
    [self play];
}

- (void)applicationWillBeSentToBackground {
    if (status != PlayerStatusPlaying) {
        [player release];
        player = nil;
        status = PlayerStandby;
    }
}

- (void)applicationReturnedFromBackground {
    if (status == PlayerStandby) {
        [self resetPlayer];
    }
}

- (void)dealloc {
    [super dealloc];

    [self releasePlayer];
    [streamUrl release];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end