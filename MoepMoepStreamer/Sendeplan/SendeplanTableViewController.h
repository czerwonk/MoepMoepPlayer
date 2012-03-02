//
//  SendeplanTableViewController
//
//  Created by Daniel Czerwonk on 3/1/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface SendeplanTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    @private
    NSArray *days;
}

@property (nonatomic, retain) IBOutlet UITableView *table;

@end