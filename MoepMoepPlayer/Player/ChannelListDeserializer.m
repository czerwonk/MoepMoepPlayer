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

- (Channel *)newChannelFromDictionary:(NSDictionary *)dictionary;

- (void)fillStreamUrlsOfChannel:(Channel *)channel byFlavors:(NSArray *)flavors;

- (void)setStreamUrlOfChannel:(Channel *)channel byFlavor:(NSDictionary *)flavor;

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
    NSArray *channelArray = [arrayDictionary objectForKey:@"channel"];

    NSMutableArray *channels = [[[NSMutableArray alloc] init] autorelease];
    
    for (NSDictionary *streamDictionary in channelArray) {
        Channel *channel = [self newChannelFromDictionary:streamDictionary];
        [channels addObject:channel];
        [channel release];
    }
    
    return channels;
}

- (Channel *)newChannelFromDictionary:(NSDictionary *)dictionary {
    Channel *channel = [[Channel alloc] init];
    channel.name = [dictionary objectForKey:@"name"];

    NSArray *flavors = [dictionary objectForKey:@"flavor"];
    [self fillStreamUrlsOfChannel:channel byFlavors:flavors];

    return channel;
}

- (void)fillStreamUrlsOfChannel:(Channel *)channel byFlavors:(NSArray *)flavorsArray {
    for (NSDictionary *flavor in flavorsArray) {
        [self setStreamUrlOfChannel:channel byFlavor:flavor];
    }
}

- (void)setStreamUrlOfChannel:(Channel *)channel byFlavor:(NSDictionary *)flavorDictionary {
    NSString *type = [flavorDictionary objectForKey:@"type"];
    NSString *url = [flavorDictionary objectForKey:@"url"];

    if ([type isEqualToString:@"main"]) {
        channel.mainStreamUrl = url;
    }
    else if ([type isEqualToString:@"mobile"]) {
        channel.mobileStreamUrl = url;
    }
}

@end