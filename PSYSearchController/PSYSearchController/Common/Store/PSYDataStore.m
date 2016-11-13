//
//  PSYDataStore.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 13/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYDataStore.h"
#import "PSYPlace.h"

@interface PSYDataStore()

@property (nonatomic, strong) RLMRealm *realm;

@end

@implementation PSYDataStore

- (instancetype)init
{
    self = [super init];
    if (self) {
        _realm = [RLMRealm defaultRealm];
    }
    return self;
}

- (void)fetchEntriesWithPredicate:(NSPredicate *)predicate
                     sortProperty:(NSString *)property
                  completionBlock:(PSYDataStoreFetchCompletionBlock)completionBlock {
    
    RLMResults<PSYPlace *> *places = [[PSYPlace objectsWithPredicate:predicate] sortedResultsUsingProperty:property ascending:true];
    if (completionBlock) {
        completionBlock(places);
    }
}

- (void)save {
    
}

@end
