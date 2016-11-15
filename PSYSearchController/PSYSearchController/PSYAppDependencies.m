//
//  PSYAppDependencies.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYAppDependencies.h"
#import "PSYRootWireframe.h"
#import "PSYDataStore.h"

#import "PSYPlaceDataManager.h"
#import "PSYSearchInteractor.h"
#import "PSYSearchPresenter.h"
#import "PSYSearchWireframe.h"
#import "PSYCategory.h"
#import "PSYPlace.h"

@interface PSYAppDependencies()

@property (nonatomic, strong) PSYSearchWireframe *searchWireframe;

@end

@implementation PSYAppDependencies

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self categoryDummy];
        [self placeDummy];
        [self configureDependencies];
    }
    return self;
}

- (void)configureDependencies {
    
    // Root Level Classes
    PSYDataStore *dataStore = [[PSYDataStore alloc] init];
    PSYRootWireframe *rootWireframe = [[PSYRootWireframe alloc] init];
    
    // Search Modules Classes
    PSYSearchWireframe *searchWireframe = [[PSYSearchWireframe alloc] init];
    PSYSearchPresenter *searchPresenter = [[PSYSearchPresenter alloc] init];
    PSYPlaceDataManager *spaceDataManager = [[PSYPlaceDataManager alloc] init];
    PSYSearchInteractor *searchInteractor = [[PSYSearchInteractor alloc] initDataManager:spaceDataManager];
    
    // Search Module Classes
    searchInteractor.output = searchPresenter;
    
    searchPresenter.searchInteractor = searchInteractor;
    searchPresenter.searchWireframe = searchWireframe;
    
    searchWireframe.searchPresenter = searchPresenter;
    searchWireframe.rootWireframe = rootWireframe;
    self.searchWireframe = searchWireframe;
    
    spaceDataManager.dataStore = dataStore;
    
}

- (void)installRootViewControllerInWindow:(UIWindow *)window {
 
    [self.searchWireframe presentSearchInterfaceFromWindow:window];
}

- (void)categoryDummy {
    
    PSYDataStore *dataStore = [[PSYDataStore alloc] init];

    PSYCategory *category = [[PSYCategory alloc] init];
    category.categoryId = 1;
    category.name = @"Tourist Attractions";
    [dataStore save:category];
    
    category = [[PSYCategory alloc] init];
    category.categoryId = 2;
    category.name = @"Restaurants & Cafes";
    [dataStore save:category];

    category = [[PSYCategory alloc] init];
    category.categoryId = 3;
    category.name = @"Shop";
    [dataStore save:category];
    
    category = [[PSYCategory alloc] init];
    category.categoryId = 4;
    category.name = @"Spa & Beauty";
    [dataStore save:category];

    category = [[PSYCategory alloc] init];
    category.categoryId = 5;
    category.name = @"Others";
    [dataStore save:category];
    
}

- (void)placeDummy {
    
    PSYDataStore *dataStore = [[PSYDataStore alloc] init];

    int i;
    for (i = 1; i < 11; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"Sentosa %d", i];
        place.picture = nil;
        place.rate = @(1);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(1)];
        [dataStore save:place];
    }
    for (i = 11; i < 21; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"Merlion %d", i];
        place.picture = nil;
        place.rate = @(2);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(1)];
        [dataStore save:place];
    }
    for (i = 21; i < 31; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"Coastes %d", i];
        place.picture = nil;
        place.rate = @(3);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(1)];
        [dataStore save:place];
    }
    for (i = 31; i < 41; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"Singapore Philatelic Musuem %d", i];
        place.picture = nil;
        place.rate = @(4);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(1)];
        [dataStore save:place];
    }
    for (i = 41; i < 51; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"Fort Canning %d", i];
        place.picture = nil;
        place.rate = @(5);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(1)];
        [dataStore save:place];
    }
    for (i = 51; i < 61; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"National Musuem of Singapore %d", i];
        place.picture = nil;
        place.rate = @(1);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(2)];
        [dataStore save:place];
    }
    for (i = 61; i < 71; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"St. Andrew's Cathedral %d", i];
        place.picture = nil;
        place.rate = @(2);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(2)];
        [dataStore save:place];
    }
    for (i = 71; i < 81; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"Armenian Church of Saint Gregory the Illuminator %d", i];
        place.picture = nil;
        place.rate = @(3);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(2)];
        [dataStore save:place];
    }
    for (i = 81; i < 91; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"Peranakan Museum %d", i];
        place.picture = nil;
        place.rate = @(4);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(2)];
        [dataStore save:place];
    }
    for (i = 91; i < 101; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"Singapore of Art Musuem %d", i];
        place.picture = nil;
        place.rate = @(5);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(2)];
        [dataStore save:place];
    }
    for (i = 101; i < 111; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"Kwan lm Thong Hood Cho Temple %d", i];
        place.picture = nil;
        place.rate = @(4);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(3)];
        [dataStore save:place];
    }
    for (i = 111; i < 121; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"Masjid Sultan %d", i];
        place.picture = nil;
        place.rate = @(4);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(4)];
        [dataStore save:place];
    }
    for (i = 121; i < 131; i++) {
        PSYPlace *place = [[PSYPlace alloc] init];
        place.placeId = i;
        place.name = [NSString stringWithFormat:@"Chinatown Heritage Centre %d", i];
        place.picture = nil;
        place.rate = @(4);
        place.updatedDate = [[NSDate date] dateByAddingTimeInterval:i];
        place.longitude = @(123.123131);
        place.latitude = @(3123.34234);
        place.distance = @(21312);
        place.category = [PSYCategory objectForPrimaryKey:@(5)];
        [dataStore save:place];
    }


}

@end
