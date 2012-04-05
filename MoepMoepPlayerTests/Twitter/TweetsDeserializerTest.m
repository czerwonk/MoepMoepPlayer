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

#import "TweetsDeserializerTest.h"
#import "TweetsDeserializer.h"
#import "Tweet.h"


@implementation TweetsDeserializerTest

- (void)testShouldParse {
    NSString *path = [[NSBundle bundleForClass:[TweetsDeserializerTest class]]
            pathForResource:@"twitter" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];

    TweetsDeserializer *deserializer = [[[TweetsDeserializer alloc] init] autorelease];
    NSArray *tweets = [deserializer deserializeResponse:data error:nil];

    STAssertEquals((int)tweets.count, 2, nil);

    Tweet *tweet1 = [tweets objectAtIndex:0];
    assertThat(tweet1.from, is(equalTo(@"Netzgespraeche")));
    assertThat(tweet1.text, is(equalTo(@"RT @Witzman Netzgespräche gleich live: Stream http://t.co/EIpfGWDO http://t.co/EfczG2Dj #Podcast #live #moepmoep")));
    assertThat(tweet1.imageUrl, is(equalTo([NSURL URLWithString:@"https://si0.twimg.com/profile_images/1861898579/podlogo_small_t_normal.png"])));
    assertThat(tweet1.url, is(equalTo([NSURL URLWithString:@"https://twitter.com/#!/Netzgespraeche/status/187976845323550720"])));

    Tweet *tweet2 = [tweets objectAtIndex:1];
    assertThat(tweet2.from, is(equalTo(@"moepmoep")));
    assertThat(tweet2.text, is(equalTo(@"Test-Tweet")));
    assertThat(tweet2.imageUrl, is(equalTo([NSURL URLWithString:@"https://si0.twimg.com/profile_images/422108218/moepmoep.png"])));
}

@end