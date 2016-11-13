//
//  PSYDataStore.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 13/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

typedef void(^PSYDataStoreFetchCompletionBlock)(RLMResults *results);

@interface PSYDataStore : NSObject

- (void)fetchEntriesWithPredicate:(NSPredicate *)predicate
                     sortProperty:(NSString *)property
                  completionBlock:(PSYDataStoreFetchCompletionBlock)completionBlock;
- (void)save;
@end
