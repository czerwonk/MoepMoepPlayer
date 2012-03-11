//
//  ErrorFactory
//
//  Created by Daniel Czerwonk on 3/11/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "ErrorFactory.h"


@implementation ErrorFactory

+ (NSError *)errorWithLocalizedDescription:(NSString *)localizedDescription {
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setObject:localizedDescription forKey:NSLocalizedDescriptionKey];
    NSError *error = [NSError errorWithDomain:@"MoepMoepApp" code:0 userInfo:dictionary];
    [dictionary release];
    
    return error;
}

@end