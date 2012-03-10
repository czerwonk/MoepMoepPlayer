//
//  StreamListDeserializer
//
//  Created by Daniel Czerwonk on 3/10/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "StreamListDeserializer.h"
#import "Stream.h"
#import "NSObject+SBJson.h"


@interface StreamListDeserializer ()

- (Stream *)newStreamFromDictionary:(NSDictionary *)dictionary;

@end

@implementation StreamListDeserializer

- (id)deserializeResponse:(NSData *)body {
    NSString *json = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    id streamsDictionary = [json JSONValue];
    [json release];

    NSDictionary *arrayDictionary = [streamsDictionary objectForKey:@"streams"];
    NSArray *streamsArray = [arrayDictionary objectForKey:@"stream"];

    NSMutableArray *streams = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSDictionary *streamDictionary in streamsArray) {
        Stream *stream = [self newStreamFromDictionary:streamDictionary];
        [streams addObject:stream];
        [stream release];
    }
    
    return streams;
}

- (Stream *)newStreamFromDictionary:(NSDictionary *)dictionary {
    Stream *stream = [[Stream alloc] init];
    stream.name = [dictionary objectForKey:@"name"];
    stream.mainStreamUrl = [dictionary objectForKey:@"url"];
    stream.mobileStreamUrl = [dictionary objectForKey:@"mobile_url"];

    return stream;
}

@end