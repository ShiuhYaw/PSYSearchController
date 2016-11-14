//
//  PSYSearchPresenter.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYSearchPresenter.h"
#import "PSYSearchInteractor.h"
#import "PSYSearchViewInterface.h"
#import "PSYSearchWireframe.h"

@implementation PSYSearchPresenter

#pragma mark PSYSearchModuleInterface

- (void)updateView {
    
    [self.searchInteractor findPlaces];
}

- (void)updateViewWithPredicate:(NSPredicate *)predicate category:(PSYCategory *)givenCategory sortProperty:(NSString *)sortProperty {
    
    [self.searchInteractor findPlaceWithPredicate:predicate
                                         category:givenCategory
                                     sortProperty:sortProperty];
}

- (void)updateViewWithSortProperty:(NSString *)sortProperty {
    
    [self.searchInteractor findPlaceWithSortProperty:sortProperty];
}

- (void)addPlace {
    
}

#pragma mark PSYSearchInteractorOutput

- (void)foundPlaces:(RLMResults *)places {
    
    if (places.count > 0) {
        [self.userInterface showPlacesData:places];
        return;
    }
    [self.userInterface showNoContentMessage];
    return;
}


@end
