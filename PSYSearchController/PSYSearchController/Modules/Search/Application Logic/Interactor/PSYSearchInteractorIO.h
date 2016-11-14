//
//  PSYSearchInteractorIO.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSYCategory.h"

@protocol PSYSearchInteractorInput <NSObject>
- (void)findPlaces;
- (void)findPlaceWithPredicate:(NSPredicate *)predicate
                      category:(PSYCategory *)givenCategory
                  sortProperty:(NSString *)givenSortProperty;
@end

@protocol PSYSearchInteractorOutput <NSObject>

- (void)foundPlaces:(RLMResults *)places;

@end
