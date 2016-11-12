//
//  PSYPlaceDataManager.h
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PSYArea.h"
#import "PSYCategory.h"
#import "PSYSortAttribute.h"

@class PSYDataStore;

typedef void(^PSYPlaceDataManagerFetchEntriesBlock)(NSArray *entries);

@interface PSYPlaceDataManager : NSObject

@property (nonatomic, strong) PSYDataStore *dataStore;

- (void)getPlacesWithArea:(PSYArea *)area
                 category:(PSYCategory *)category
                     sort:(PSYSortAttribute *)sort
          completionBlock:(void(^)(NSArray * places))completionBlock;

@end
