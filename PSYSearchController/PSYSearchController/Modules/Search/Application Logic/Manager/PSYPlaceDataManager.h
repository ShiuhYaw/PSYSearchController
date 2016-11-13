//
//  PSYPlaceDataManager.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <Realm/Realm.h>
#import "PSYArea.h"
#import "PSYCategory.h"
#import "PSYDataStore.h"

typedef void(^PSYPlaceDataManagerFetchEntriesBlock)(RLMResults *entries);

@interface PSYPlaceDataManager : NSObject

@property (nonatomic, strong) PSYDataStore *dataStore;

- (void)getPlacesWithString:(NSString *)searchString
                   category:(PSYCategory *)category
               sortProperty:(NSString *)sortProperty
            completionBlock:(void(^)(RLMResults * places))completionBlock;

@end
