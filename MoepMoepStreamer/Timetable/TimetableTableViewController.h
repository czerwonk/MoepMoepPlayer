//
//  SendeplanTableViewController
//
//  Created by Daniel Czerwonk on 3/1/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "TimetableView.h"


@interface TimetableTableViewController : BaseViewController<UITableViewDataSource, UITableViewDelegate, TimetableView> {
    @private
    NSArray *days;
    NSMutableDictionary *showsGroupedByWeekday;
    NSMutableDictionary *headerViews;
}

@property (nonatomic, retain) IBOutlet UITableView *table;

@end