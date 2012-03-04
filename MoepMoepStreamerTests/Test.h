//
//  Test
//
//  Created by Daniel Czerwonk on 3/4/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SenTestingKit/SenTestingKit.h>

#define HC_SHORTHAND
#import <OCHamcrestIOS/OCHamcrestIOS.h>
#import <OCMock/OCMock.h>


@interface Test : SenTestCase

- (void)verifyMockExpectations:(id)mock;

@end