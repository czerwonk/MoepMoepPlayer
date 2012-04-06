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

#import "MainTabBarController.h"
#import "TimetableDeserializer.h"
#import "PlayerViewController.h"
#import "PlayerInteractor.h"
#import "HttpGetDataRetriever.h"
#import "ChannelListDeserializer.h"
#import "StreamPlayer.h"
#import "InteractorWithSingleDataSource.h"
#import "TweetsDeserializer.h"


@interface MainTabBarController ()

- (void)initializeTimetableView;

- (void)initializePlayerView;

- (void)initializeTweetsView;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initializePlayerView];
    [self initializeTimetableView];
    [self initializeTweetsView];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    if (self.selectedViewController == nil) {
        return UIInterfaceOrientationPortrait;
    }
    
    return [self.selectedViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)initializeTimetableView {
    TimetableTableViewController *timetableViewController = [self.viewControllers objectAtIndex:1];

    TimetableDeserializer *deserializer = [[TimetableDeserializer alloc] init];
    HttpGetDataRetriever *dataRetriever = [[HttpGetDataRetriever alloc] initWithUrl:@"https://www.moepmoep.org/streamerapp/sendeplan.txt"];
    dataRetriever.deserializer = deserializer;
    [deserializer release];

    InteractorWithSingleDataSource *interactor = [[InteractorWithSingleDataSource alloc] init];
    interactor.dataRetriever = dataRetriever;
    interactor.view = timetableViewController;
    [dataRetriever release];
    [interactor release];
}

- (void)initializePlayerView {
    PlayerViewController *controller = [self.viewControllers objectAtIndex:0];

    PlayerInteractor *interactor = [[PlayerInteractor alloc] init];
    interactor.view = controller;

    HttpGetDataRetriever *dataRetriever = [[HttpGetDataRetriever alloc] initWithUrl:@"https://www.moepmoep.org/streamerapp/api/0.3/channels/list.json"];
    ChannelListDeserializer *deserializer = [[ChannelListDeserializer alloc] init];
    dataRetriever.deserializer = deserializer;
    [deserializer release];

    interactor.channelListDataRetriever = dataRetriever;
    [dataRetriever release];

    StreamPlayer *player = [[StreamPlayer alloc] init];
    interactor.player = player;
    [player release];
    
    [interactor release];
}

- (void)initializeTweetsView {
    TimetableTableViewController *timetableViewController = [self.viewControllers objectAtIndex:3];

    TweetsDeserializer *deserializer = [[TweetsDeserializer alloc] init];
    NSString *url = @"https://search.twitter.com/search.json?q=from:moepmoeporg%20OR%20moepmoep%20OR%20%40moepmoeporg&rpp=20&include_entities=false&result_type=recent&max_id=0";
    HttpGetDataRetriever *dataRetriever = [[HttpGetDataRetriever alloc] initWithUrl:url];
    dataRetriever.deserializer = deserializer;
    [deserializer release];

    InteractorWithSingleDataSource *interactor = [[InteractorWithSingleDataSource alloc] init];
    interactor.dataRetriever = dataRetriever;
    interactor.view = timetableViewController;
    [dataRetriever release];
    [interactor release];
}

@end