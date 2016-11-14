//
//  PSYDataStore.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 13/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSYCategory.h"

typedef void(^PSYDataStoreFetchCompletionBlock)(RLMResults *results);
typedef void(^PSYCategoryFetchCompletionBlock)(PSYCategory *results);

@interface PSYDataStore : NSObject

- (void)fetchDefaultCategoryCompletionBlock:(PSYCategoryFetchCompletionBlock)completionBlock;

- (void)fetchEntriesWithPredicate:(NSPredicate *)predicate
                     sortProperty:(NSString *)property
                  completionBlock:(PSYDataStoreFetchCompletionBlock)completionBlock;
- (void)save:(RLMObject *)object;
@end
