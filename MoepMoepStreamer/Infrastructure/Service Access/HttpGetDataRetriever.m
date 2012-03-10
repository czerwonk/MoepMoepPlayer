//
//  HttpGetDataRetriever
//
//  Created by Daniel Czerwonk on 3/9/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
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
    id object = [self.deserializer deserializeResponse:data];
    [self.delegate retriever:self retrievedData:object];
}

- (void)dealloc {
    [super dealloc];

    [deserializer release];
    [delegate release];
    [url release];
}

@end