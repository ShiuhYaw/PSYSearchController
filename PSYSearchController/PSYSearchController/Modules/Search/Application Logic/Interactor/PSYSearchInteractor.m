//
//  PSYSearchInteractor.m
//  PSYSearchController
//
//  Created by Shiuh Yaw Phang on 12/11/2016.
//  Copyright © 2016 Shiuh Yaw Phang. All rights reserved.
//

#import "PSYSearchInteractor.h"

@interface PSYSearchInteractor()

@property (nonatomic, strong) PSYPlaceDataManager *dataManager;

@end

@implementation PSYSearchInteractor

- (instancetype)initDataManager:(PSYPlaceDataManager *)dataManager
{
    self = [super init];
    if (self) {
        _dataManager = dataManager;
    }
    return self;
}

@end
