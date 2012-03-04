//
//  Deserializer
//
//  Created by Daniel Czerwonk on 3/3/12.
//  Copyright 2012 Daniel Czerwonk. All rights reserved.
//

@protocol Deserializer<NSObject>

- (id)deserializeResponse:(NSData *)body;

@end