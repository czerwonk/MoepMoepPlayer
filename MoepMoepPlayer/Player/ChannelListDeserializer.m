//
//  StreamListDeserializer
//
//  Created by Daniel Czerwonk on 3/10/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "ChannelListDeserializer.h"
#import "Channel.h"
#import "NSObject+SBJson.h"
#import "ErrorFactory.h"


@interface ChannelListDeserializer ()

- (Channel *)newStreamFromDictionary:(NSDictionary *)dictionary;

@end

@implementation ChannelListDeserializer

- (id)deserializeResponse:(NSData *)body error:(NSError **)error {
    NSString *json = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
    id streamsDictionary = [json JSONValue];
    [json release];
    
    if (streamsDictionary == nil && error != NULL) {
        *error = [ErrorFactory errorWithLocalizedDescription:NSLocalizedString(@"ParsingFailed", nil)];
        return nil;
    }

    NSDictionary *arrayDictionary = [streamsDictionary objectForKey:@"streams"];
    NSArray *channelArray = [arrayDictionary objectForKey:@"stream"];

    NSMutableArray *streams = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSDictionary *streamDictionary in channelArray) {
        Channel *stream = [self newStreamFromDictionary:streamDictionary];
        [streams addObject:stream];
        [stream release];
    }
    
    return streams;
}

- (Channel *)newStreamFromDictionary:(NSDictionary *)dictionary {
    Channel *stream = [[Channel alloc] init];
    stream.name = [dictionary objectForKey:@"name"];
    stream.mainStreamUrl = [dictionary objectForKey:@"url"];
    stream.mobileStreamUrl = [dictionary objectForKey:@"mobile"];

    return stream;
}

@end