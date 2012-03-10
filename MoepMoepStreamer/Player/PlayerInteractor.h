//
//  PlayerInteractor
//
//  Created by Daniel Czerwonk on 3/8/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataRetriever.h"
#import "Player.h"
#import "PlayerViewDelegate.h"
#import "PlayerView.h"
#import "InteractorBase.h"


@interface PlayerInteractor : InteractorBase<PlayerViewDelegate, DataRetrieverDelegate> {
    @private
    id<PlayerView> view;
    id<DataRetriever> streamListDataRetriever;
}

@property (nonatomic, retain) id<PlayerView> view;
@property (nonatomic, retain) id<DataRetriever> streamListDataRetriever;
//@property (nonatomic, retain) id<Player> player;

@end