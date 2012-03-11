//
//  ErrorFactory
//
//  Created by Daniel Czerwonk on 3/11/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ErrorFactory : NSObject {

}

+ (NSError *)errorWithLocalizedDescription:(NSString *)localizedDescription;

@end