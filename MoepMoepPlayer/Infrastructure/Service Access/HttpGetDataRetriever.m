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

#import "HttpGetDataRetriever.h"


@interface HttpGetDataRetriever ()

- (void)deserializeAndReturnData:(NSData *)data;

@end

@implementation HttpGetDataRetriever

@synthesize deserializer;
@synthesize delegate;

- (id)initWithUrl:(NSString *)urlString {
    self = [super init];
    
    if (self) {
        url = [[NSURL alloc] initWithString:urlString];
    }

    return self;
}

- (void)retrieveDataAsynchronous {
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];

    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:^(NSURLResponse *response,
            NSData *data,
            NSError *error) {
        NSHTTPURLResponse *res = (NSHTTPURLResponse *)response;
        if (res.statusCode == 200) {
            [self deserializeAndReturnData:data];
        }
        else {
            [self.delegate retriever:self failedRetrievingData:error];
        }
    }];

    [request release];
    [queue release];
}

- (void)deserializeAndReturnData:(NSData *)data {
    NSError *error = nil;

    id object = [self.deserializer deserializeResponse:data error:&error];
    
    if (error == nil) {
        [self.delegate retriever:self retrievedData:object];
    }
    else {
        [self.delegate retriever:self failedRetrievingData:error];
    }
}

- (void)dealloc {
    [super dealloc];

    [deserializer release];
    [delegate release];
    [url release];
}

@end