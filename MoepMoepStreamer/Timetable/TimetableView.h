//
//  SendeplanView
//
//  Created by Daniel Czerwonk on 3/3/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "View.h"
#import "TimetableViewDelegate.h"

@class Timetable;

@protocol TimetableView<View>

@property (nonatomic, retain) id<TimetableViewDelegate> viewDelegate;

- (void)setTimetable:(Timetable *)timetable;

@end