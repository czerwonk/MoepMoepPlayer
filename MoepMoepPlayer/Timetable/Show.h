//
//  Show
//
//  Created by Daniel Czerwonk on 3/3/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    Monday = 0,
    Tuesday = 1,
    Wednesday = 2,
    Thursday = 3,
    Friday = 4,
    Saturday = 5,
    Sunday = 6
} Weekday;

@interface Show : NSObject {

}

@property (copy) NSString *title;
@property (copy) NSString *showDescription;
@property (copy) NSString *startTime;
@property (nonatomic) Weekday weekday;

@end