//
//  PSYSearchInteractor.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYSearchInteractor.h"
#import "PSYCategory.h"
#import "PSYPlaceDataManager.h"

@interface PSYSearchInteractor()

@property (nonatomic, strong) PSYPlaceDataManager *dataManager;
@property (nonatomic, strong) PSYCategory *defaultCategory;
@property (nonatomic, strong) NSString *sortProperty ;
@property (nonatomic, strong) RLMResults *places ;
@property (nonatomic, strong) NSPredicate *currentPreducate;
@property (nonatomic, strong) NSTimer * searchTimer;
@end

@implementation PSYSearchInteractor

- (instancetype)initDataManager:(PSYPlaceDataManager *)dataManager
{
    self = [super init];
    if (self) {
        _dataManager = dataManager;
        _sortProperty = @"name";
        _defaultCategory = [PSYCategory objectForPrimaryKey:@(1)];
        _searchTimer = nil;
    }
    return self;
}

#pragma mark - PSYSearchInteractorInput

- (void)findPlaces {
    
    __weak typeof(self) welf = self;
    [self.dataManager getPlacesWithString:@""
                                 category:self.defaultCategory
                             sortProperty:self.sortProperty
                          completionBlock:^(RLMResults * places){
                              welf.places = places;
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [welf.output foundPlaces:places];
                              });
                          }];
}

- (void)findPlaceWithPredicate:(NSPredicate *)predicate category:(PSYCategory *)givenCategory sortProperty:(NSString *)givenSortProperty {
    
    NSString *sortProperty = self.sortProperty;
    if (givenSortProperty != nil) {
        sortProperty =  givenSortProperty;
        self.sortProperty = givenSortProperty;
    }
    if (givenCategory == nil) {
        givenCategory = self.defaultCategory;
    }
    else {
        self.defaultCategory = givenCategory;
    }
    self.currentPreducate = predicate;
    [self fireSearchTimer];
//    __weak typeof(self) welf = self;
//    [self.dataManager getPlacesWithPredicate:predicate
//                                    category:givenCategory
//                                sortProperty:sortProperty
//                             completionBlock:^(RLMResults *places) {
//                                 welf.places = places;
//                                 dispatch_async(dispatch_get_main_queue(), ^{
//                                     [welf.output foundPlaces:places];
//                                 });
//
//    }];
}

-(void)fireSearchTimer {
    
    if (self.searchTimer == nil) {
        __weak typeof(self) welf = self;
        self.searchTimer = [NSTimer timerWithTimeInterval:2 repeats:false block:^(NSTimer * _Nonnull timer) {
            [welf.dataManager getPlacesWithPredicate:welf.currentPreducate
                                            category:welf.defaultCategory
                                        sortProperty:welf.sortProperty
                                     completionBlock:^(RLMResults *places) {
                                         welf.places = places;
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             [welf.output foundPlaces:places];
                                         });
             }];
            [welf.searchTimer invalidate];
            welf.searchTimer = nil;
        }];
        [self.searchTimer fire];
    }
    else {
        [self.searchTimer invalidate];
        self.searchTimer = nil;
        [self fireSearchTimer];
    }
}


- (void)findPlaceWithSearchString:(NSString *)string category:(PSYCategory *)givenCategory sortProperty:(NSString *)givenSortProperty {
    
    NSString *searchString = @"";
    NSString *sortProperty = self.sortProperty;
    if (string != nil && string.length > 0) {
        searchString = string;
    }
    if (givenCategory == nil) {
        givenCategory = self.defaultCategory;
    }
    else {
        self.defaultCategory = givenCategory;
    }
    if (givenSortProperty != nil) {
        sortProperty = givenSortProperty;
        self.sortProperty = givenSortProperty;
    }
    __weak typeof(self) welf = self;
    [self.dataManager getPlacesWithString:searchString
                                 category:givenCategory
                             sortProperty:sortProperty
                          completionBlock:^(RLMResults * places){
                              welf.places = places;
                              dispatch_async(dispatch_get_main_queue(), ^{
                                  [welf.output foundPlaces:places];
                              });
                          }];
}

- (void)findPlaceWithSortProperty:(NSString *)givenSortProperty {
    
    self.sortProperty = givenSortProperty;
    if (self.places.count > 0) {
        self.places = [self.places sortedResultsUsingProperty:givenSortProperty ascending:true];
        [self.output foundPlaces:self.places];
    }
    else {
        [self findPlaceWithPredicate:nil category:nil sortProperty:givenSortProperty];
    }
}

- (void)findPlaceWithCategory:(PSYCategory *)givenCategory {
    
        self.defaultCategory = givenCategory;
        __weak typeof(self) welf = self;
        [self.dataManager getPlacesWithPredicate:self.currentPreducate
                                        category:givenCategory
                                    sortProperty:self.sortProperty
                                 completionBlock:^(RLMResults *places) {
                                     welf.places = places;
                                     dispatch_async(dispatch_get_main_queue(), ^{
                                         [welf.output foundPlaces:places];
                                     });
                                 }];

}

@end
