//
//  SendeplanTableViewController
//
//  Created by Daniel Czerwonk on 3/1/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "TimetableTableViewController.h"
#import "Show.h"
#import "ShowTableViewCell.h"
#import "Timetable.h"

@interface TimetableTableViewController ()

- (void)refreshTimetable;

- (void)updateTableWithTimetable:(Timetable *)timetable;

- (NSMutableArray *)arrayForWeekday:(Weekday)weekday;

- (void)addShow:(Show *)show;

- (void)scrollToCurrentWeekday;

@end

@implementation TimetableTableViewController

@synthesize table;
@synthesize viewDelegate;

static NSString *ShowCellIdentifier = @"ShowTableViewCell";
static int NumberDaysInWeek = 7;
static int CalendarSundayIndex = 1;
static int ArraySundayIndex = 6;

- (void)viewDidLoad {
    [super viewDidLoad];

    days = [[NSArray alloc] initWithObjects:@"Montag", @"Dienstag", @"Mittwoch", @"Donnerstag",
                                            @"Freitag", @"Samstag", @"Sonntag", nil];
    headerViews = [[NSMutableDictionary alloc] init];
    showsGroupedByWeekday = [[NSMutableDictionary alloc] init];

    [table registerNib:[UINib nibWithNibName:@"ShowTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ShowCellIdentifier];
    //[self scrollToCurrentWeekday];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self refreshTimetable];
}

- (void)refreshTimetable {
    [self.activityView startAnimating];
    [self.viewDelegate refreshTimetable];
}

- (void)setTimetable:(Timetable *)timetable {
    [self.activityView stopAnimating];
    [self updateTableWithTimetable:timetable];
}

- (void)updateTableWithTimetable:(Timetable *)timetable {
    [showsGroupedByWeekday removeAllObjects];
    for (Show *show in timetable.shows) {
        [self addShow:show];
    }

    [table reloadData];
}

- (NSMutableArray *)arrayForWeekday:(Weekday)weekday {
    id key = [[NSNumber numberWithInteger:weekday] stringValue];
    NSMutableArray *array = [showsGroupedByWeekday objectForKey:key];
    
    if (array == nil) {
        array = [[[NSMutableArray alloc] init] autorelease];
        [showsGroupedByWeekday setObject:array forKey:key];
    }

    return array;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    id key = [[NSNumber numberWithInt:section] stringValue];
    UILabel *label = [headerViews objectForKey:key];

    if (label != nil) {
        return label;
    }
    
    label = [[[UILabel alloc] init] autorelease];
    label.text = [self tableView:tableView titleForHeaderInSection:section];
    label.backgroundColor = [UIColor colorWithRed:0x00000033/255.0f
                                            green:0x00000033/255.0f
                                             blue:0x00000033/255.0f alpha:1];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"Arial-BoldMT" size:17];

    [headerViews setObject:label forKey:key];
    return label;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSArray *showsOnWeekday = [self arrayForWeekday:(Weekday)section];
    return showsOnWeekday.count > 0 ? UITableViewAutomaticDimension : 0;
}

- (void)addShow:(Show *)show {
    NSMutableArray *array = [self arrayForWeekday:show.weekday];
    [array addObject:show];
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
    NSArray *showsOnWeekday = [self arrayForWeekday:(Weekday)indexPath.section];
    Show *show = [showsOnWeekday objectAtIndex:indexPath.row];

    ShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ShowCellIdentifier];
    cell.showNameLabel.text = show.title;
    cell.showDescriptionLabel.text = show.showDescription;
    cell.startTimeLabel.text = show.startTime;

    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *showsOnWeekday = [self arrayForWeekday:(Weekday)section];
    return showsOnWeekday.count;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return YES;
}

- (void)dealloc {
    [super dealloc];

    [days release];
    [showsGroupedByWeekday release];
    [headerViews release];
}

@end