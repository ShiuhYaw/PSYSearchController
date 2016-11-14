//
//  PSYPlaceDataManager.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYPlaceDataManager.h"
#import "PSYCategory.h"
#import "PSYDataStore.h"

@implementation PSYPlaceDataManager

- (void)getDefaultCategoryCompletionBlock:(void(^)(PSYCategory * category))completionBlock {
    
    [self.dataStore fetchDefaultCategoryCompletionBlock:^(PSYCategory *results) {
        if (completionBlock) {
            completionBlock(results);
        }
    }];
}

- (void)getPlacesWithString:(NSString *)searchString
                   category:(PSYCategory *)category
               sortProperty:(NSString *)sortProperty
            completionBlock:(void(^)(RLMResults * places))completionBlock{

    NSPredicate *predicate = nil;
    if (searchString.length > 0) {
        predicate = [NSPredicate predicateWithFormat:@"(category.name = %@) AND name = %@", category.name, searchString];
    }
    else {
        predicate = [NSPredicate predicateWithFormat:@"(category.name = %@)", category.name];
    }
    [self.dataStore fetchEntriesWithPredicate:predicate
                                 sortProperty:sortProperty
                              completionBlock:^(RLMResults *results) {
                                  if (completionBlock) {
                                      completionBlock(results);
                                  }
                              }];
}


- (void)getPlacesWithPredicate:(NSPredicate *)predicate
                   category:(PSYCategory *)category
               sortProperty:(NSString *)sortProperty
            completionBlock:(void(^)(RLMResults * places))completionBlock {
    
    [self.dataStore fetchEntriesWithPredicate:predicate
                                 sortProperty:sortProperty
                              completionBlock:^(RLMResults *results) {
                                  if (completionBlock) {
                                      completionBlock(results);
                                  }
                              }];
}


@end
