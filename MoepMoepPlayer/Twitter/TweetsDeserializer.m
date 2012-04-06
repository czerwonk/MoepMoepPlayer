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

#import "TweetsDeserializer.h"
#import "ErrorFactory.h"
#import "Tweet.h"


@interface TweetsDeserializer ()

- (NSArray *)parseResults:(NSArray *)results;

- (Tweet *)newTweetFromDictionary:(NSDictionary *)dictionary;

@end

@implementation TweetsDeserializer

- (id)deserializeResponse:(NSData *)body error:(NSError **)error {
    NSError *theError = nil;
    id dictionary =  [NSJSONSerialization JSONObjectWithData:body options:0 error:&theError];

    if (dictionary == nil) {
        NSLog(@"Error parsing tweets: %@", theError.localizedDescription);

        if (error != NULL) {
            *error = [ErrorFactory errorWithLocalizedDescription:NSLocalizedString(@"ParsingFailed", nil)];
        }

        return nil;
    }

    NSArray *resultsDictionary = [dictionary objectForKey:@"results"];
    return [self parseResults:resultsDictionary];
}

- (NSArray *)parseResults:(NSArray *)results {
    NSMutableArray *tweets = [[[NSMutableArray alloc] init] autorelease];

    for (NSDictionary *tweetDictionary in results) {
        Tweet *tweet = [self newTweetFromDictionary:tweetDictionary];
        [tweets addObject:tweet];
        [tweet release];
    }

    return tweets;
}

- (Tweet *)newTweetFromDictionary:(NSDictionary *)dictionary {
    Tweet *tweet = [[Tweet alloc] init];
    tweet.from = [dictionary objectForKey:@"from_user"];
    tweet.text = [dictionary objectForKey:@"text"];

    NSString *urlString = [NSString stringWithFormat:@"twitter://twitter.com/#!/%@/status/187976845323550720",
                                                     tweet.from, [dictionary objectForKey:@"id_str"]];
    tweet.url = [NSURL URLWithString:urlString];

    NSString *imageUrlString = [dictionary objectForKey:@"profile_image_url_https"];
    tweet.imageUrl = [NSURL URLWithString:imageUrlString];

    return tweet;
}

@end