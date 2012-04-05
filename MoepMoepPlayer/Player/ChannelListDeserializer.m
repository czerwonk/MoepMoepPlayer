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

#import "ChannelListDeserializer.h"
#import "Channel.h"
#import "ErrorFactory.h"


@interface ChannelListDeserializer ()

- (Channel *)newChannelFromDictionary:(NSDictionary *)dictionary;

- (void)fillStreamUrlsOfChannel:(Channel *)channel byFlavors:(NSArray *)flavors;

- (void)setStreamUrlOfChannel:(Channel *)channel byFlavor:(NSDictionary *)flavor;

@end

@implementation ChannelListDeserializer

- (id)deserializeResponse:(NSData *)body error:(NSError **)error {
    NSError *theError = nil;
    id dictionary =  [NSJSONSerialization JSONObjectWithData:body options:0 error:&theError];
    
    if (dictionary == nil) {
        NSLog(@"Error parsing channels: %@", theError.localizedDescription);

        if (error != NULL) {
            *error = [ErrorFactory errorWithLocalizedDescription:NSLocalizedString(@"ParsingFailed", nil)];
        }

        return nil;
    }

    NSDictionary *streamsDictionary = [dictionary objectForKey:@"streams"];
    NSArray *channelArray = [streamsDictionary objectForKey:@"channel"];

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