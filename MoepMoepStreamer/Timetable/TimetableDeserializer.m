//
//  TimetableDeserializer
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "TimetableDeserializer.h"
#import "Timetable.h"
#import "Show.h"


@interface TimetableDeserializer ()

- (void)parseShowsFromData:(NSData *)data andAddToArray:(NSMutableArray *)array;

@end

@implementation TimetableDeserializer

- (id)deserializeResponse:(NSData *)body {
    Timetable *timetable = [[[Timetable alloc] init] autorelease];

    NSMutableArray *array = [[NSMutableArray alloc] init];
    [self parseShowsFromData:body andAddToArray:array];
    timetable.shows = array;
    [array release];

    return timetable;
}

- (void)parseShowsFromData:(NSData *)data andAddToArray:(NSMutableArray *)array {
    Show *show = [[Show alloc] init];
    show.startTime = @"22:30";
    show.showDescription = @"mit @JulP83 und @Riotburnz";
    show.title = @"#keinPorncast";
    show.weekday = Monday;

    [array addObject:show];
}

@end