//
//  PSYPlaceDataManager.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class PSYDataStore;
@class PSYCategory;

typedef void(^PSYPlaceDataManagerFetchEntriesBlock)(RLMResults *entries);
typedef void(^PSYCategoryFetchEntriesBlock)(PSYCategory *category);

@interface PSYPlaceDataManager : NSObject

@property (nonatomic, strong) PSYDataStore *dataStore;

- (void)getDefaultCategoryCompletionBlock:(void(^)(PSYCategory * category))completionBlock;

- (void)getPlacesWithString:(NSString *)searchString
                   category:(PSYCategory *)category
               sortProperty:(NSString *)sortProperty
            completionBlock:(void(^)(RLMResults * places))completionBlock;

- (void)getPlacesWithPredicate:(NSPredicate *)predicate
                      category:(PSYCategory *)category
                  sortProperty:(NSString *)sortProperty
               completionBlock:(void(^)(RLMResults * places))completionBlock;

@end
