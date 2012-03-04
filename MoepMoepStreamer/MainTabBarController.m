//
//  MainViewController
//
//  Created by Daniel Czerwonk on 3/3/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "MainTabBarController.h"
#import "TimetableDataRetriever.h"
#import "TimetableInteractor.h"
#import "TimetableDeserializer.h"


@interface MainTabBarController ()

- (void)initializeTimetableView;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

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
    TimetableDataRetriever *dataRetriever = [[TimetableDataRetriever alloc] init];
    dataRetriever.deserializer = deserializer;
    [deserializer release];

    TimetableInteractor *interactor = [[TimetableInteractor alloc] initWithDataRetriever:dataRetriever];
    interactor.view = timetableViewController;
    [dataRetriever release];

    timetableViewController.viewDelegate = interactor;
    [interactor release];
}

- (void)dealloc {
    [super dealloc];
}


@end