//
//  MainViewController
//
//  Created by Daniel Czerwonk on 3/3/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "MainTabBarController.h"
#import "TimetableInteractor.h"
#import "TimetableDeserializer.h"
#import "PlayerViewController.h"
#import "PlayerInteractor.h"
#import "HttpGetDataRetriever.h"
#import "ChannelListDeserializer.h"
#import "StreamPlayer.h"


@interface MainTabBarController ()

- (void)initializeTimetableView;

- (void)initializePlayerView;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initializePlayerView];
    [self initializeTimetableView];
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
    HttpGetDataRetriever *dataRetriever = [[HttpGetDataRetriever alloc] initWithUrl:@"http://www.moepmoep.org/streamerapp/sendeplan.txt"];
    dataRetriever.deserializer = deserializer;
    [deserializer release];

    TimetableInteractor *interactor = [[TimetableInteractor alloc] initWithDataRetriever:dataRetriever];
    interactor.view = timetableViewController;
    [dataRetriever release];
    [interactor release];
}

- (void)initializePlayerView {
    PlayerViewController *controller = [self.viewControllers objectAtIndex:0];

    PlayerInteractor *interactor = [[PlayerInteractor alloc] init];
    interactor.view = controller;

    HttpGetDataRetriever *dataRetriever = [[HttpGetDataRetriever alloc] initWithUrl:@"http://www.moepmoep.org/streamerapp/streams.json"];
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

@end