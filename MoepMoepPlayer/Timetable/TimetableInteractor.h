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

#import <Foundation/Foundation.h>
#import "TimetableView.h"
#import "TimetableViewDelegate.h"
#import "DataRetriever.h"
#import "InteractorBase.h"


@interface TimetableInteractor : InteractorBase<TimetableViewDelegate, DataRetrieverDelegate> {
    @private
    id<DataRetriever> dataRetriever;
    id<TimetableView> view;
}

@property (nonatomic, retain) id<TimetableView> view;
@property (nonatomic, retain) id<DataRetriever> dataRetriever;

- (id)initWithDataRetriever:(id<DataRetriever>)retriever;

@end