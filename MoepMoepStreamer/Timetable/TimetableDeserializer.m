//
//  TimetableDeserializer
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <SBJson/SBJson.h>
#import "TimetableDeserializer.h"
#import "Timetable.h"
#import "Show.h"


@interface TimetableDeserializer ()

- (void)parseShowsFromData:(NSData *)data andAddToArray:(NSMutableArray *)array;

- (Weekday)weekdayForString:(NSString *)weekdayString;

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
    NSString *body = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];

    NSError *error = nil;
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"(Montag|Dienstag|Mittwoch|Donnerstag|Freitag|Samstag|Sontag\r\n)|((\\d{2}:\\d{2}) (#[^ ]+) (mit )?([^\r]+))"
                                                                      options:NSRegularExpressionCaseInsensitive error:&error];
    NSArray *matches = [regex matchesInString:body options:0 range:NSMakeRange(0, body.length)];

    Weekday weekday = Monday;

    for (NSTextCheckingResult *match in matches) {
        NSRange weekdayRange = [match rangeAtIndex:1];

        if (weekdayRange.length > 0) {
            weekday = [self weekdayForString:[body substringWithRange:weekdayRange]];
        }
        else {
            Show *show = [[Show alloc] init];
            show.startTime = [body substringWithRange:[match rangeAtIndex:3]];
            show.title = [body substringWithRange:[match rangeAtIndex:4]];
            show.showDescription = [body substringWithRange:[match rangeAtIndex:6]];
            show.weekday = weekday;

            [array addObject:show];
            [show release];
        }
    }

    [body release];
}

- (Weekday)weekdayForString:(NSString *)weekdayString {
    if ([weekdayString isEqualToString:@"Montag"]) {
        return 0;
    }
    if ([weekdayString isEqualToString:@"Dienstag"]) {
        return 1;
    }
    if ([weekdayString isEqualToString:@"Mittwoch"]) {
        return 2;
    }
    if ([weekdayString isEqualToString:@"Donnerstag"]) {
        return 3;
    }
    if ([weekdayString isEqualToString:@"Freitag"]) {
        return 4;
    }
    if ([weekdayString isEqualToString:@"Samstag"]) {
        return 5;
    }
    else {
        return 6;
    }
}

@end