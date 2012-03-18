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

#import "TimetableDeserializer.h"
#import "Timetable.h"
#import "Show.h"


@interface TimetableDeserializer ()

- (void)parseShowsFromData:(NSData *)data andAddToArray:(NSMutableArray *)array;

- (Weekday)weekdayForString:(NSString *)weekdayString;

@end

@implementation TimetableDeserializer

- (id)deserializeResponse:(NSData *)body error:(NSError **)error {
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
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:@"(Montag|Dienstag|Mittwoch|Donnerstag|Freitag|Samstag|Sonntags?)|(\\d{1,2}:\\d{2})[^#]+(#[^ ,]+)([^\\r]+)?"
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
            show.startTime = [body substringWithRange:[match rangeAtIndex:2]];
            show.title = [body substringWithRange:[match rangeAtIndex:3]];
            show.showDescription = [body substringWithRange:[match rangeAtIndex:4]];
            show.weekday = weekday;

            [array addObject:show];
            [show release];
        }
    }

    [body release];
    [regex release];
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