//
//  SendeplanTableViewController
//
//  Created by Daniel Czerwonk on 3/1/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "SendeplanTableViewController.h"

@interface SendeplanTableViewController ()

- (void)scrollToCurrentWeekday;

@end

@implementation SendeplanTableViewController

@synthesize table;

static NSString *ShowCellIdentifier = @"ShowTableViewCell";
static int NumberDaysInWeek = 7;
static int CalendarSundayIndex = 1;
static int ArraySundayIndex = 6;

- (void)viewDidLoad {
    [super viewDidLoad];

    days = [[NSArray alloc] initWithObjects:@"Montag", @"Dienstag", @"Mittwoch", @"Donnerstag",
                                            @"Freitag", @"Samstag", @"Sonntag", nil];

    [table registerNib:[UINib nibWithNibName:@"ShowTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ShowCellIdentifier];
    [self scrollToCurrentWeekday];
}

- (void)scrollToCurrentWeekday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSWeekdayCalendarUnit fromDate:[NSDate date]];

    int weekdayIndex = components.weekday == CalendarSundayIndex ? ArraySundayIndex : components.weekday - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:weekdayIndex];
    [table scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return NumberDaysInWeek;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [days objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:ShowCellIdentifier];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)dealloc {
    [super dealloc];

    [days release];
}


@end