//
//  TimetableDataRetriever
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import "TimetableDataRetriever.h"


@interface TimetableDataRetriever ()

- (void)deserializeAndReturnData:(NSData *)data;

@end

@implementation TimetableDataRetriever

@synthesize deserializer;
@synthesize delegate;

- (void)retrieveDataAsynchronous {
     NSURL *url = [[NSURL alloc] initWithString:@"http://www.moepmoep.org/streamerapp/sendeplan.txt"];
     NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
     [url release];

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

@end