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

#import "ChannelListDeserializerTest.h"
#import "ChannelListDeserializer.h"
#import "Channel.h"


@implementation ChannelListDeserializerTest

- (void)testShouldParse {
    NSString *path = [[NSBundle bundleForClass:[ChannelListDeserializerTest class]]
            pathForResource:@"streams_test" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];

    ChannelListDeserializer *deserializer = [[[ChannelListDeserializer alloc] init] autorelease];
    NSArray *array = [deserializer deserializeResponse:data error:NULL];

    STAssertEquals((int)array.count, 2, nil);

    Channel *stream1 = [array objectAtIndex:0];
    assertThat(stream1.name, is(equalTo(@"#moep1")));
    assertThat(stream1.mainStreamUrl, is(equalTo(@"http://radio.moepmoep.org:8000/stream.mp3")));
    assertThat(stream1.mobileStreamUrl, is(equalTo(@"http://relay.moepmoep.org:9000/stream2.mp3")));

    Channel *stream2 = [array objectAtIndex:1];
    assertThat(stream2.name, is(equalTo(@"#moep2")));
    assertThat(stream2.mainStreamUrl, is(equalTo(@"http://radio.moepmoep.org:9500/stream4.mp3")));
    assertThat(stream2.mobileStreamUrl, is(equalTo(@"http://relay.moepmoep.org:8500/stream5.mp3")));
}

@end