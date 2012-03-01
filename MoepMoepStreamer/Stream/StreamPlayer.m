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

- (void)verifyIfPlayable;

@end

@implementation StreamPlayer

@synthesize delegate;
@dynamic streamUrl;

- (id)init {
    self = [super init];

    if (self) {
        player = [[AVPlayer alloc] init];
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
    [self.delegate playerStartedLoadingFromUrl:self.streamUrl];

    NSURL *url = [[NSURL alloc] initWithString:self.streamUrl];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    [player replaceCurrentItemWithPlayerItem:item];
    [self verifyIfPlayable];

    [item release];
    [url release];
}

- (void)play {
    AVAudioSession *session = [AVAudioSession sharedInstance];
    NSError *error = nil;

    if (![session setActive:YES error:&error]) {
        NSLog(@"Error: %@", error);
    }

    [player play];
}

- (void)pause {
    [player pause];

    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:NO error:nil];
}

- (void)verifyIfPlayable {
    NSArray *keys = [NSArray arrayWithObjects:@"playable", nil];
    [player.currentItem.asset loadValuesAsynchronouslyForKeys:keys completionHandler:^ {
        NSError *error = nil;
        AVKeyValueStatus status = [player.currentItem.asset statusOfValueForKey:@"playable" error:&error];
        
        if (status == AVKeyValueStatusLoaded && player.currentItem.asset.playable) {
            [self.delegate playerIsReadyToPlay];
        }
        else {
            [self.delegate playerFailedToLoadStream];
        }
    }];
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

@end