//
//  StreamPlayer
//
//  Created by Daniel Czerwonk on 2/29/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Player.h"


@interface StreamPlayer : NSObject<Player, AVAudioSessionDelegate> {
    @private
    NSString *streamUrl;
    AVPlayer *player;
    PlayerStatus status;
}

@end