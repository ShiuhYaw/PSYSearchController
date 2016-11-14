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

@end

@implementation PSYSearchInteractor

- (instancetype)initDataManager:(PSYPlaceDataManager *)dataManager
{
    self = [super init];
    if (self) {
        _dataManager = dataManager;
        _defaultCategory = [[PSYCategory alloc] init];
        _defaultCategory.name = @"";
    }
    return self;
}

#pragma mark - PSYSearchInteractorInput

- (void)findPlaces {
    
    __weak typeof(self) welf = self;
    [self.dataManager getDefaultCategoryCompletionBlock:^(PSYCategory *category) {
        welf.defaultCategory = category;
    }];
    [self.dataManager getPlacesWithString:@""
                                 category:self.defaultCategory
                             sortProperty:@"name"
                          completionBlock:^(RLMResults * places){
                              [welf.output foundPlaces:places];
                          }];
}

- (void)findPlaceWithPredicate:(NSPredicate *)predicate category:(PSYCategory *)givenCategory sortProperty:(NSString *)givenSortProperty {
    
    NSString *sortProperty = @"name";
    if (givenSortProperty != nil && givenSortProperty.length > 0) {
        sortProperty = givenSortProperty;
    }
    if (givenCategory == nil) {
        givenCategory = self.defaultCategory;
    }
    __weak typeof(self) welf = self;
    [self.dataManager getPlacesWithPredicate:predicate
                                    category:givenCategory
                                sortProperty:sortProperty
                             completionBlock:^(RLMResults *places) {
        [welf.output foundPlaces:places];
    }];
}

- (void)findPlaceWithSearchString:(NSString *)string category:(PSYCategory *)givenCategory sortProperty:(NSString *)givenSortProperty {
    
    NSString *searchString = @"";
    NSString *sortProperty = @"name";
    if (string != nil && string.length > 0) {
        searchString = string;
    }
    if (givenCategory == nil) {
        givenCategory = self.defaultCategory;
    }
    if (givenSortProperty != nil && givenSortProperty.length > 0) {
        sortProperty = givenSortProperty;
    }
    __weak typeof(self) welf = self;
    [self.dataManager getPlacesWithString:searchString
                                 category:givenCategory
                             sortProperty:sortProperty
                          completionBlock:^(RLMResults * places){
                              [welf.output foundPlaces:places];
                          }];
}

@end
