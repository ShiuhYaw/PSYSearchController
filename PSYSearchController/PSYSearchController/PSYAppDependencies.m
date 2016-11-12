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

@interface PSYAppDependencies()

@property (nonatomic, strong) PSYSearchWireframe *searchWireframe;

@end

@implementation PSYAppDependencies

- (instancetype)init
{
    self = [super init];
    if (self) {
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
    PSYSearchInteractor *searchInteractor = [[PSYSearchInteractor alloc] init];
    
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

@end
