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

#import "TweetsTableViewController.h"
#import "Tweet.h"


@implementation TweetsTableViewController

@synthesize table;
@synthesize viewDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];

    tweets = [[NSMutableArray alloc] init];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    [self startActivityViewWithText:NSLocalizedString(@"Loading", nil)];
    [viewDelegate reloadDataSource];
}

- (void)updateDataSource:(NSArray *)tweetsToShow {
    [self stopActivityView];
    [self refreshTableWithTweets:tweetsToShow];
}

- (void)refreshTableWithTweets:(NSArray *)tweetsToShow {
    [tweets removeAllObjects];
    [tweets addObjectsFromArray:tweetsToShow];

    [table reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = [tweets objectAtIndex:indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TwitterCell"];

    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TwitterCell"] autorelease];
        cell.textLabel.textColor = [UIColor whiteColor];
    }

    cell.textLabel.text = tweet.from;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    Tweet *tweet = [tweets objectAtIndex:indexPath.row];
    [[UIApplication sharedApplication] openURL:tweet.url];
}

- (void)dealloc {
    [super dealloc];

    [table release];
    [viewDelegate release];
    [tweets release];
}

@end