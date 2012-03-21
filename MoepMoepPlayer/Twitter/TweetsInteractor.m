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

#import "TweetsInteractor.h"
#import "DataRetriever.h"
#import "TweetsView.h"


@implementation TweetsInteractor

@synthesize dataRetriever;
@synthesize view;

- (void)refreshTweets {

}

- (void)retriever:(id <DataRetriever>)retriever retrievedData:(id)object {

}

- (void)retriever:(id <DataRetriever>)retriever failedRetrievingData:(NSError *)error {

}

- (void)dealloc {
    [super dealloc];

    [view release];
    [dataRetriever release];
}

@end