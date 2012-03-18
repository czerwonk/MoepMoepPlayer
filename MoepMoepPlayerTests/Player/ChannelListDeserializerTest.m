//
//  StreamListDeserializerTest
//
//  Created by Daniel Czerwonk on 3/10/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
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