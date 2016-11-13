//
//  PSYPlaceDataManager.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYPlaceDataManager.h"

@implementation PSYPlaceDataManager

- (void)getPlacesWithString:(NSString *)searchString
                   category:(PSYCategory *)category
               sortProperty:(NSString *)sortProperty
            completionBlock:(void(^)(RLMResults * places))completionBlock{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"(category.name = %@) AND name = %@", category.name, searchString];
    NSString *sort = sortProperty;
    [self.dataStore fetchEntriesWithPredicate:predicate
                                 sortProperty:sort
                              completionBlock:^(RLMResults *results) {
                                  if (completionBlock) {
                                      completionBlock(results);
                                  }
                              }];
}
@end
